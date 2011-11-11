answer_for_question(Y,X) :- repeat,asked(X), returned(Y),!.

asked(X) :- line_written(X).

returned(Y) :- line_read(Z), is_standarization(Y,Z).

is_standarization(Y,Z) :- downcase_atom(Z,A), valid_answer_for(Y,A).

valid_answer_for(true,'yes').
valid_answer_for(true,'y').
valid_answer_for(true,'true').
valid_answer_for(true,'t').

valid_answer_for(false,'no').
valid_answer_for(false,'n').
valid_answer_for(false,'false').
valid_answer_for(false,'f').
