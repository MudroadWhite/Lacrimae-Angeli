(* UNUSED: to be specified in future *)
Inductive Op := .

(* UNUSED: to be specified in the future... *)
Definition Base : Prop. Admitted.

Definition Order (n : nat) : Prop. Admitted.
Example test_prop : Order 1. Admitted.

(* temporary operators *)
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
  PM_asserted (PM_and X (PM_and Y Z))
  -> PM_asserted (PM_and X Y).
Proof.
  (* TODO: write something... *)
Admitted.
(* 
- Should we only shift asserted propositions or directly on propositions? 
- Should we design as a tactic or a function?
*)
Definition shift : Prop. Admitted.

(* TODO: design the correct form for function. Currently what in mind:
f := ([x, y, z], (fun x y z => ...)) with a strict algo to eval, or maybe
     ([1, 1, 1], (fun x y z => ...))  to label the order/type, with a type check before eval(?)

without a strict restriction on param list length since idk how to control this
*)

(* 
Lemma __placeholder_prop : Prop.
Admitted.

Ltac saturate_prop_args t :=
  let ty := type of t in
  lazymatch ty with
  | Prop -> ?rest =>
      let t' := constr:(t __placeholder_prop) in
      saturate_prop_args t'
  | _ => t
  end.
 *)