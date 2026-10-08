function [distance, previus] = dijkstra(G, s) %G é conjunto de v(vertices) e e(arestas)

  n = length(G.v);
  distance = inf(1, n);
  previus = zeros(1, n) - 1;

  index = find(G.v ==  s);
  distance(index) = 0;
  previus(index) = s;
  looked = zeros(1, n);

  index = 1;
  while all(looked) ~= 1
    m = inf;
    index = -1;
    for i = 1:n
      if (distance(i) < m) && (looked(i) == 0)
        m = distance(i);
        index = i;
      endif
    endfor

    if index == -1
      disp("Grafo disconexo, alguns caminhos não foram possíveis encontrar")
      break
    endif

    looked(index) = 1;
    id = G.v(index);

    for edge = G.e(find(G.e(:, 1) == id), :)'
      index_neighbor = find(G.v == edge(2));

      if (distance(index) + edge(3) < distance(index_neighbor))
        distance(index_neighbor) = distance(index) + edge(3);
        previus(index_neighbor) = index;
      endif
    endfor

  endwhile
end
