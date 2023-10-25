use_module(library(readutil)).
:- [src/tmp/data].
:- (dynamic category/1, video/5).
:- debug.

menu_general_recommend :-
    new(Dialog, dialog('Recomendacao Geral')),
    send(Dialog, append, new(Titulo, text('Recomendação por categoria'))), 
     send_list(Dialog,
              append,
              
              [ new(N1, menu(category, cycle)),
                button(cancel, message(Dialog, destroy)),
                button(enter,
                       and(message(@prolog,
                                   filter_by_category,
                                   N1?selection),
                           message(Dialog, destroy)))
              ]),
    forall(category(C), send_list(N1, append, C)),
    send(Dialog, open).

filter_by_category(Categoria) :-
     new(D, dialog('Vídeos Recomendados')),
    findall(Video,
            video(category,
                  _,
                  _,
                  _,
                  _,
                  _),
            Titles),
    append_text_dialog(Titles, D),
    send(D, open).

append_text_dialog([], D).
append_text_dialog([A|B], D) :-
    send(D, append, text(A)),
    append_text_dialog(B, D).

views():-
    menu_general_recommend.