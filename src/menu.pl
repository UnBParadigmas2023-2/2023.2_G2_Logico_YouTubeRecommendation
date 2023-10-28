:- [filter].
:- [recommendation].
:- [preferences].

menu :-
	new(Dialog, dialog('Recomendacao do Youtube')),
	menu_inicial(Dialog).

menu_inicial(Dialog) :-
	send(Dialog, clear),
  send(Dialog, append, new(BTS, dialog_group(buttons, group))),
	new(Title, text('Bem-vindo a recomendacao do YouTube!\nEscolha o modo de recomendação:')),
	new(F, font(screen, bold, 20)),
	send(Title, font(F)),
	send(Dialog, size, size(800, 800)),
	send(Dialog, background, '#ff0000'),
	new(End, button('Fechar', and(message(Dialog, destroy)))),
	new(Recommendation, button('Recomendações', and(message(@prolog, fazer_perguntas, Dialog)))),
	new(Filter, button('Filtrar', and(message(@prolog, filtrar, Dialog)))),
  send(BTS, append(Title)),
	send(BTS, append(Recommendation)),
	send(BTS, append(Filter)),
	send(BTS, append(End)),
  send(BTS, layout_dialog),
  send(Dialog, layout),
	send(Dialog, open_centered).

filtrar(Dialog) :-
  send(Dialog, clear),
  send(Dialog, append, new(Group, dialog_group(buttons, group))),
  send_list(Group, append,
            [ new(D, menu(data, cycle)),
              new(C, menu(categoria, cycle)),
              new(P, menu(proporcao_de_likes, cycle)),
              button(voltar, message(@prolog, menu_inicial, Dialog)),
              button(pesquisar, and(message(@prolog,
                                            filtrar_recomendacoes,
                                            D?selection,
                                            C?selection,
                                            P?selection)))
            ]),
  opcoes_data(OP),
  send_list(D, append, OP),
  opcoes_proporcao(OPP),
  send_list(P, append, OPP),
  send(C, append, todas),
  forall(category(CC), send(C, append, CC)),
  send(Dialog, layout_dialog),
  send(Dialog, layout).

fazer_perguntas(Dialog) :- 
  send(Dialog, clear),

  send(Dialog, append, new(BTS, dialog_group(buttons, group))),

  inserir_pergunta(BTS, 'Você gosta de cultura externa?', S1),
  inserir_pergunta(BTS, 'Você gosta de estudar?', S2),
  inserir_pergunta(BTS, 'Você gosta de adrenalina?', S3),
  inserir_pergunta(BTS, 'Você gosta de séries?', S4),
  inserir_pergunta(BTS, 'Você gosta de ciência?', S5),

  new(V, button(voltar)),
  new(P, button(pesquisar)),
  send(V, message, message(@prolog, menu_inicial, Dialog)),
  send(P, message, message(@prolog, format_teste, S1?selection, S2?selection, S3?selection, S4?selection, S5?selection)),
  send(BTS, append, V),
  send(BTS, append, P),

  send(BTS, layout_dialog),
  send(Dialog, layout).