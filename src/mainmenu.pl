:- use_module(library(pce)).
:- [src/data].

dias_em_segundos(Dias, Segundos) :-
  Segundos is (Dias * 24 * 3600).

meses_em_segundos(Meses, Segundos) :-
  dias_em_segundos(Meses * 30, Segundos).

data_por_opcao(sempre, Resultado) :-
  Resultado is 0.

data_por_opcao(semestre, Data) :-
  get_time(DataAtual),
  meses_em_segundos(6, Segundos),
  Data is (DataAtual - Segundos).

data_por_opcao(mes, Data) :-
  get_time(DataAtual),
  meses_em_segundos(1, Segundos),
  Data is (DataAtual - Segundos).

data_por_opcao(duas_semanas, Data) :-
  get_time(DataAtual),
  dias_em_segundos(14, Segundos),
  Data is (DataAtual - Segundos).

opcoes_data(R) :-
  findall(N, data_por_opcao(N, _), R).

proporcao_por_opcao(todos, Low, High) :-
  Low is 0, High is 1.

proporcao_por_opcao(baixa, Low, High) :-
  Low is 0, High is 0.1.

proporcao_por_opcao(media, Low, High) :-
  Low is 0.1, High is 0.2.

proporcao_por_opcao(alta, Low, High) :-
  Low is 0.2, High is 0.3.

opcoes_proporcao(R) :-
  findall(N, proporcao_por_opcao(N, _, _), R).

format_video(Category, Channel, Name, Result) :-
  format(atom(Result), '~w | ~w | ~w', [Category, Channel, Name]).

recomendar :-
  new(Dialog, dialog('Recomendar por data')),
  send(Dialog, size, size(900, 900)),
  send_list(Dialog, append,
            [ new(D, menu(data, cycle)),
              new(C, menu(categoria, cycle)),
              new(P, menu(proporcao_de_likes, cycle)),
              button(fechar, message(Dialog, destroy)),
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
  send(Dialog, default_button, pesquisar),
  send(Dialog, open).

filtrar_recomendacoes(D, C, P, R) :-
  data_por_opcao(D, DataLimite),
  proporcao_por_opcao(P, Low, High),
  findall(
    Out,
    (
      video(Cat, Chan, Nome, Data, Lpv),
      Data >= DataLimite,
      (C = todas ; Cat = C),
      Lpv >= Low, Lpv =< High,
      format_video(Cat, Chan, Nome, Out)
    ),
    R
  ).

mostrar_recomendacoes(D, C, P) :-
  new(Dialog, dialog('Recomendações')),
  send(Dialog, size, size(1000, 900)),
  send_list(Dialog, append,
            [ button(fechar, message(Dialog, destroy)),
              new(LB, list_browser)
            ]),
  send(LB, size, size(150, 50)),
  filtrar_recomendacoes(D, C, P, R),
  send_list(LB, append, R),
  send(Dialog, default_button, fechar),
  send(Dialog, open).
