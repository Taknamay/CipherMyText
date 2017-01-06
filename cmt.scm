
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
   (ui:widget-by-id 'output-field)
   (string-append "Hello, "
                  (ui:entry-text (ui:widget-by-id 'input-field))
                  (ui:entry-text (ui:widget-by-id 'key-field))
                  "!")))

(ui:init!)

(ui:widgets
 `(window
   (@ (id main)
      (title "CipherMyText")
      (width 300)
      (height 300)
      (closing ,(lambda (wi) (ui:quit!))))
   (grid
    ;; Input []
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
    ;; Key []
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
    ;; Encrypt/decrypt  cipher type
    (item
     (@ (left 0) (top 2))
     (radio-buttons "Encrypt" "Decrypt"))
    ;; Go
    (item
     (@ (left 1) (top 3))
     (button
      (@ (id btn)
         (text "Go!")
         (clicked ,btn-press))))
    ;; Output []
    (item
     (@ (left 0) (top 4))
     (label
      (@ (text "Output text:"))))
    (item
     (@ (left 1) (top 4))
     (entry
      (@ (id output-field)
         (text "")
         (read-only? #t)))))))

(ui:control-show! (ui:->control (ui:widget-by-id 'main)))
(ui:main)

