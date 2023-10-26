:- use_module(library(pce)).
:- use_module(library(dcg/basics)).
:- use_module(library(format)).
:- use_module(library(system)).

% Obtém a data e hora atuais no formato desejado
get_current_date(DataAtual) :-
    get_time(TimeStamp),
    stamp_date_time(TimeStamp, DateTime, 'UTC'),
    format_time(atom(DataAtual, '%FT%T%z', DateTime)).

% Subtrai uma quantidade específica de horas de uma data e hora no formato desejado
subtrair_horas(DataHora, HorasASubtrair, NovaDataHora) :-
    parse_time(DataHora, DataTime),
    SegundosASubtrair is HorasASubtrair * 3600, % Converte horas em segundos
    DataTime - SegundosASubtrair,
    format_time(atom(NovaDataHora, '%FT%T%z', DataTime)).

% Subtrai uma quantidade específica de dias de uma data e hora no formato desejado
subtrair_dias(DataHora, DiasASubtrair, NovaDataHora) :-
    parse_time(DataHora, DataTime),
    SegundosASubtrair is DiasASubtrair * 86400, % Converte dias em segundos
    DataTime - SegundosASubtrair,
    format_time(atom(NovaDataHora, '%FT%T%z', DataTime)).

% Regra para recomendar vídeos com base na data de upload
recomendar_videos(Opcao, VideosRecomendados) :-
    get_current_date(DataAtual),
    recomendar_videos_por_opcao(Opcao, DataAtual, VideosRecomendados).

% Regras para recomendar vídeos com base na opção escolhida
recomendar_videos_por_opcao("Última hora", DataAtual, VideosRecomendados) :-
    subtrair_horas(DataAtual, 1, DataAnterior),
    findall(Video, (video(_, _, Data, _, _, _, _, _, _, _), Data >= DataAnterior), VideosRecomendados).

recomendar_videos_por_opcao("Hoje", DataAtual, VideosRecomendados) :-
    findall(Video, (video(_, _, Data, _, _, _, _, _, _, _), Data = DataAtual), VideosRecomendados).

recomendar_videos_por_opcao("Esta semana", DataAtual, VideosRecomendados) :-
    subtrair_dias(DataAtual, 7, DataAnterior),
    findall(Video, (video(_, _, Data, _, _, _, _, _, _, _), Data >= DataAnterior, Data =< DataAtual), VideosRecomendados).

recomendar_videos_por_opcao("Este mês", DataAtual, VideosRecomendados) :-
    subtrair_dias(DataAtual, 30, DataAnterior),
    findall(Video, (video(_, _, Data, _, _, _, _, _, _, _), Data >= DataAnterior, Data =< DataAtual), VideosRecomendados).

recomendar_videos_por_opcao("Este ano", DataAtual, VideosRecomendados) :-
    subtrair_dias(DataAtual, 365, DataAnterior),
    findall(Video, (video(_, _, Data, _, _, _, _, _, _, _), Data >= DataAnterior, Data =< DataAtual), VideosRecomendados).




% Consulta de recomendações usando caixa de diálogo
consultar_recomendacoes :-
    new(Dlg, dialog('Recomendação de Vídeos')),
    send(Dlg, size, size(800, 800)), 
    send(Dlg, append, new(Menu, menu(opcao, cycle))),
    opcoes_menu(OpcoesMenu),
    forall(member(Opcao, OpcoesMenu), send(Menu, append, Opcao)),
    send(Dlg, append, button(ok, message(@prolog, handle_recomendacao, Menu?selection))),
    send(Dlg, open).

% Função para lidar com a seleção da opção do menu
handle_recomendacao(Opcao) :-
    opcao_valida(Opcao),
    opcoes(Opcao, OpcaoTexto),
    recomendar_videos(OpcaoTexto, VideosRecomendados),
    listar_videos(VideosRecomendados).

% Verifica se a opção selecionada é válida
opcao_valida(Opcao) :-
    between(1, 5, Opcao).

% Mapeia a opção numérica para o texto correspondente
opcoes(1, "Última hora").
opcoes(2, "Hoje").
opcoes(3, "Esta semana").
opcoes(4, "Este mês").
opcoes(5, "Este ano").

% Defina as opções do menu
opcoes_menu(["Última hora", "Hoje", "Esta semana", "Este mês", "Este ano"]).

% Lista os vídeos recomendados
listar_videos_dialogo(VideosRecomendados) :-
    new(Dlg, dialog('Vídeos Recomendados')),
    send(Dlg, append, new(Text, text)),
    exibir_videos_recomendados(Text, VideosRecomendados),
    send(Dlg, append, button(fechar, message(Dlg, destroy))),
    send(Dlg, open).

% Exibe os vídeos recomendados no componente de texto da caixa de diálogo
exibir_videos_recomendados(Text, []) :-
    send(Text, append, 'Nenhum vídeo recomendado no momento.').
exibir_videos_recomendados(Text, [Video|Resto]) :-
    video(Video, Titulo, _, Data, Categoria, Visualizacoes),
    atomic_list_concat(['ID: ', Video, '\n', 'Título: ', Titulo, '\n', 'Data de Publicação: ', Data, '\n', 'Categoria: ', Categoria, '\n', 'Visualizações: ', Visualizacoes, '\n\n'], Descricao),
    send(Text, append, Descricao),
    exibir_videos_recomendados(Text, Resto).