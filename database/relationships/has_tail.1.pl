question_about('Does it have a tail?',has_tail).
has_tail(X):-lives(X).
%is_mammal(X):-lives(X),sucks_milk(X).
% ; is or
% \+ negation
% if something is a bird , than it is not a mammal and does not need electricity
% does_not_need_electricity(X) :- \+ needs_electricity(X). bad example. do not pracktice this.
% wach out for loops.