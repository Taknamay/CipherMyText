
;; CipherMyText, graphical application
;; uses libui

(import
  (scheme base)
  (scheme read)
  (scheme write)
  (macduffie queue)
  (macduffie cipher)
  (prefix (libui) ui:))

;; Create an association list of ciphers
(define cipher-list
  `(("Autokey" ,autokey-encipher ,autokey-decipher)
    ("Reptkey (Vigenere)" ,reptkey-encipher ,reptkey-decipher)
    ("Monoalphabetic" ,mono-encipher ,mono-decipher)
    ("Caesar" ,caesar-encipher ,caesar-decipher)
    ("ROT13" ,rot13 ,rot13)))

;; use a grid
;; Input: [       ]
;; Key:   [       ]
;; Radio  choicebox
;; en/de  Go! btn
;; Output:[       ]

(define (btn-press bt)
  (ui:entry-text-set!
   (ui:widget-by-id 'greeting)
   (string-append "Hello, "
                  (ui:entry-text (ui:widget-by-id 'name))
                  "!")))

(ui:init!)

(ui:widgets
 `(window
   (@ (id main)
      (title "Hello")
      (width 200)
      (height 100)
      (closing ,(lambda (wi) (ui:quit!))))
   (grid
    (item
     (@ (left 0) (top 0))
     (label
      (@ (text "Input text:"))))
    (item
     (@ (left 1) (top 0))
     (entry
      (@ (id input-field)
         (text "")
         (read-only? #f))))
    (item
     (@ (left 0) (top 1))
     (label
      (@ (text "Key:"))))
    (item
     (@ (left 1) (top 1))
     (entry
      (@ (id key-field)
         (text "")
         (read-only? #f))))
    (item
     (@ (left 0) (top 2))
     (button
      (@ (id btn)
         (text "Greet")
         (clicked ,btn-press))))
    (item
     (@ (left 1) (top 2))
     (entry
      (@ (id greeting)
         (text "")
         (read-only? #t)))))))

(ui:control-show! (ui:->control (ui:widget-by-id 'main)))
(ui:main)

