main :-
  line_written('Think about an object.'),
  main_loop.
main_loop :- got_new_information, main_loop.
main_loop :- 
  setof(O,active(O),L),
  show_list(L).

