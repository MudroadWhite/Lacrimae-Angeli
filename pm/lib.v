(* 
TODO:
1. plan to distinguish between definitional equality and 
    propositional equality in the future?
2. immediately translate definitions in chapter 1 and see if 
literal props also work out
3. Design the function form correctly

Future: 
1. reorganize the notation with `Reserved Notation`
*)

(* UNUSED: to be specified in future *)
Inductive Op := .

Definition Order (n : nat) : Prop. Admitted.
Example test_prop : Order 1. Admitted.

Definition is_eprop {n : nat} (p : Order n) : Prop. Admitted.
(* At this moment we are designing efunc almost the same as eprop. 
  To be restructured in the future *)
Definition is_func {n : nat} (p : Order n) : Prop. Admitted.

(* A temporary theorem to be used in future... *)
Definition order_1_are_eprops : forall (n : nat) (p : Order n),
  n = 1 -> is_eprop p.
Admitted.

Declare Scope debug_pm_ops.
Declare Scope pm_ops.

(* Temporary operators definitions. Should be integrated as an inductive type
  in the future. The `n`s in these operators also work as a base order *)
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

Definition PM_neg {n : nat} (X : Order n) : Order n. Admitted.
Notation " '<neg>' A" := (PM_neg A)
  (at level 75, A at level 100, right associativity)
  : debug_pm_ops.
Example example_debug_neg_1 (X : Order 1) := <neg> X.

Definition PM_asserted {n : nat} (X : Order n) : Prop. Admitted.
Notation "<|-> A" := (PM_asserted A)
  (at level 70, A at level 100, right associativity)
    : debug_pm_ops.
Example example_debug_asserted (X : Order 1) := <|-> X.

Example example_theorem (X Y Z : Order 1) : 
  <|-> (X <and> (Y <and> Z)) <imp> (X <and> Y).
  Admitted.

(* We can distinguish between PM impl and normal Rocq impl *)
Example example_impl {n : nat} (X Y : Order n) :
  (<|-> (X <imp> Y)) -> (<|-> X) -> (<|-> Y).
  Admitted.

(* *1.7 *)
Definition test_n1_7 {n : nat} (P : Order n) : 
  is_eprop P -> is_eprop (<neg> P).
Admitted.

(* *1.71 *)
Definition test_n1_71 {n : nat} (P Q : Order n) :
  is_eprop P -> is_eprop Q -> is_eprop (P <and> Q).
Admitted.

(* TODO: design the form for function before expressing this *)
(* *1.72 *)
Definition test_n1_72 {n : nat} (Phi Psi : Order n) : Prop.
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
f := (^x y z, ...) with a strict algo to eval into a proposition, or abstract
from a proposition

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
