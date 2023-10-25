:- use_module(library(pce)). 

question_age(D) :-
	% Define question
	show_question(D).

show_question(D) :-
	send(D, clear),
	new(T, text('EAI')),
	new(F, font(screen, bold, 20)),
	send(T, font(F)),
	send(T, colour('#000000')),
	send(D, gap, size(10,10)),
	send(D, append, T),
	send(D, layout). 

show_menu :-
	new(Dialog, dialog('Youtube Recommendation')),
   	send(Dialog, size, size(800, 800)), 
	send(Dialog, background, '#e23e1a'), 
	new(End, button('End', and(message(Dialog, destroy)))),
	new(Begin, button('Begin', and(message(@prolog, show_question, Dialog)))), 
	send_list([Begin, End], size(size(400, 50))), 
	send(Dialog, append(Begin)), 
	send(Dialog, append(End)),
	send(Dialog, open_centered). 
