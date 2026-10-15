pkg load image

caminho = "labirinto.jpg";
img = imread(caminho);

% exibe a imagem original

figure(1);
imshow(img);
title("Imagem original do labirinto");

% processa a imagem
[~, img_redimen] = processar_imagem(img);

% exibe a imagem binária e recortada do labirinto redimensionada para 41x41

figure(2);
imshow(img_redimen);
title("Imagem binária do labirinto");

% IDENTIFICAR A ENTRADA E A SAÍDA NAS LATERAIS

entrada_candidata = find(img_redimen(:, 1) == 1, 1); % encontra o primeiro corredor na lateral esquerda
saida_candidata = find(img_redimen(:, end) == 1, 1); % encontra o primeiro corredor na lateral direita

% verifica se existem corredores nas duas laterais

if isempty(entrada_candidata) || isempty(saida_candidata)
    error("Não foi possível identificar a entrada ou a saída.");
end

% define as coordenadas no formato [linha, coluna]

entrada = [entrada_candidata, 1]
saida = [saida_candidata, size(img_redimen, 2)]


% Criação e plotagem do grafo do labirinto

M = double(img_redimen)
G = matriz_grafo(M);
grafo_plot(G.e(:, [1, 2]), G.n, img_redimen, 1, "Grafo_Imagem.jpg", 3, entrada, saida);


% Busca do caminho minimo por Dijkstra e sua plotagem

entrada_id = (entrada(1) - 1) * G.n + entrada(2);
saida_id = (saida(1) - 1) * G.n + saida(2);

[dist, prev] = dijkstra(G, entrada_id);
edges = otimal_path(entrada_id, saida_id, G.v, prev);


grafo_plot(edges, G.n, img_redimen, 1, "Grafo_Caminho_Otimal.jpg", 4, entrada, saida);

