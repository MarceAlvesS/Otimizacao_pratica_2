pkg load image % carrega bibliotecs "image package"

% carrega a imagem original
caminho = "labirinto.jpg";
img = imread(caminho);

% exibe a imagem original
figure(1);
imshow(img);
title("Imagem original do labirinto");

% chama a função processar_imagem
[~, img_redimen] = processar_imagem(img);

% exibe a matriz numérica do labirinto
disp("Matriz binária do labirinto 41x41:");
disp(double(img_redimen));

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
entrada = [entrada_candidata(1), 1]
saida = [saida_candidata(end), size(img_redimen, 2)]

% verifica se as posições correspondem a corredores
if img_redimen(entrada(1), entrada(2)) ~= 1
    error("A entrada não corresponde a um corredor.");
end

if img_redimen(saida(1), saida(2)) ~= 1
    error("A saída não corresponde a um corredor.");
end

% exibe o labirinto com a entrada e a saída identificadas
figure(3);
imshow(img_redimen);
title("Imagem labirinto em 41x41: entrada e saída identificadas");
hold on;

plot(entrada(2), entrada(1), "go", "MarkerSize", 10, "LineWidth", 2);
plot(saida(2), saida(1), "ro", "MarkerSize", 10, "LineWidth", 2);

% Guarda a figura final em formato JPEG
print(gcf, "labirinto_entrada_saida.jpg", "-djpeg", "-S600,600")
hold off;

M = double(img_redimen);
G = matriz_grafo(M);

grafo_plot(G.e(:, [1, 2]), G.n, img_redimen, 1, "Grafo_Imagem.jpg", 2);

entrada_id = (entrada(1) - 1) * G.n + entrada(2)
saida_id = (saida(1) - 1) * G.n + saida(2)

[dist, prev] = dijkstra(G, entrada_id);
edges = otimal_path(entrada_id, saida_id, G.v, prev);


grafo_plot(edges, G.n, img_redimen, 1, "Grafo_Caminho_Otimal.jpg", 3);

