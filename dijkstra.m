function [distance, previus] = djikstra(G, s) %G é conjunto de v(vertices) e e(arestas)
  n = length(G.v);
  distance = inf(1, n);
  previus = zeros(1, n) - 1;

  index = find(G.v =  s);
  distance(index) = 0;
  previus(index) = s;

  looked = [s];

  disp(distance(find(any(G.v) = looked));
  %while distance(~looked)
  %  index = min(distance(~looked))
  %  disp(index);
  %  looked(length(looked) + 1) = index;
  %endwhile
end
