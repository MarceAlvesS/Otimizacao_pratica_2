function img = carregar_imagem(caminho)

    % carrega biblioteca "image package"
    pkg load image

    % carrega imagem original
    img = imread(caminho);

end
