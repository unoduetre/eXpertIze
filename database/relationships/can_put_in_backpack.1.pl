question_about('Can we put it in backpack?',can_put_in_backpack).
can_put_in_backpack(X) :- can_put_in_pocket(X).