:- use_module(library(dcg/basics)).
:- use_module(library(format)).
:- use_module(library(system)).

:- use_module(library(http/json)).

% Regra para carregar os dados do JSON
carregar_json(Dados) :-
    json_read_dict('categories.json', Dados).

% Exemplo de dados carregados do JSON
% (Certifique-se de substituir isso pelos dados reais do JSON)
dados_json([
    _{ id: "1", title: "Film & Animation" },
    _{ id: "2", title: "Autos & Vehicles" },
    _{ id: "3", title: "Music" },
    % Adicione mais categorias conforme necessário
]).

% Exemplo de dados de vídeos
% (Certifique-se de substituir isso pelos dados reais)
dados_de_videos([
    _{ video_id: "abc123", title: "Video 1", category_id: "1" },
    _{ video_id: "def456", title: "Video 2", category_id: "2" },
    _{ video_id: "ghi789", title: "Video 3", category_id: "1" },
    % Adicione mais vídeos e categorias conforme necessário
]).

% Regra para recomendar vídeos por categoria
recomendar_videos_por_categoria(Categoria, VideosRecomendados) :-
    dados_json(Categorias), % Carregar as categorias do JSON
    dados_de_videos(Videos), % Carregar os dados dos vídeos

    % Encontrar vídeos com base na categoria
    findall(Video, (member(Cat, Categorias), Cat.title = Categoria, member(Video, Videos), Video.category_id = Cat.id), VideosRecomendados).

% Exemplo de uso: Recomendar vídeos na categoria "Film & Animation"
?- recomendar_videos_por_categoria("Film & Animation", VideosRecomendados).
