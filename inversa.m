function [I] = inversa(V, n, dist)
  if rem(V, n) ~= 0
    a = rem(V, n);
    b = fix(V / n) + 1;
  else
    a = n;
    b = fix(V / n);
  endif
  I = [dist*a, dist*b];
end
