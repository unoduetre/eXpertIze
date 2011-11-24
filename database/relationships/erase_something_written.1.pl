question_about('Do we use it to erase things we wtritten?',erase_something_written).
erase_something_written(X) :- erase_pencil(X).
erase_something_written(X) :- erase_chalc(X).