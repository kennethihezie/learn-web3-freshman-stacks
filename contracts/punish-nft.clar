
;; title: punish-nft
;; version:
;; summary:
;; description:

;; traits
(impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)

;; token definitions
(define-non-fungible-token punish-nft uint)

;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; data vars
(define-data-var last-token-id uint u0)

;; data maps
;;

;; public functions
;; The transfer function should assert that the sender is equal to 
;; the tx-sender to prevent principals from transferring tokens they 
;; do not own.
(define-public (transfer (token-id uint) (sender principal) (recipient principal)) 
  (begin 
     (asserts! (is-eq sender tx-sender) err-not-token-owner)
     (nft-transfer? punish-nft token-id sender recipient)
  )
)

(define-public (mint (recipient principal)) 
  (let 
  (
    ;; new variable and assign last-token-id and increase by 1
    (token-id (+ (var-get last-token-id) u1))
  ) 
  (asserts! (restricted tx-sender) err-owner-only)
  (try! (nft-mint? punish-nft token-id recipient))
  (var-set last-token-id token-id)
  (ok token-id)
  )
)

;; read only functions
(define-read-only (get-last-token-id) 
  (ok (var-get last-token-id))
)

;; The idea of get-token-uri is to return a link to metadata for the 
;; specified NFT. Our practice NFT does not have a website so we
;; can return none.
(define-read-only (get-token-uri (token-id uint)) 
  (ok none)
)

;; The get-owner function only has to wrap the built-in nft-get-owner?.
(define-read-only (get-owner (token-id uint)) 
  (ok (nft-get-owner? punish-nft token-id))
)

;; private functions
(define-private (restricted (sender principal)) 
  (is-eq tx-sender sender)
)

