Inductive Term := .

Inductive Op := .

Definition Order (n : nat) : Prop. Admitted.
Example test_prop : Order 1. Admitted.

Definition PM_and {n : nat} (X Y : Order n) : Order n. Admitted.
Example test_and (X Y : Order 1) := PM_and X Y.
Example test_and_1 (X Y Z : Order 1) := PM_and X (PM_and Y Z).

Definition PM_imp {n : nat} (X Y : Order n) : Order n. Admitted.

Definition PM_asserted {n : nat} (X : Order n) : Prop. Admitted.

Theorem test_axiom (X Y Z : Order 1) : 
  PM_asserted
    (PM_imp (PM_and X (PM_and Y Z)) (PM_and X Y)).
  Admitted.

Theorem test_impl {n : nat} (X Y Z : Order n) :
  PM_asserted (PM_imp X Y)
    -> PM_asserted X -> PM_asserted Y. 
  Admitted.

Theorem test_proof (X Y Z : Order 1) :
  PM_asserted 
    (PM_imp (PM_and X Y) (PM_and X Y)).
Proof.
  (* TODO: write something... *)
Admitted.
(* TODO: 
- when rewrite on a theorem, unbox the pm_asserted 
- when boxing/unboxing the theorem, try to preserve the order information
*)

(* 
- Should we only shift asserted propositions or directly on propositions? 
- Should we design as a tactic or a function?
*)
Definition shift : Prop. Admitted.