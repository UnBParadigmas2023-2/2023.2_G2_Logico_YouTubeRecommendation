use_module(library(readutil)).
:- [src/tmp/data].

append_text_dialog([], Dialog).
append_text_dialog([A|B], Dialog) :-
    send(Dialog,append(text(A))),
    append_text_dialog(B, Dialog).

print_category([]).
print_category([Category | T]) :-
    write(Category), 
    print_category(T).


views_per_like(Q) :-
    new(Dialog, dialog('Resultado dos videos recomendados')), 
    send(Dialog, size, size(600, 600)),
	findall(Title,(video(_, _, Title, _, Q)),Categories),
	append_text_dialog(Categories, Dialog),
    send(Dialog, open).
