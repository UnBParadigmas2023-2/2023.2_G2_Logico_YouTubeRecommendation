:- [filter].
:- [recommendation].

menu :-
	new(Dialog, dialog('Youtube Recommendation')),
	menu_inicial(Dialog).

menu_inicial(Dialog) :-
	send(Dialog, clear),
	new(Title, text('Bem-vindo a recomendacao do YouTube')),
	new(Mode_text, text('Escolha o modo de recomendacao')),
	new(F, font(screen, bold, 20)),
	send(Title, font(F)),
	send(Mode_text, font(F)),
	send(Dialog, size, size(800, 800)),
	send(Dialog, background, '#e23e1a'),
	new(End, button('End', and(message(Dialog, destroy)))),
	new(Recommendation, button('Recommendation', and(message(@prolog, recomendar, Dialog)))),
	new(Filter, button('Filter', and(message(@prolog, filtrar, Dialog)))),
	send(Dialog, append(Recommendation)),
	send(Dialog, append(Filter)),
	send(Dialog, append(End)),
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
												mostrar_recomendacoes,
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

