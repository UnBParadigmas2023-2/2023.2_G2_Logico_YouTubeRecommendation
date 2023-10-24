:- use_module(library(pce)).
% :- consult('recommendation/date').
:- consult('helpers').

% Defina a janela principal
% Consulta de recomendações usando caixa de diálogo
menu :-
    % A IMPLEMENTAR
    write('menu').

% Loop da main que continua com o menu até que o usuáŕio feche a janela
main :-
    menu,
    get(L, confirm, _),
    exit().

% Regra para sair do programa
exit :-
    write('Encerrando programa...'), nl,
    halt(0).

% Inicialize a interface gráfica chamando main/0
:- main.
