question_about('Can all variations of it be put in a backpack?',can_put_in_backpack).
can_put_in_backpack(X) :- can_put_in_pocket(X).
