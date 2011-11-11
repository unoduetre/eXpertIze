line_read(Line) :- 
  read_line_to_codes(user_input,A),
  string_to_list(String,A),
  string_to_atom(String,Line).

line_written(Line) :- print(Line),nl.

