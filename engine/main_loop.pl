main_loop :- new_information, main_loop.
main_loop :- 
  setof(O,active(O),L),
  show_list(L).

