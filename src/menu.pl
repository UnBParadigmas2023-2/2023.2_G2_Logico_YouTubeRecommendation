:- [filter].
:- [recommendation].

menu :-
	new(Dialog, dialog('Youtube Recommendation')),
	initial_menu(Dialog).

initial_menu(Dialog) :-
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