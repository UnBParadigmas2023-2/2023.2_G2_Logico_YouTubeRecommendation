% helpers.pl

% Regra para criar uma janela com a lista de resultados
resultados(VideosRecomendados, Filtro) :-
    new(R, dialog('Resultados')),
    listarVideos(R, VideosRecomendados),
    send(R, open).

% Regra para listar os videos filtrados, exibindo apenas os nomes
listarVideos(_, []).
listarVideos(R, [(_,_,Title,_,_) | H]) :-
    new(RT, text(Title)),
    send(R, append, RT),
    listarVideos(R, H).

% Função para adicionar um novo vídeo à base de dados
adicionar_video(Category, Channel, Title, Date, Likes) :-
    assertz(videos(Category, Channel, Title, Date, Likes)).

% Função para remover um vídeo da base de dados
remover_video(Category, Channel, Title, Date, Likes) :-
    retract(videos(Category, Channel, Title, Date, Likes)).
