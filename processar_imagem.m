
function [img_binaria, img_redimen] = processar_imagem(img)

    % VERIFICA E CONVERTE A IMAGEM PARA TONS DE CINZA
    if ndims(img) == 2
        img_cinza = img;
    else
        img_cinza = rgb2gray(img);
    end

    % transforma a imagem em binaria: 0 para paredes e 1 para corredores
    img_binaria = im2bw(img_cinza);

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
        error("Não foi possível recortar a imagem do labirinto.");
    end

    % mostra as dimensoes no terminal
    disp("Dimensões da matriz recortada:");
    disp(size(img_recortada));

    % a matriz é 708x708, agora vamos redimensioná-la para 41x41
    img_redimen = imresize(img_recortada, [41, 41], "nearest");

    % confere se a matriz possui as dimensoes esperadas
    if ~isequal(size(img_redimen), [41, 41])
        error("A matriz do labirinto não possui dimensões 41x41.");
    end

    disp("Dimensões finais:");
    disp(size(img_redimen));

    % converte para valores numericos 0 e 1
    img_redimen = double(img_redimen);

end
