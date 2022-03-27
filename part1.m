function [f, x, B] = LP_bourrin(A, b, c)

    if ~ismatrix(A) || ~ismatrix(b) || ~ismatrix(c)
        error('Not matrix or vector');
    end

    [m, n] = size(A);

    if rank(A) < m
        error('A not full rank');
    end

    if length(b) ~= m || length(c) ~= n
        error('b and c dont have same dimensions as A');
    end

    for r1 = 1:m
        for r2 = 1:n
            B = [A(r1,1:n) A(r2,1:n)];
            Binv = inv(B);
            xb=Binv*b;
            
        end
    end
