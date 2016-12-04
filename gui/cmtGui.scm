
;; cmtGui in JavaFX

(import
  (class javafx.application Application)
  (class javafx.scene Scene)
  (class javafx.scene.control Button Label)
  (class javafx.scene.layout StackPane)
  (class javafx.stage Stage StageBuilder))

(module-name cmtGui)

(define-simple-class cmtGui (Application)
  ((start (primary-stage ::Stage)) ::void
   (define btn (Button))
   (define root (StackPane))
   (primary-stage:setTitle "Hello World")
   (btn:setText "Say hi!")
   (btn:setOnAction
    (lambda (e) (display "Wow\n")))
   ((root:getChildren):add btn)
   (primary-stage:setScene (Scene root 300 250))
   (primary-stage:show)))

