(* Unary parametricity translation.

   license: GNU Lesser General Public License Version 2.1 or later           
   ------------------------------------------------------------------------- *)

From elpi Require Export elpi.

(* To be removed. Like the param1-db below, but readable from Coq *)
Class reali_db {X XR : Type} (x : X) (xR : XR) := store_reali {}.
Class reali {X : Type} {XR : X -> Type} (x : X) (xR : XR x) := Reali {}.

(* Links a term (constant, inductive type, inductive constructor) with
   its parametricity translation *)
Elpi Db derive.param1.db lp:{{

:index(3)
pred reali i:term, o:term.

:name "reali:fail"
reali X _ :-
  M is "derive.param1: No unary parametricity translation for " ^
          {coq.term->string X},
  stop M.

type realiR term -> term -> prop.

:name "realiR:fail"
realiR T TR :-
  M is "derive.param1: No unary parametricity translation linking " ^
          {coq.term->string T} ^ " and " ^ {coq.term->string TR},
  stop M.
}}.

Elpi Command derive.param1.
Elpi Accumulate File "coq-lib-extra.elpi".
Elpi Accumulate File "derive/param1.elpi".
Elpi Accumulate Db derive.param1.db.
Elpi Accumulate lp:{{
  main [str I, str O] :- !, coq.locate I GR, derive.param1.main GR O _.
  main [str I] :- !, coq.locate I GR, derive.param1.main GR "is_" _.
  main _ :- usage.

  usage :- coq.error "Usage: derive.param1 <object name> [<output prefix>]".
}}. 
Elpi Typecheck.


