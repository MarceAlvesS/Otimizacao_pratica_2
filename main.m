pkg load image

caminho = "labirinto.jpg";
img = imread(caminho);

[~, img_redimen] = processar_imagem(img);


entrada_candidata = find(img_redimen(:, 1) == 1, 1);
saida_candidata = find(img_redimen(:, end) == 1, 1);

if isempty(entrada_candidata) || isempty(saida_candidata)
    error("Não foi possível identificar a entrada ou a saída.");
end

entrada = [entrada_candidata(1), 1]
saida = [saida_candidata(end), size(img_redimen, 2)]



figure(1);
imshow(img_redimen);
hold on;

plot(entrada(2), entrada(1), "g.", "MarkerSize", 22); ## MarkerSize quando salva fica 2x menor que no plot
plot(saida(2), saida(1), "r.", "MarkerSize", 22); ## MarkerSize quando salva fica 2x menor que no plot

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

