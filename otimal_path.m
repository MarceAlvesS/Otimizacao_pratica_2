function [edges] = otimal_path(start, destination, vertices, previous)

    p = destination;

    while p ~= start
      ind = binary_search(vertices, p(end));

      if isempty(ind) || previous(ind) == p(end)
        error('Caminho não encontrado');
      endif

      p(end+1) = vertices(previous(ind));
    endwhile

    p = fliplr(p);

    L = length(p);
    edges = zeros(2*(L-1), 2);

    for i = 1:L-1
        u = p(i);
        v = p(i+1    );

        edges(2*i-1, :) = [u, v];
        edges(2*i, :)   = [v, u];
    endfor
endfunction


function ind = binary_search(vertices, value)

    left = 1;
    right = length(vertices);
    ind = [];

    while left <= right

        mid = floor((left + right) / 2);

        if vertices(mid) == value
            ind = mid;
            return;
        elseif vertices(mid) < value
            left = mid + 1;
        else
            right = mid - 1;
        endif

    endwhile

endfunction
