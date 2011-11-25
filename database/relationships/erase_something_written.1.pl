question_about('Do we use it to erase things we have written?',erase_something_written).
possibility_reduction(0.5,erase_something_written).
erase_something_written(X) :- erase_pencil(X).
erase_something_written(X) :- erase_chalc(X).
