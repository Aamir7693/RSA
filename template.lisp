;; This is a minimal template for a CPSA input file.

;; Replace <TITLE> with the desired title and <PROTONAME>
;; with the desired name of your project.

;; The defrole template below may be copied and used as
;; a starting point for the roles of your protocol.
;; Change the <ROLENAME> field in each copy as desired.
;; Roles must have distinct names.

;; The basic cryptoalgebra is selected by default. If
;; your project requires the diffie-hellman algebra,
;; delete "basic" on the defprotocol line, uncomment
;; "diffie-hellman" on this same line and uncomment
;; the "(algebra diffie-hellman)" statement in the
;; herald.

;; Refer to the CPSA manual for more information
;; about syntax and additional features.

(herald "EKKE"
	;; (algebra diffie-hellman)
	)

(defprotocol RSA basic ;; diffie-hellman

  (defrole init
    (vars (a b name)(ea akey)(r skey)(c1 c2 text))
    (trace
     (send (cat a (enc ea (ltk a b))))
     (recv (enc(enc r ea)(ltk a b)))
     (send  (enc c1 r)
     (recv (enc c1 c2 r))
     (send (enc c2 r))
     )
    )
 (defrole resp
    (vars (a b name)(ea akey)(r skey)(c1 c2 text))
    (trace
     (recv (cat a( enc ea (ltk a b))))
     (send (enc (enc r ea)(ltk a b)))
     (recv (enc c1 r))
     (send (enc c1 c2 r))
     (recv (enc c2 r))
     (uniq-orig r)
     )
    )


(defskeleton RSA
  (vars (a b name)(ea akey)(c1 text))
  (defstrand init 4 (a a)(b b)(ea ea)(c1 c1))
  (non-orig (ltk a b))
  (uniq-orig c1 ea)
  ))
