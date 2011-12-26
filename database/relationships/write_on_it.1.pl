question_about('Do we usually write on/in it ?',write_on_it).
possibility_reduction(0.5,write_on_it).
write_on_it(X) :- write_on_it_with_chalc(X).
