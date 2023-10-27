:- use_module(library(pce)). 

# idade

# gosta de cultura externa?
# 1 a 5
# gosta de estudar?
# 1 a 5
# gosta de adrenalina?
# 1 a 5
# gosta de series?
# 1 a 5
# gosta do ciência?
# 1 a 5

# voce_gosta_de_aventura(Dialog, List).

recomendar(Dialog) :-
  List = [],
  fazer_perguntas(
    Dialog,
    List,
    [
      'Voce gosta de cultura externa?',
      'Voce gosta de estudar?',
      'Voce gosta de adrenalina?'
      'Voce gosta de ciencia?'
      'Voce gosta de series?'
    ],
    ).

fazer_pergunta(Dialog, List) :- 
  send(Dialog, clear),

  % Criando o texto da pergunto
  nb_getval(pergunta, TextoDaPergunta),
  new(Texto, text(TextoDaPergunta)),
  send(Texto, font, font(default, bold, 30)),
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


tratar_resposta(Dialog, List) :-
  write('Pergunta: '), write(Pergunta), nl,
  write('Resposta: '), write(Resposta).

