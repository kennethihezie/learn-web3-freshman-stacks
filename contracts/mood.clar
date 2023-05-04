
;; title: Mood
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;; 

;; constants
;;

;; data vars
(define-data-var mood (string-utf8 100) u"")

;; data maps
;;

;; public functions
(define-public (set-mood (new-mood (string-utf8 100))) 
  (begin 
    (var-set mood new-mood)
    (ok (var-get mood))
  )
)

(define-read-only (get-mood) 
 (ok (var-get mood))
)
;; read only functions
;;

;; private functions
;;

