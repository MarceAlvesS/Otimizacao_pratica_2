function [edges] = otimal_path(start, destination, vertices, previous)

    p = destination;

    while p ~= start
      ind = find(vertices == p(end), 1);

      if isempty(ind) || previous(ind) == p(end)
        error('Caminho não encontrado');
      endif

      p(end+1) = vertices(previous(ind));
    endwhile

    p = fliplr(p);


    edges = [];

    for i = 1:length(p)-1
      u = p(i);
      v = p(i+1);
      edges = [edges; u, v; v, u];

    endfor
end
