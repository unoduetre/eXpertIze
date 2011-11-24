show_list([]).
show_list([H|R]) :-
 line_written(H),
 show_list(R).
