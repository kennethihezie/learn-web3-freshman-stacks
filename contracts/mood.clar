
;; title: Mood
;; version: 0.01
;; summary: write mood to stack blockchain
;; description: write mood to stack blockchain

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

;; read only functions
(define-read-only (get-mood) 
 (ok (var-get mood))
)

;; private functions
;;

