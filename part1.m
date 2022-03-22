function [f,x,B] = LP_bourrin(A,b,c)
    if  ~ismatrix(A) | ~ismatrix(b) | ~ismatrix(c)
        error('Not matrix or vector');
    end

    [m,n]=size(A);

    if rank(A)<m
        error('A not full rank');
    end

    if length(b) ~=m | length(c) ~=n
        error('b and c dont have same dimensions as A');
    end

    for i=1:m
        D = nchoosek(A(i,1:n),m)

end