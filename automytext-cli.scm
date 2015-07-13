
(import (scheme base)
        (scheme load)
        (scheme write)
        (scheme process-context)
	(srfi 1))

(load "./autokey.scm")

(define (usage)
  (display "Usage: automytext [options] [-e] <plaintext> <key>
       automytext [options] -d <ciphertext> <key>

Options:
  -h   Display this help text.
  -i=? Set the number of iterations.
  -p   Preserve the punctuation of the original message.
  -v   Display the version of the software.\n")
  (exit))

(define (extract-iterations args)
  (let loop ((list-out '())
	     (list-in args))
    (if (null? list-in)
	(values args 1)
	(let ((value (car list-in)))
	  (if (and (char=? (string-ref value 0) #\-)
		   (char=? (string-ref value 1) #\i))
	      (if (not (char=? (string-ref value 2) #\=))
		  (usage)
		  (values (append list-out
				  (cdr list-in))
			  (string->number (substring value 3 (string-length value)))))
	      (loop (cons value list-out) (cdr list-in)))))))

(define (extract-mode args)
  (if (member "-d" args)
      (values (delete "-d" args)
	      'decipher)
      (values (if (member "-e" args)
		  (delete "-e" args)
		  args)
	      'encipher)))

(define (extract-punct args)
  (if (member "-p" args)
      (values (delete "-p" args)
	      #t)
      (values args #f)))

(define (main-prog args)
  (define-values (arg-iter iters)
    (extract-iterations args))
  (define-values (arg-mode cipher-mode)
    (extract-mode arg-iter))
  (define-values (new-args punctuate)
    (extract-punct arg-mode))
  (display new-args) (newline) (display iters) (newline) (display cipher-mode) (newline)
  (display punctuate) (newline)
  (if (< iters 1)
      (error "automytext-cli" "Iterations must be at least 1."))
  (if (or (member "--help" new-args)
          (member "-h" new-args))
      (usage))
  (if (or (member "--version" new-args)
          (member "-v" new-args))
      (version)))

(main-prog (cdr (command-line)))

#|


    punctuate = False
    if ("-p" in args):
        punctuate = True
        args.remove("-p")

    # Check to see if there are any undetected options
    for i in args:
        if (len(i) > 1):
            if (i[0] == '-'):
                print("Unknown option {0}".format(i))
                exit(0)

    if (len(args) != 2):
        usage()

    text = args[0]
    key = args[1]

    for i in range(iterate):
        a = ''
        if (mode == 0):
            a = encipher(text, key)
        else:
            a = decipher(text, key)
        text = a
    if punctuate:
        a = restore_punctuation(args[0], a)
        print(a)
    else:
        for i in range(len(a)):
            if (i % 5 == 0 and i != 0):
                print(' ', end='')
            print(a[i], end='')
        print()

|#
