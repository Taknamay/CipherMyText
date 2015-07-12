
(import (scheme base)
        (scheme write)
        (scheme process-context))

(include "autokey.scm")

(define (usage)
  (display "Usage: automytext [options] [-e] <plaintext> <key>
       automytext [options] -d <ciphertext> <key>

Options:
      -h   Display this help text.
      -i=? Set the number of iterations.
      -p   Preserve the punctuation of the original message.
      -v   Display the version of the software.\n")
  (exit))

(define (main-prog args)
  (if (or (member "--help" args)
          (member "-h" args))
      (usage))
  (if (or (member "--version" args)
          (member "-v" args))
      (version)))

(main-prog (cdr (command-line)))

#|

    iterate = -1
    for i in args:
        if ("-i" in i):
            if ("-i=" in i):
                try:
                    iterate = int(i[3:])
                except ValueError:
                    usage()
                if (iterate < 1):
                    print("Iterations must be at least 1.")
                    exit(0)
                args.remove(i)
                break
            else:
                usage()
    if (iterate == -1):
        iterate = 1

    mode = -1
    if ("-e" in args):
        mode = 0
        args.remove("-e")
    if ("-d" in args):
        if (mode == 0):
            usage()
        mode = 1
        args.remove("-d")
    if (mode == -1):
        mode = 0

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
