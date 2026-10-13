% PARTE 1

% carrega imagem original
img = carregar_imagem("labirinto.jpg");

% cria uma janela para exibir a imagem
figure(1);
imshow(img);
title("Imagem original do labirinto");

% processa a imagem e retorna a imagem binária e a matriz 41x41
[img_binaria, img_redimen] = processar_imagem(img);

% exibe a imagem da matriz binária
figure(2);
imshow(img_binaria);
title("Imagem matriz binária original");

% exibe a matriz binária sem a borda externa
% (o recorte continua sendo realizado dentro da função)
figure(3);
imshow(img_redimen);
title("Labirinto processado");

% exibe a matriz numérica
disp("Matriz binária do labirinto 41x41:");
disp(double(img_redimen));

% exibe a imagem labirinto em 41x41
figure(4);
imshow(img_redimen);
title("Imagem labirinto em 41x41");

% IDENTIFICAR A ENTRADA E A SAÍDA NAS LATERAIS

entrada_candidata = find(img_redimen(:, 1) == 1);
saida_candidata = find(img_redimen(:, end) == 1);

% verifica se existem corredores nas laterais
if isempty(entrada_candidata) || isempty(saida_candidata)
    error("Não foi possível identificar a entrada ou a saída.");
end

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

% plotagem final, labirinto 41x41, com entrada e saída identificadas
figure(5);
imshow(img_redimen);
title("Imagem labirinto em 41x41: entrada e saída identificadas");
hold on;

plot(entrada(2), entrada(1), "go", ...
     "MarkerSize", 10, "LineWidth", 2);

plot(saida(2), saida(1), "ro", ...
     "MarkerSize", 10, "LineWidth", 2);
