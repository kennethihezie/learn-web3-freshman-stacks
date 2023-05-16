;; title: slave-token
;; version: 0.0.1
;; summary: token
;; description: token

;; constants
(define-constant initial-supply u10000)
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; traits
;; this contract contains all functions for fungible token.
(impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; No maximum supply!
;; (define-fungible-token slvt)
;; token definitions with max supply
(define-fungible-token slvt initial-supply)

;; data vars

;; data maps
;;

;; public functions
(define-public (mint-token-to-sender (sender principal) (amount uint)) 
  (begin 
    (asserts! (restricted sender) err-not-token-owner)
    (ft-mint? slvt amount sender)
  )
)

;; The transfer function should assert that the sender is equal 
;; to the tx-sender to prevent principals from transferring tokens 
;; they do not own. It should also unwrap and print the memo if it 
;; is not none. We use match to conditionally call print if the passed
;; memo is a some.
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
    (begin
        (asserts! (is-eq tx-sender sender) err-not-token-owner)
        (try! (ft-transfer? slvt amount sender recipient))
        (match memo to-print (print to-print) 0x)
        (ok true)
    )
)

(define-public (burn-tokens (sender principal) (amount uint)) 
  (ok (try! (ft-burn? slvt amount sender)))
)

;; read only functions
(define-read-only (get-name) 
  (ok "SlaveToken")
)

(define-read-only (get-symbol) 
 (ok "SLVT")
)

(define-read-only (get-decimals)
    (ok u6)
)

(define-read-only (get-balance (sender principal)) 
  (ok (ft-get-balance slvt sender))
)

(define-read-only (get-total-supply) 
    (ok (ft-get-supply slvt))
)

(define-read-only (get-token-uri)
    (ok none)
)

;; private functions
(define-private (restricted (sender principal)) 
  (is-eq sender contract-owner)
)

