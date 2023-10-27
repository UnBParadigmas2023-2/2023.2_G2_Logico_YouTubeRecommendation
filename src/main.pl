:- [mainmenu].
:- [recommendation].

initial_menu :-
	new(Dialog, dialog('Youtube Recommendation')),
	new(Title, text('Welcome to Youtube Recommendation')),
	new(Mode_text, text('Choose the recommendation mode')),
	new(F, font(screen, bold, 20)),
	send(Title, font(F)),
	send(Mode_text, font(F)),
	send(Dialog, size, size(800, 800)),
	send(Dialog, background, '#e23e1a'),
	new(End, button('End', and(message(Dialog, destroy)))),
	new(Recommendation, button('Recommendation', and(message(@prolog, recomendar)))),
	new(Filter, button('Filter', and(message(@prolog, filtrar)))),
	send(Dialog, append(Recommendation)),
	send(Dialog, append(Filter)),
	send(Dialog, append(End)),
	send(Dialog, open_centered).

% mostra_r(Dialog) :-
%   send (Dialog, destroy, recomendar.

main :-
  initial_menu.
