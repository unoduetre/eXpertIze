question_about('Can all variations of it be put in a backpack?',can_put_in_backpack).
possibility_reduction(0.5,can_put_in_backpack).
can_put_in_backpack(X) :- can_put_in_pocket(X).
