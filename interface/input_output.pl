read_line(Line) :- read_line_to_codes(user_input,A), string_to_list(Line,A).

write_line(Line) :- print(Line).

