question_about('Does it show us time?',show_time).
possibility_reduction(0.5,show_time).
show_time(X) :- mainly_show_time(X).
