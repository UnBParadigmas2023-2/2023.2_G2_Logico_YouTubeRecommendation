:- use_module(library(pce)). 


recomendar :-
	new(Dialog, dialog('Youtube Recommendation')),
  send(Dialog, size, size(800, 800)),
	send(Dialog, background, '#e23e1a'),
  send(Dialog, open),
  
  voce_gosta_de_aventura(Dialog), !.

voce_gosta_de_aventura(Dialog) :- 
  nb_setval(pergunta, "Você gosta de aventura?"),
  fazer_pergunta(Dialog),
  voce_gosta_de_anime(Dialog),
  !.

voce_gosta_de_anime(Dialog) :-
  nb_setval(pergunta, "Você gosta de anime?"),
  fazer_pergunta(Dialog), !.

fazer_pergunta(Dialog) :- 

  send(Dialog, clear),

  % Criando o texto da pergunto
  nb_getval(pergunta, TextoDaPergunta),
  new(Texto, text(TextoDaPergunta)),
  send(Texto, font, font(default, bold, 40)),
  send(Dialog, append, Texto),

  %

  send(Dialog, append, new(BTS, dialog_group(buttons, group))),

  % Criando o botão "Sim" e defina seu tamanho
  new(B2, button('Sim')),
  send(B2, size, size(200, 200)),
  send(B2, message, message(@prolog, tratar_resposta, TextoDaPergunta, 1)),
  send(BTS, append, B2, right),

  % Criando o botão "Não" e defina seu tamanho
  new(B1, button('Não')),
  send(B1, size, size(200, 200)),
  send(B1, message, message(@prolog, tratar_resposta, TextoDaPergunta, 2)),
  send(BTS, append, B1, below),

  send(B2, font, font(default, bold)),

  send(BTS, layout_dialog),
  send(Dialog, layout).


tratar_resposta(Pergunta, Resposta) :-
  write('Pergunta: '), write(Pergunta), nl,
  write('Resposta: '), write(Resposta).

