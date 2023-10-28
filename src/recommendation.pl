:- use_module(library(pce)). 
:- use_module(library(dcg/basics)). 

inserir_pergunta(Dialog, Pergunta, Menu) :-
  new(Menu, menu(Pergunta)),
  send_list(Menu, append, ['sim', 'nao']),
  send(Dialog, append, Menu).

build_filter(L, N, sim, R) :- append(L, [N], R).
build_filter(L, _, nao, R) :- append(L, [], R).

format_teste(A, B, C, D, E) :-
  build_filter([], 1, A, L1),
  build_filter(L1, 2, B, L2),
  build_filter(L2, 3, C, L3),
  build_filter(L3, 4, D, L4),
  build_filter(L4, 5, E, L5),

  findall(Cat, (preference(Num, Cat), member(Num, L5)), R),
  flatten(R, RR),
  findall(
    Out,
    (
      video(CCat, Chan, Nome, _, _),
      member(CCat, RR),
      format_video(CCat, Chan, Nome, Out)
    ),
    RRR
  ),
  mostrar_recomendacoes(RRR).