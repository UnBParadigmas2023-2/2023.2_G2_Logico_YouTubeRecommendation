:- use_module(library(pce)). 

show_menu :-
	 new(Dialog, dialog('Youtube Recommendation')),
   	 send(Dialog, size, size(600, 600)), 
	 send(Dialog, background, '#e23e1a'), 
	 new(Begin, button('End', and(message(Dialog, destroy)))), 
	 send(Dialog, append(Begin)),
	 send(Dialog, open_centered). 
