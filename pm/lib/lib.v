Require Import PM.pm.lib.maps.

Declare Scope debug_pm_ops.
Declare Scope pm_ops.

(* 
NOTE:
1. It seems that we have to customize the order to type the expressions and design the 
typing for it
2. https://softwarefoundations.cis.upenn.edu/plf-current/Stlc.html
3. https://www.cs.cornell.edu/courses/cs6115/2024fa/lectures/lec26_setoid_rewrite.html TODO: delete?
4. https://www.cis.upenn.edu/~plclub/blog/2020-05-15-Rewriting-in-Coq/

TODO:
1. immediately translate definitions in chapter 1 and see if 
literal props also work out
2. Design the function form correctly
3. Should I also design an extra syntax to just produce the typed version?

Function should be able to
- Apply to parameters
- Be abstracted away from a proposition
- Be turned into a quantified prop
- Have its own specific type
- Deal with situation when it is untyped - when should it be untyped?

Future: 
1. reorganize the notation with `Reserved Notation`. This also helps eliminating redundant notations in ch9 & 10
2. Distinguish between def equality and prop equality
*)

Module Exp.
  Inductive t : Type := 
    | Var : t
    | Neg : t -> t
    | Or : t -> t -> t
    | And : t -> t -> t
    | Imp : t -> t -> t
    .
End Exp.

(* The order type and rules for it *)
Definition Order (n : nat) : Prop. Admitted.
Example test_prop : Order 1. Admitted.

(* TODO: in the future, to be more polymorphic, we might want to substitute the `Order n` into something more general... *)
Definition is_eprop {n : nat} (p : Order n) : Prop. Admitted.
(* UNUSED *)
Definition is_func {n : nat} (p : Order n) : Prop. Admitted.
(* TODO: define notation for eq_order *)
Definition eq_order {n m : nat} (on : Order n) (om : Order m) : Prop. Admitted.

Axiom eq_nat_order : forall (n m : nat) (on : Order n) (om : Order m),
  n = m -> eq_order on om.
Axiom order_0_are_eprops : forall (n : nat) (p : Order n),
  n = 0 -> is_eprop p.

Open Scope debug_pm_ops.

Notation " A '<and>' B " := (Exp.And A B)
  (at level 80, B at level 200, right associativity,
  format "'[ ' A '/' '[ ' <and> ']' '/' B ']'")
  : debug_pm_ops.
Example example_debug_and_1 (X Y : Exp.t) := X <and> Y.

Example example_or_1 (X Y : Exp.t) := Exp.Or X Y.
Example example_or_2 (X Y Z : Exp.t) := Exp.Or X (Exp.Or Y Z).

Notation " A '<or>' B " := (Exp.Or A B)
  (at level 80, B at level 200, right associativity,
  format "'[ ' A '/' '[ ' <or> ']' '/' B ']'")
  : debug_pm_ops.
Example example_debug_or_1 (X Y : Exp.t) := X <or> Y.

Definition PM_imp (X Y : Exp.t) : Exp.t. Admitted.
Notation " A '<imp>' B " := (PM_imp A B)
  (at level 73, B at level 200, right associativity,
  format "'[ ' A '/' '[ ' <imp> ']' '/' B ']'")
  : debug_pm_ops.
Example example_debug_imp_1 (X Y : Exp.t) := X <imp> Y.

Definition PM_neg (X : Exp.t) : Exp.t. Admitted.
Notation " '<neg>' A" := (Exp.Neg A)
  (at level 75, A at level 200, right associativity)
  : debug_pm_ops.
(* Example example_debug_neg_1 (X : Order 1) := <neg> X. *)
Example example_debug_neg_1 (X : Exp.t) := <neg> X.

(* TODO:
- to be updated with test_type_asserted 
- to be put into an inductive type
- abbreviate `Order 0` when possible
- context support and abbreviation for context 
*)
Definition PM_asserted (X : Exp.t) (T : Type) : Prop. Admitted.
Example example_asserted_1 (X : Exp.t) := PM_asserted X (Order 1).

Notation " '<|->' A :: T " := (PM_asserted A T)
  (at level 80, A at level 9, T at level 200, left associativity)
  : debug_pm_ops.
Example example_debug_asserted_1 (X : Exp.t) := <|-> X :: Order 0.
Example example_debug_asserted_2 (X Y Z : Exp.t) :=
  <|-> ((X <and> (Y <and> Z)) <imp> (X <and> Y)) :: Order 0.
(* We can distinguish between PM impl and normal Rocq impl *)
Example example_debug_asserted_3 {n : nat} (X Y : Exp.t) :=
  (<|-> (X <imp> Y) :: Order 0) -> (<|-> X :: Order 0) -> (<|-> Y :: Order 0).

(* 
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
Admitted. *)

Close Scope debug_pm_ops.

Open Scope pm_ops.
Close Scope pm_ops.

(* UNUSED. TODO:
- Should we only shift asserted propositions or directly on propositions? 
- Should we design as a tactic or a function?
*)
Definition shift : Prop. Admitted.

(* DRAFT: design the correct form for function. Currently what in mind:
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

(* **************** *)

(* TODO: add more things to context 
- context should somewhat express the maximum proposition order
- context should also somewhat express the base order
- implement a init for context
- recheck `empty` for context
*)
Definition context (A : Type) := partial_map A.

Definition test_type_asserted {A : Type} (gamma : context A) (P : Exp.t) (type : Type) 
  : Prop.
Admitted.
Example test_type_asserted_1 (A : Type) := forall (gamma : context A) (P : Exp.t) 
  (ord : nat),
  test_type_asserted gamma P (Order ord) -> test_type_asserted gamma P (Order ord).

Open Scope debug_pm_ops.

Axiom neg_intro : forall (A : Type) (c : context A) (n : nat) (P : Exp.t),
  test_type_asserted c P (Order n)
  -> test_type_asserted c (<neg> P) (Order n).

(* NOTE:
\/ should have a type of (Order x, Order y) -> Order (max x y); 2 ways to understand \/:
1. bottom-up: if subterms are typed, \/ can be typed
2. top-down: if the whole proposition is of type x, \/ should be of type y
*)
(* Axiom or_intro : forall (A : Type) (c : context A) (n m : nat) (P Q : Exp),
  test_type_asserted c P (Order n)
  -> test_type_asserted c Q (Order m)
  -> test_type_asserted c (P <or> Q) (Order (max n m)).

Axiom and_intro : forall (A : Type) (c : context A) (n m : nat) (P Q : Exp),
  test_type_asserted c P (Order n)
  -> test_type_asserted c Q (Order m)
  -> test_type_asserted c (P <and> Q) (Order (max n m)). *)

Axiom binop_intro : forall {A : Type} (n m : nat) (c : context A) (P Q : Exp.t)
  (op : Exp.t -> Exp.t -> Exp.t),
  test_type_asserted c P (Order n)
  -> test_type_asserted c Q (Order m)
  -> test_type_asserted c (op P Q) (Order (max n m)).

Definition or_intro {A : Type} (n m : nat) (c : context A) (P Q : Exp.t)
  := binop_intro n m c P Q (Exp.Or).

Definition and_intro {A : Type} (n m : nat) (c : context A) (P Q : Exp.t)
  := binop_intro n m c P Q (Exp.And).

Axiom individual_intro : forall {A : Type} (c : context A) (P : Exp.t),
  (* TODO:
  - specify that context has base order
  - state that individual has the base order
  *)
  test_type_asserted c P (Order 0).

(* TODO: design a rule to work when we need to subst for a theorem *)
(* Axiom subst_thm : forall {A : Type} (c : context A) (thm : Prop)
(P : Exp), *)

(* 
TODO:
- a special type `PM_Prop` := Prop, but is of a instance of typeclass `Thm`
typeclass `Thm` allows to extract something..?
- maybe we need to design a rule `(type -> type) -> (prop -> prop)` to support
making `assert type` into a prop, or stick with how sf plf makes it 
*)
Definition subst_thm {A : Type} (c : context A) (thm : Prop) : Type.
Admitted.
  (* ... match thm with *)



(*
TODO: 
- redesign type_asserted into typed + asserted, checking type before asserting them
- figure out a way to pass in the context
- when passing in the individuals, should we add them into the context?
*)

(* TODO: demonstrate 2.01 *)
Theorem test_n2_01 {c : context Exp.t} (P : Exp.t) :
  test_type_asserted c
    ((P <imp> (<neg> P)) <imp> (<neg> P))
    (Order 0).
Proof.
  (* TODO:
  3. use the individuals to construct everything above
  4. how about filling in parameters for functions..?
  *)
  (* NOTE: temp way to properly introduce P with order 0, but how about 
    other things?... *)
  pose proof (individual_intro c P) as tP.
  assert (S1 : test_type_asserted c
    ((<neg> P) <or> (<neg> P) <imp> (<neg> P))
    (Order 0)).
  {
    admit.
  }
Admitted.

Close Scope debug_pm_ops.
