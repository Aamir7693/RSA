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

(herald "Encrypted Key Exchange "
	)

(defprotocol ekedh basic

  (defrole client
    (vars (a b name) (x rndx) (g base) (c1 c2 text) )
    (trace
	  (send (cat a (enc (exp (gen) x) (ltk a b))))
	  (recv (cat (enc g (x)) (enc c1 (exp g x))))
	  (send (enc c1 c2 (exp g (ltk a b))))
	  (recv (enc c2 (exp g x)))
     )
	   (uniq-gen x)
    )
	
	
	(defrole server
    (vars (a b name) (y rndx) (h base) (c1 c2 text) )
    (trace
	  (recv (cat a (enc h (y))))
	  (send (cat (enc (exp (gen) y) (ltk a b)) (enc c1 (exp h (ltk a b))) ))
	  (recv (enc c1 c2 (exp h y)))
	  (send (enc c2 (exp h (ltk a b))))
     )
	   (uniq-gen y)
    )

)
  ;For Testing only
  (defskeleton ekedh
  (vars (a b name) (x y randx) (c1 c2 text))
  (defstrand client 4 (a a) (b b) (x x) (c2 c2) )
  (defstrand server 4 (a a) (b b) (y y) (c1 c1) )
  (uniq-orig c1 c2)
  (non-orig (ltk a b))
  (comment "For Testing only Client and Server's point-of-view")
  )

  
  
  
