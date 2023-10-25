views_Per_Like(Base) :-
	new(Dialog, 'Resultado dos vídeos recomendados'), 
	send(Dialog, size, size(600, 600)), 
	send(Dialog, backgrouns, '#e23e1a').
