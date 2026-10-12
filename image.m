% PARTE 1

% carrega biblioteca "image package"
pkg load image

% carrega imagem original, cria uma janela 1 em branco para exibir a imagem
img = imread("labirinto.jpg");
figure(1);
imshow(img); % mostra a imagem img 
title("Imagem original do labirinto"); % adiciona título

% VERIFICA E CONVERTE A IMAGEM PARA TONS DE CINZA
if ndims(img) == 2
    img_cinza = img;
else
    img_cinza = rgb2gray(img);
end

% transforma a imagem em binaria: 0 para paredes e 1 para corredores
img_binaria = im2bw(img_cinza);

% mesmo prcesso feito com a Figura 1, agora para exibir a imagem da matriz binária
figure(2); 
imshow(img_binaria);
title("Imagem matriz binária original");

% SEPARA A MATRIZ DO LABIRINTO DA BORDA BRANCA AO REDOR DA IMAGEM
% identifica os pixels escuros
pixels_labirinto = img_binaria == 0;

% encontra linhas e colunas que possuem pixels escuros
linhas = find(any(pixels_labirinto, 2));
colunas = find(any(pixels_labirinto, 1));

% determina os limites do labirinto
linha_inicial = min(linhas);
linha_final = max(linhas);

coluna_inicial = min(colunas);
coluna_final = max(colunas);

% recorta somente a matriz binaria
img_recortada = img_binaria( ...
    linha_inicial:linha_final, ...
    coluna_inicial:coluna_final);

% verifica se o recorte foi realizado corretamente
if isempty(img_recortada)
    error("Nao foi possivel recortar a imagem do labirinto.");
end

% exibe o resultado
figure(3);
imshow(img_recortada);
title("Matriz binaria sem a borda externa");

% mostra as dimensoes no terminal
disp("Dimensoes da matriz recortada:");
disp(size(img_recortada));

% a matriz é 708x708, agora vamos redimension-ala para 41x41
img_redimen = imresize(img_recortada, [41, 41], "nearest");

% confere se a matriz possui as dimensoes esperadas
if ~isequal(size(img_redimen), [41, 41])
    error("A matriz do labirinto nao possui dimensoes 41x41.");
end

disp("Dimensões finais:");
disp(size(img_redimen));

figure(4);
imshow(img_redimen);
title("Imagem labirinto em 41x41");

% IDENTIFICAR A ENTRADA E A SAÍDA NAS LATERAIS

entrada_candidata = find(img_redimen(:, 1) == 1);
saida_candidata = find(img_redimen(:, end) == 1);

% Define as coordenadas [linha, coluna]
entrada = [entrada_candidata(1), 1];
saida = [saida_candidata(end), size(img_redimen, 2)];

% Verifica se as posicoes correspondem a corredores
if img_redimen(entrada(1), entrada(2)) ~= 1
    error("A entrada nao corresponde a um corredor.");
end

if img_redimen(saida(1), saida(2)) ~= 1
    error("A saida nao corresponde a um corredor.");
end

% Exibe as coordenadas
disp("Primeiro corredor na lateral esquerda (entrada):");
disp(entrada);

disp("Último corredor na lateral direita (saída):");
disp(saida);

% plotagem final, labirinto 41x41, recortado e com a saída e a entrada identificadas
figure(5);
imshow(img_redimen);
title("Imagem labirinto em 41x41: entrada e saída identificadas");
hold on;

plot(entrada(2), entrada(1), "go", ...
     "MarkerSize", 10, "LineWidth", 2);

plot(saida(2), saida(1), "ro", ...
     "MarkerSize", 10, "LineWidth", 2);

hold off;
