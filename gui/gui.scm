#!/usr/bin/env kawa

;; Work on a GUI for CipherMyText

(import (class java.awt BorderLayout GridLayout Dimension Container)
        (class javax.swing
               JFrame JPanel JComboBox JButton SwingUtilities
               JSeparator JLabel JTextField JTextArea
               JScrollPane JRadioButton ButtonGroup)
        (macduffie cipher))

(define frame ::JFrame #!null)

(define cipher-list
  ;; Create an association lists for the ciphers
  `(("Autokey" ,autokey-encipher ,autokey-decipher)
    ("Reptkey (Vigenere)" ,reptkey-encipher ,reptkey-decipher)
    ("Monoalphabetic" ,mono-encipher ,mono-decipher)
    ("Caesar" ,caesar-encipher ,caesar-decipher)
    ("ROT13" ,rot13 ,rot13)))

(define (add-components-to-pane pane ::Container)
  (define grid-container ::JPanel (JPanel))
  (define layout ::GridLayout (GridLayout 0 2))
  ;; Declare components
  (define input-label ::JLabel (JLabel "Input text:"))
  (define input-text ::JTextArea (JTextArea))
  (define input-text-pane ::JScrollPane (JScrollPane input-text))
  (define key-label ::JLabel (JLabel "Key:"))
  (define key-text ::JTextField (JTextField 20))
  (define radio-encipher ::JRadioButton (JRadioButton "Encipher"))
  (define radio-decipher ::JRadioButton (JRadioButton "Decipher"))
  (define cipher-mode ::JPanel (JPanel))
  (define cipher-kind ::JComboBox
    (let ()
      (define x ::String[]
        (apply String[] (map car cipher-list)))
      (JComboBox x)))
  (define go-button ::JButton (JButton "Go!"))
  (define output-label ::JLabel (JLabel "Output text:"))
  (define output-text ::JTextArea (JTextArea))
  (define output-text-pane ::JScrollPane (JScrollPane output-text))

  ;; The user cannot edit the output text
  (output-text:setEditable #f)

  ;; Make the text areas wrap text
  (input-text:setLineWrap #t)
  (output-text:setLineWrap #t)

  ;; Set the gap for the grid
  (layout:setHgap 25)
  (layout:setVgap 25)
  
  ;; Set the layout for gridLayout
  (grid-container:setLayout layout)

  ;; Limit the height of the key field
  (key-text:setPreferredSize (Dimension 150 20))
  
  ;; Set the listener for go-button
  (go-button:addActionListener
   (lambda (event)
     (define encipher? (radio-encipher:isSelected))
     (define kind cipher-kind:SelectedItem)
     (define proc
       (list-ref (assoc kind cipher-list)
                 (if encipher? 1 2)))
     (define text-in (input-text:getText))
     (define key (key-text:getText))
     (define text-out
       (cond
        ((or (eq? proc caesar-encipher)
             (eq? proc caesar-decipher))
         (apply-cipher proc #f text-in (string->number key)))
        ((eq? proc rot13)
         (apply-cipher proc #f text-in))
        (else
         (apply-cipher proc #f text-in key))))
     (output-text:setText (print-letters text-out))))
  
  ;; Add buttons to cipher-mode
  (cipher-mode:add radio-encipher)
  (cipher-mode:add radio-decipher)
  (radio-encipher:setSelected #t)

  ;; Group buttons for cipher-mode
  (let ((g (ButtonGroup)))
    (g:add radio-encipher)
    (g:add radio-decipher))

  ;; Set up cipher-kind
  (cipher-kind:setSelectedIndex 0)
  (cipher-kind:addActionListener
   (lambda (event)
     (display event)
     (newline)
     (newline)))
  
  ;; Add components
  (grid-container:add input-label)
  (grid-container:add input-text-pane)
  (grid-container:add key-label)
  (grid-container:add key-text)
  (grid-container:add cipher-mode)
  (grid-container:add cipher-kind)
  (grid-container:add (JPanel))
  (grid-container:add go-button)
  (grid-container:add output-label)
  (grid-container:add output-text-pane)
  
  (pane:add grid-container))

(define (create-and-show-GUI)
  ;; Create and set up the window
  (set! frame (JFrame "CipherMyText!"))
  (frame:setDefaultCloseOperation JFrame:EXIT_ON_CLOSE)
  ;; Give the frame a minimum size
  (frame:setMinimumSize (Dimension 300 450))
  ;; Set up the content pane
  (add-components-to-pane (frame:getContentPane))
  
  ;; Display the window
  (frame:pack)
  (frame:setVisible #t))

(SwingUtilities:invokeLater (runnable create-and-show-GUI))

#|

(define gapList ::string[] (string[] "0" "10" "15" "20"))
(define maxGap ::int 20)
(define horGapComboBox ::JComboBox #!null)
(define verGapComboBox ::JComboBox #!null)
(define applyButton ::JButton (JButton "Apply gaps"))
(define experimentLayout ::GridLayout (GridLayout 0 2))
(define frame ::JFrame #!null)

(define (initGaps)
  (set! horGapComboBox (JComboBox gapList))
  (set! verGapComboBox (JComboBox gapList)))

(define (addComponentsToPane pane ::Container)
  (define compsToExperiment ::JPanel (JPanel))
  (define controls ::JPanel (JPanel))
  (define b ::JButton #!null)
  (define buttonSize ::Dimension #!null)
  (initGaps)
  (compsToExperiment:setLayout experimentLayout)
  (controls:setLayout (GridLayout 2 3))

  ;; Set up components by preferred size
  (set! b (JButton "Just fake button"))
  (set! buttonSize (b:getPreferredSize))
  (compsToExperiment:setPreferredSize
   (Dimension
    (integer (+ maxGap (* 2.5 (buttonSize:getWidth))))
    (integer (+ (* maxGap 2) (* 3.5 (buttonSize:getHeight))))))

  ;; Add buttons to experiment with Grid Layout
  (compsToExperiment:add (JButton "Button 1"))
  (compsToExperiment:add (JButton "Button 2"))
  (compsToExperiment:add (JButton "Button 3"))
  (compsToExperiment:add (JButton "Long-Named Button 4"))
  (compsToExperiment:add (JButton "5"))

  ;; Add controls to set up horizontal and vertical gaps
  (controls:add (JLabel "Horizontal gap:"))
  (controls:add (JLabel "Vertical gap:"))
  (controls:add (JLabel " "))
  (controls:add horGapComboBox)
  (controls:add verGapComboBox)
  (controls:add applyButton)

  ;; Process the Apply gaps button press
  (applyButton:addActionListener
   (lambda (e)
     ;; Get the horizontal gap value
     (define horGap ::String (String (horGapComboBox:getSelectedItem)))
     ;; Get the vertical gap value
     (define verGap ::String (String (verGapComboBox:getSelectedItem)))
     ;; Set up the horizontal gap value
     (experimentLayout:setHgap (Integer:parseInt horGap))
     ;; Set up the vertical gap value
     (experimentLayout:setVgap (Integer:parseInt verGap))
     ;; Set up the layout of the buttons
     (experimentLayout:layoutContainer compsToExperiment)))

  (pane:add compsToExperiment BorderLayout:NORTH)
  (pane:add (JSeparator) BorderLayout:CENTER)
  (pane:add controls BorderLayout:SOUTH))

(define (createAndShowGUI)
  ;; Create and set up the window
  (set! frame (JFrame "GridLayoutDemo"))
  (frame:setDefaultCloseOperation JFrame:EXIT_ON_CLOSE)
  ;; Set up the content pane
  (addComponentsToPane (frame:getContentPane))
  ;; Display the window
  (frame:pack)
  (frame:setVisible #t))

(SwingUtilities:invokeLater (runnable createAndShowGUI))

|#

