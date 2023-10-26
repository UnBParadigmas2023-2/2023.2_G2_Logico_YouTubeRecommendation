use_module(library(readutil)).
:- [src/tmp/data].

append_text_dialog([], _).
append_text_dialog([A|B], Dialog) :-
    send(Dialog,append(text(A))),
    append_text_dialog(B, Dialog).

print_category([]).
print_category([Category | T]) :-
    write(Category), 
    print_category(T).


menu_general_recommend :-
    new(Dialog, dialog('Recomendacao Geral')),
    send(Dialog,
            new(Titulo, video(_, _, Title, _, Q))),
    send(Dialog, open).

views_per_like(X) :-
    new(Dialog, dialog('Resultado dos videos recomendados')), 
    send(Dialog, size, size(600, 600)),
	findall(Title,(video(_, _, Title, _, Q),Q>X),Categories),
	append_text_dialog(Categories, Dialog),
    send(Dialog, open).

views():-
    menu_general_recommend().