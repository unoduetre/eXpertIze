:- ensure_loaded(load).

object_possibility_pairs_list_from([],[]).
object_possibility_pairs_list_from([H1|R1],[H2|R2]) :-
  engine:possibility_for(A,H2),
  H1 = [H2,A],
  object_possibility_pairs_list_from(R1,R2).
  

main_debug_loop :- 
  engine:new_information,
  setof(O,engine:active(O),L),
  object_possibility_pairs_list_from(P,L),
  interface:show_list(P),
  main_debug_loop.

main_debug_loop.

:- main_debug_loop.
