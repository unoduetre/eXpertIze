question_about('Is it intendend for writing?',intended_for_writing).
possibility_reduction(0.5,intended_for_writing).
intended_for_writing(X) :- needs_ink_to_function(X).
intended_for_writing(X) :- write_with_it_on_blackboard(X).
intended_for_writing(X) :- needs_graphite_to_function(X).
