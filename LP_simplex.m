function [f, x, B] = LP_Simplex(A, b, c, v)

    % Check for errors in the arguments
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

    % Initialisation of the variables
    Btmp = A(:, v); % Btmp is the basis matrix
    M = [A; c']; % M is the augmented matrix
    M2 = M(:, v); % M2  matrix with B and cb'
    index = zeros(1, 1); % index is the index of the pivot column

    addCollumn = 1; % addCollumn is the boolean variable that indicates if a new column is added to the basis matrix

    for i = 1:n
        % for each column of the basis matrix we check if it's a collumn of the basis matrix
        for j = 1:m

            if v(j) == i
                addCollumn = 0;
            end

        end

        if addCollumn
            index = horzcat(index, [i]);
        end

        addCollumn = 1;
    end

    index = index(:, 2:n - m + 1);
    D = M(:, index); % D is the matrix with D and cd'
    b2 = [b; 0]; % b2 is the vector with b and 0
    M = [M2 D b2]; % M is the augmented matrix

    M = [inv(Btmp) zeros(m, 1); zeros(1, m) 1] * M;
    M = [eye(m) zeros(m, 1); -transpose(c(1:m, :)) 1] * M; % M is the canonical form of the LP problem

    costCoeff = M(end, :); % costCoeff is the vector of the reduced cost coefficients
    [minimalCost pivotCollumn] = min(costCoeff(m + 1:n)); % minimalCost is the minimal cost and pivotCollumn is the collumn to add to the basis matrix

    indexB = v;
    unbounded = 0; % unbounded is the boolean variable that indicates if the problem is unbounded

    while minimalCost < 0 && ~unbounded
        % while the problem is not unbounded and the minimal cost is negative
        if max(M(:, pivotCollumn)) <= 0
            unbounded = 1; % the problem is unbounded
        end

        if ~unbounded
            % Calculate pivoting row
            var = Inf;

            for i = 1:m + 1

                if (M(i, pivotCollumn) > 0) && ((M(i, n + 1) / M(i, pivotCollumn)) < var)
                    var = M(i, n + 1) / M(i, pivotCollumn);
                    pivotRow = i;
                end

            end

            pivot = M(pivotRow, pivotCollumn);

            for i = 1:m + 1

                for j = 1:n + 1

                    if i ~= pivotRow && j ~= pivotCollumn
                        M(i, j) = M(i, j) - (M(i, pivotCollumn) * M(pivotRow, j)) ./ pivot;
                    end

                end

            end

            for i = 1:m + 1

                if i ~= pivotRow
                    M(i, pivotCollumn) = 0
                end

            end

            for j = 1:n + 1
                M(pivotRow, j) = M(pivotRow, j) ./ pivot;
            end

        end

        % Update the basis matrix
        for i = 1:m

            if indexB(i) == pivotCollumn
                indexB(i) = pivotRow;
            end

        end

        % Next collumn to check
        costCoeff = M(end, :);
        [minimalCost pivotCollumn] = min(costCoeff(m + 1:n));
        pivotCollumn = pivotCollumn + m;
    end

    if ~unbounded
        B = indexB;
        xb = M(1:m, end);
        Xtmp = zeros(n, 1);

        for i = 1:m
            Xtmp(B(i)) = xb(i);
        end

        x = Xtmp;
        f = -M(end, end);
    else
        B = [];
        f = Inf;
        x = [];
    end

end
