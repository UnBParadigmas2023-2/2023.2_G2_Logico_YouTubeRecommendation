:- [src/data].

dias_em_segundos(Dias, Segundos) :-
  Segundos is (Dias * 24 * 3600).

meses_em_segundos(Meses, Segundos) :-
  dias_em_segundos(Meses * 30, Segundos).

data_por_opcao(duas_semanas, Data) :-
  get_time(DataAtual),
  dias_em_segundos(14, Segundos),
  Data is (DataAtual - Segundos).

data_por_opcao(mes, Data) :-
  get_time(DataAtual),
  meses_em_segundos(1, Segundos),
  Data is (DataAtual - Segundos).

data_por_opcao(semestre, Data) :-
  get_time(DataAtual),
  meses_em_segundos(6, Segundos),
  Data is (DataAtual - Segundos).

recomendar_por_data :-
  new(Dialog, dialog('Recomendar por data')),
  send(Dialog, size, size(900, 900)),
  send_list(Dialog, append,
            [ new(D, menu(data, cycle)),
              button(cancelar, message(Dialog, destroy)),
              button(pesquisar, and(message(@prolog,
                                            mostrar_recomendacoes,
                                            D?selection),
                                    message(Dialog, destroy)))
            ]),
  send_list(D, append, [duas_semanas, mes, semestre]),
  send(Dialog, default_button, pesquisar),
  send(Dialog, open).

mostrar_recomendacoes(D) :-
  data_por_opcao(D, DataLimite),
  new(Dialog, dialog('Recomendações')),
  send(Dialog, size, size(900, 900)),
  send_list(Dialog, append,
            [ new(LB, list_browser),
              button(fechar, message(Dialog, destroy))
            ]),
  send(Dialog, default_button, fechar),
  send(LB, size, size(200, 200)),
  forall(
    (video(_, _, N, Dd, _), Dd >= DataLimite),
    send(LB, append, N)
  ),
  send(Dialog, open).
