function [I] = grafo_plot(E, n, img, name, dist = 17.26, fig = 1, entrada = -1, saida = -1, E2 = [])

  [n_arestas, aux] = size(E);
  x = [];
  y = [];

  for aresta = 1:n_arestas
    v1 = inversa(E(aresta, 1), n, dist);
    v2 = inversa(E(aresta, 2), n, dist);

    x = [x, v1(1), v2(1), nan];
    y = [y, v1(2), v2(2), nan];
  end

  figure(fig)
  imshow(img);
  hold on;

  plot(x, y, "-b.", "MarkerSize", 7);

  [n_arestas, aux] = size(E2);
  x = [];
  y = [];

  for aresta = 1:n_arestas
    v1 = inversa(E2(aresta, 1), n, dist);
    v2 = inversa(E2(aresta, 2), n, dist);

    x = [x, v1(1), v2(1), nan];
    y = [y, v1(2), v2(2), nan];
  end

  plot(x, y, "-r.", "MarkerSize", 7);

  if entrada != -1
    plot(entrada(2), entrada(1), "g.", "MarkerSize", 7);
  endif
  if saida != -1
    plot(saida(2), saida(1), "k.", "MarkerSize", 7);
  endif

  ax = gca();
  frame = getframe(ax);
  imwrite(frame.cdata, name);

  hold off;
end
