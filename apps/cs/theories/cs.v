Declare ML Module "coq-elpi-cs.plugin".
From elpi Require Import elpi.

Elpi Db cs.db lp:{{

% predicate [cs Ctx Proj Rhs Sol] used to find Sol such that Proj Sol = Rhs, where
% - [Ctx] is the context
% - [Proj] is the projector of some structure, applied to the structure's parameters if any
% - [Rhs] the term to find a structure on.
:index (0 6 6)
pred cs i:goal-ctx, i:term, i:term, o:term.

}}.



Elpi Tactic canonical_solution.
Elpi Accumulate Db cs.db.
Elpi Accumulate canonical_solution lp:{{

solve (goal Ctx _ Ty Sol [trm Proj, trm Rhs]) _ :-
  coq.say "cs on " Proj Rhs " for " Ty,
  std.findall (canonical-instance _ _ _) S,
  coq.say "canonical instances :" S,
  cs Ctx Proj Rhs Sol',
  Sol = Sol',
  % std.assert! (P = {{ eq_refl lp:Lhs }}) "cs: wrong solution".
  true.

}}.
Elpi Typecheck canonical_solution.
Elpi CSFallbackTactic canonical_solution.
