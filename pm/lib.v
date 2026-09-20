(* 
TODO:
1. plan to distinguish between definitional equality and 
    propositional equality in the future?
2. immediately translate definitions in chapter 1 and see if 
literal props also work out
3. Future: reorganize the notation with `Reserved Notation`
*)

(* UNUSED: to be specified in future *)
Inductive Op := .

Definition Order (n : nat) : Prop. Admitted.
Example test_prop : Order 1. Admitted.

(* temporary operators *)
(* The `n` also works as a base *)

Declare Scope debug_pm_ops.
Declare Scope pm_ops.

Open Scope debug_pm_ops.

Definition PM_and {n : nat} (X Y : Order n) : Order n. Admitted.
Example example_and_1 (X Y : Order 1) := PM_and X Y.
Example example_and_2 (X Y Z : Order 1) := PM_and X (PM_and Y Z).

Notation " A '<and>' B " := (PM_and A B)
  (at level 80, B at level 100, right associativity,
  format "'[ ' A '/' '[ ' <and> ']' '/' B ']'")
  : debug_pm_ops.
Example example_debug_and_1 (X Y : Order 1) := X <and> Y.

Definition PM_or {n : nat} (X Y : Order n) : Order n. Admitted.
Example example_or_1 (X Y : Order 1) := PM_or X Y.
Example example_or_2 (X Y Z : Order 1) := PM_or X (PM_or Y Z).

Notation " A '<or>' B " := (PM_or A B)
  (at level 80, B at level 100, right associativity,
  format "'[ ' A '/' '[ ' <or> ']' '/' B ']'")
  : debug_pm_ops.
Example example_debug_or_1 (X Y : Order 1) := X <or> Y.

Definition PM_imp {n : nat} (X Y : Order n) : Order n. Admitted.
Notation " A '<imp>' B " := (PM_imp A B)
  (at level 73, B at level 100, right associativity,
  format "'[ ' A '/' '[ ' <imp> ']' '/' B ']'")
  : debug_pm_ops.
Example example_debug_imp_1 (X Y : Order 1) := X <imp> Y.

Definition PM_not {n : nat} (X : Order n) : Order n. Admitted.
Notation " '<not>' A" := (PM_not A)
  (at level 75, A at level 100, right associativity)
  : debug_pm_ops.
Example example_debug_not_1 (X : Order 1) := <not> X.

Definition PM_asserted {n : nat} (X : Order n) : Prop. Admitted.
Notation "<|-> A" := (PM_asserted A)
  (at level 70, A at level 100, right associativity)
    : debug_pm_ops.
Example example_debug_asserted (X : Order 1) := <|-> X.

Example example_theorem (X Y Z : Order 1) : 
  <|-> (X <and> (Y <and> Z)) <imp> (X <and> Y).
  Admitted.

Theorem test_impl {n : nat} (X Y : Order n) :
  PM_asserted (PM_imp X Y)
    -> PM_asserted X -> PM_asserted Y. 
  Admitted.

Close Scope debug_pm_ops.

Open Scope pm_ops.
Close Scope debug_pm_ops.

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
