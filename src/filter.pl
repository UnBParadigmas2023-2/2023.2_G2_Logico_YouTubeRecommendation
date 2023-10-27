:- use_module(library(pce)).
:- [src/data].

dias_em_segundos(Dias, Segundos) :-
  Segundos is (Dias * 24 * 3600).

meses_em_segundos(Meses, Segundos) :-
  dias_em_segundos(Meses * 30, Segundos).

data_por_opcao(sempre, Resultado) :-
  Resultado is 0.

data_por_opcao(ano, Data) :-
  get_time(DataAtual),
  meses_em_segundos(12, Segundos),
  Data is (DataAtual - Segundos).

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

filtrar(Dialog) :-
  send(Dialog, clear),
  send(Dialog, append, new(Group, dialog_group(buttons, group))),
  send_list(Group, append,
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
  send(Dialog, layout_dialog),
  send(Dialog, layout).

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

format_total(T, R) :-
  format(atom(R), 'Total de Items: ~d', [T]).

mostrar_recomendacoes(D, C, P) :-
  new(Dialog, dialog('Recomendacoes')),
  new(F, font(screen, bold, 12)),
  send(Dialog, background, '#e23e1a'),
  send(Dialog, size, size(1100, 900)),
  send(Dialog, append, new(LB, list_browser)),
  send(LB, size, size(150, 50)),
  send(LB, font, F),

  filtrar_recomendacoes(D, C, P, R),
  send_list(LB, append, R),
  length(R, L),
  format_total(L, T),
  send(Dialog, append, text(T, center, F)),

  send(Dialog, append, button(fechar, message(Dialog, destroy))),
  send(Dialog, default_button, fechar),
  send(Dialog, open_centered).
