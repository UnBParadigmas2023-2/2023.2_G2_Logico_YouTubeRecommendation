# YouTube Recommendation

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo**: 02<br>
**Paradigma**: Lógico<br>

## Alunos
|Matrícula | Aluno |
| -- | -- |
| 20/0013181 | Adne Moretti Moreira |
| 20/0057227 | Caio Vitor Carneiro de Oliveira |
| 19/0085819 | Cícero Barrozo Fernandes Filho |
| 19/0045817 | Gabriel Costa de Oliveira |
| 20/0018205 | Gabriel Moretti de Souza |
| 20/0019015 | Guilherme Puida Moreira |
| 20/0067923 | João Henrique Marques Calzavara |
| 20/2023903 | Lucas Lopes Rocha |

## Sobre 
O projeto se trata de uma ferramenta que usa uma base de dados do Kaggle ([YouTube Trending Video Dataset](https://www.kaggle.com/datasets/rsrishav/youtube-trending-video-dataset?select=BR_youtube_trending_data.csv)) para oferecer recomendações personalizadas de vídeos do YouTube. Você pode refinar suas recomendações por categoria, popularidade (likes por view) e data de publicação. Nossa missão é ajudá-lo a descobrir conteúdo relevante e emocionante de acordo com suas preferências utilizando o paradigma lógico. Este projeto foi inspirado no próprio sistema de filtragem e recomendação do YouTube e no projeto [SpotifyRecommendation](https://github.com/UnBParadigmas2022-1/2022.1_G5_Logico_SpotifyRecommendation).

## Screenshots
Adicione 2 ou mais screenshots do projeto em termos de interface e/ou funcionamento.
![]()
![]()
![]()

## Instalação 
**Linguagens**: Prolog<br>
**Tecnologias**: SWI-Prolog<br>

``` bash
sudo apt-add-repository ppa:swi-prolog/stable
```
``` bash
sudo apt-get update
```
``` bash
sudo apt-get install swi-prolog
```


## Uso 

Para criar os arquivos com os fatos, execute o seguinte comando em Markdown:

``` bash
make tmp/data.pl
```




Explique como usar seu projeto.
Procure ilustrar em passos, com apoio de telas do software, seja com base na interface gráfica, seja com base no terminal.
Nessa seção, deve-se revelar de forma clara sobre o funcionamento do software.

## Vídeo
Adicione 1 ou mais vídeos com a execução do projeto.
Procure: 
(i) Introduzir o projeto;
(ii) Mostrar passo a passo o código, explicando-o, e deixando claro o que é de terceiros, e o que é contribuição real da equipe;
(iii) Apresentar particularidades do Paradigma, da Linguagem, e das Tecnologias, e
(iV) Apresentar lições aprendidas, contribuições, pendências, e ideias para trabalhos futuros.
OBS: TODOS DEVEM PARTICIPAR, CONFERINDO PONTOS DE VISTA.
TEMPO: +/- 15min

## Participações
|Nome do Membro | Contribuição | Significância da Contribuição para o Projeto (Excelente/Boa/Regular/Ruim/Nula) |
| -- | -- | -- |
| Adne Moretti Moreira | --- | Excelente |
| Caio Vitor Carneiro de Oliveira | --- | Excelente |
| Cícero Barrozo Fernandes Filho | --- | Excelente |
| Gabriel Costa de Oliveira | --- | Excelente |
| Gabriel Moretti de Souza | --- | Excelente |
| Guilherme Puida Moreira | --- | Excelente |
| João Henrique Marques Calzavara | --- | Excelente |
| Lucas Lopes Rocha | --- | Excelente |

## Outros

### Lições Aprendidas
- **Paradigma Lógico (Prolog):** A principal lição aprendida foi a compreensão e aplicação do paradigma lógico na programação do sistema de recomendações. Utilizar Prolog como linguagem principal permitiu-nos representar e raciocinar sobre os dados de forma lógica e declarativa, facilitando a manipulação de informações.
- **Processamento de Dados do Kaggle:** Lidar com uma base de dados do Kaggle exigiu habilidades de pré-processamento. Aprendemos a importância da limpeza de dados e do uso eficaz de consultas lógicas para extrair informações relevantes.
- **Recomendações Personalizadas:** Compreendemos como desenvolver algoritmos de recomendação personalizada, considerando preferências do usuário, categorias, popularidade e datas de publicação. A adaptação das recomendações às preferências do usuário foi um desafio significativo.

### Contribuições
- **Implementação Bem-sucedida:** Conseguimos criar com sucesso um sistema de recomendações de vídeos do YouTube baseado em Prolog. Isso permitiu que os usuários recebessem recomendações personalizadas.
- **Utilização Eficiente da Base de Dados do Kaggle:** Aproveitamos ao máximo a base de dados do Kaggle, aproveitando os insights que ela proporcionou para melhorar a qualidade das recomendações.

### Fragilidades
- **Implementação do Paradigma Lógico:** A transição para o paradigma lógico, especificamente o uso do Prolog, representou um desafio considerável para a equipe de desenvolvimento. A lógica declarativa e a abordagem não convencional exigiram tempo para compreensão e ajustes, o que afetou o ritmo do desenvolvimento.

### Possíveis Melhorias
- **Ampliação da Base de Dados:** Buscar fontes de dados adicionais para enriquecer a base de dados e melhorar a variedade e qualidade das recomendações.
- **Inteligência Artificial e Aprendizado de Máquina:** Incorporar técnicas de IA e aprendizado de máquina para aprimorar ainda mais a precisão das recomendações e adaptá-las dinamicamente com base no comportamento de um usuário.
- **Interface do Usuário Aprimorada:** Investir em uma interface de usuário mais amigável e interativa para tornar a experiência do usuário mais agradável.
- **Testes e Avaliações contínuas:** Realizar testes regulares com os usuários para ajustar e melhorar o algoritmo de recomendação com base no feedback real.
- **Expansão para Plataformas Móveis:** Desenvolver versões móveis do programa para atingir um público mais amplo e oferecer recomendações em dispositivos móveis.


## Fontes
- Inspirado em: https://github.com/UnBParadigmas2022-1/2022.1_G5_Logico_SpotifyRecommendation;