#!/usr/bin/env kawa

;; Work on a GUI for CipherMyText

(import (class java.awt BorderLayout GridLayout Dimension Container)
        (class javax.swing
               JFrame JPanel JComboBox JButton SwingUtilities
               JSeparator JLabel)
        (macduffie cipher))

(define frame ::JFrame #!null)

(define cipher-list
  ;; Create an association lists for the ciphers
  `((autokey . ,(vector "Autokey"
                        autokey-encipher
                        autokey-decipher))
    (reptkey . ,(vector "Reptkey (Vigenere)"
                        reptkey-encipher
                        reptkey-decipher))
    (monokey . ,(vector "Monoalphabetic"
                        mono-encipher
                        mono-decipher))
    (caesar . ,(vector "Caesar"
                       caesar-encipher
                       caesar-decipher))
    (rot13 . ,(vector "ROT13"
                      rot13
                      rot13))))

(define (add-components-to-pane pane ::Container)
  (define grid-container ::JPanel (JPanel))
  ;; Declare components
  (define input-label ::JLabel (JLabel "Input text:"))
  (define go-button ::JButton (JButton "Hello world"))
  (define output-label ::JLabel (JLabel "Output text:"))
  
  ;; Set the layout for gridLayout
  (grid-container:setLayout (GridLayout 0 2))  
  
  ;; Set the listener for go-button
  (go-button:addActionListener
   (lambda (event)
     (display event)
     (newline)
     (newline)))
  
  ;; Add components
  (grid-container:add input-label)
  (grid-container:add go-button)
  (grid-container:add output-label)
  
  (pane:add grid-container))

(define (create-and-show-GUI)
  ;; Create and set up the window
  (set! frame (JFrame "CipherMyText!"))
  (frame:setDefaultCloseOperation JFrame:EXIT_ON_CLOSE)
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

