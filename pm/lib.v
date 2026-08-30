Inductive Term := .

Inductive Op := .

Definition PM_Prop (n : nat) : Prop. Admitted.
Example test_prop : PM_Prop 1. Admitted.

Definition PM_and {n : nat} (X Y : PM_Prop n) : PM_Prop n. Admitted.
Example test_and (X Y : PM_Prop 1) := PM_and X Y.
Example test_and_1 (X Y Z : PM_Prop 1) := PM_and X (PM_and Y Z).

Definition PM_imp {n : nat} (X Y : PM_Prop n) : PM_Prop n. Admitted.

Definition PM_asserted {n : nat} (X : PM_Prop n) : Prop. Admitted.

Theorem test_axiom (X Y Z : PM_Prop 1) : 
  PM_asserted
    (PM_imp (PM_and X (PM_and Y Z)) (PM_and X Y)).
  Admitted.

(* TODO: 
- when rewrite on a theorem, unbox the pm_asserted 
- when boxing/unboxing the theorem, try to preserve the order information
*)