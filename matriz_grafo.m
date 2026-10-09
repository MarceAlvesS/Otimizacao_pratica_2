function [G] = matriz_grafo(M)

    [m, n] = size(M);

    % Vertices
    V = [];
    % Arestas
    E = [];

    % Selecao dos vertices
    for linha = 1:m
        for coluna = 1:n
            if M(linha, coluna) ~= 0
                M(linha, coluna) = (linha - 1)*n + coluna;
                V = [V, M(linha, coluna)];
            end
        end
    end

    % Selecao das arestas (peso 1)
    for linha = 1:m
        for coluna = 1:n

            if M(linha, coluna) ~= 0

                vertice = M(linha, coluna);

                if linha < m
                    if M(linha + 1, coluna) ~= 0
                        E = [E; vertice, M(linha + 1, coluna), 1];
                    end
                end

                if linha > 1
                    if M(linha - 1, coluna) ~= 0
                        E = [E; vertice, M(linha - 1, coluna), 1];
                    end
                end

                if coluna < n
                    if M(linha, coluna + 1) ~= 0
                        E = [E; vertice, M(linha, coluna + 1), 1];
                    end
                end

                if coluna > 1
                    if M(linha, coluna - 1) ~= 0
                        E = [E; vertice, M(linha, coluna - 1), 1];
                    end
                end

            end
        end
    end

    % Cria uma estrutura com os vertices e arestas
    G = struct();
    G.v = V;
    G.e = E;

end
