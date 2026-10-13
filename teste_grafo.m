% 1. Carregar a imagem
img = imread('lab.jpeg');

function [I] = inv(V, n, dist)
  if rem(V, n) ~= 0
    a = rem(V, n);
    b = fix(V / n) + 1;
  else
    a = n;
    b = fix(V / n);
  endif
  I = [8+dist*a, 8+dist*b];
end

function [I] = plotagem(E, n, img, dist)
  if nargin < 4
    dist = 17.26;
  endif

  imshow(img);
  hold on;

  [n_arestas, aux] = size(E);

  for aresta = 1:n_arestas
    v1 = inv(E(aresta, 1), n, dist);
    v2 = inv(E(aresta, 2), n, dist);
    x1 = v1(1);
    x2 = v2(1);
    y1 = v1(2);
    y2 = v2(2);
    plot([x1, x2],[y1, y2], '-bo', 'MarkerFaceColor', 'b', 'LineWidth', 2);
  end
  hold off;
end


% Teste plotando o path
s = 42;
d = 47;
v = [42, 43, 44, 45, 46, 47, 84, 88, 125, 127, 166, 168, 207, 208, 209];
p = [42, 42, 43, 44, 45, 46, 43, 47, 84, 168, 125, 209, 166, 207, 208];

e = path(s, d, v, p)

[I] = plotagem(e, 41, img, 17.26);
