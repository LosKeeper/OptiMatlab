function [f, x, B] = LP_Two_Phase_Simplex(A, b, c)
    % Check for errors in the arguments
    if ~ismatrix(A) || ~ismatrix(b) || ~ismatrix(c)
        error('Not matrix or vector');
    end

    [ma, na] = size(A);

    if rank(A) < ma
        error('A not full rank');
    end

    if length(b) ~= ma || length(c) ~= na
        error('b and c dont have same dimensions as A');
    end

    % Create the augmented matrix
    M = [A eye(ma)];
    Y = [zeros(1, na), ones(1, ma)];
    M = [M b; Y 0];
    [m, n] = size(M);

    % Phase 1
    % Transform the matrix into canonical form
    for i = 1:m
        M(end, :) = M(end, :) - M(i, :);
    end

    costCoeff = M(end, :);
    [minimalCost pivotCollumn] = min(costCoeff(1:na));
    indexB = [(na + 1):(na + ma)];

    unbounded = 0;

    while minimalCost < 0 && ~unbounded
        % Check if problem is unbounded
        if max(M(:, pivotCollumn)) <= 0
            unbounded = 1;

        end

        if ~unbounded
            var = Inf

            for i = 1:ma

                if M(i, pivotCollumn) > 0 && M(i, end) / M(i, pivotCollumn) < var
                    var = M(i, end) / M(i, pivotCollumn);
                    pivotRow = i;
                end

            end

            pivot = M(pivotRow, pivotCollumn);

            for i = 1:m

                for j = 1:n

                    if i ~= pivotRow && M(i, j) ~= 0
                        M(i, j) = M(i, j) - M(pivotRow, j) * M(i, pivotCollumn) ./ pivot;
                    end

                end

            end

            for j = 1:n
                M(pivotRow, j) = M(pivotRow, j) ./ pivot;
            end

        end

        % Update index of the basis

        for i = 1:ma

            if indexB(i) == pivotRow + na
                indexB(i) = pivotCollumn;
            end

        end

        % Find next collumn to pivot on
        costCoeff = M(end, :);
        [minimalCost pivotCollumn] = min(costCoeff(1:na));
    end

    if ~unbounded
        btmp = M(1:ma, end);
        Atmp = M(1:ma, 1:na);

        % Phase 2
        [f, x, B] = LP_simplex(Atmp, btmp, c, [1:ma]);

    else
        % Unbounded
        B = [];
        f = Inf;
        x = [];
    end

end
