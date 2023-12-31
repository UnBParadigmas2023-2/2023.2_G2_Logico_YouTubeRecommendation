:- use_module(library(pce)).
:- [data].

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
  format(atom(Result), 'Categoria: ~w | Canal: ~w | Título: ~w', [Category, Channel, Name]).

filtrar_recomendacoes(D, C, P) :-
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
  ),
  mostrar_recomendacoes(R).

format_total(T, R) :-
  format(atom(R), 'Total de Vídeos: ~d', [T]).

mostrar_recomendacoes(R) :-
  new(Dialog, dialog('Recomendacoes')),
  new(F, font(screen, bold, 12)),
  send(Dialog, background, '#ff0000'),
  send(Dialog, size, size(1100, 800)),
  send(Dialog, append, new(LB, list_browser)),
  send(LB, size, size(150, 40)),
  send(LB, font, F),

  send_list(LB, append, R),
  length(R, L),
  format_total(L, T),
  send(Dialog, append, text(T, center, F)),

  send(Dialog, append, button(fechar, message(Dialog, destroy))),
  send(Dialog, default_button, fechar),
  send(Dialog, open_centered).
