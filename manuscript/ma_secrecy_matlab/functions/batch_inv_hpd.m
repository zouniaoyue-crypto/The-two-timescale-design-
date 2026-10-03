function X = batch_inv_hpd(G)
%BATCH_INV_HPD  Inverts S Hermitian positive definite M x M matrices stored in
%   G (M x M x S) by Gauss-Jordan elimination vectorized over the third dimension
%   (no pivoting is needed for positive definite matrices).

[M, ~, S] = size(G);
A = G;
X = repmat(eye(M), [1 1 S]);
for k = 1:M
    piv = A(k, k, :);
    A(k, :, :) = A(k, :, :) ./ repmat(piv, [1 M 1]);
    X(k, :, :) = X(k, :, :) ./ repmat(piv, [1 M 1]);
    for i = [1:k-1, k+1:M]
        f = A(i, k, :);
        A(i, :, :) = A(i, :, :) - repmat(f, [1 M 1]) .* A(k, :, :);
        X(i, :, :) = X(i, :, :) - repmat(f, [1 M 1]) .* X(k, :, :);
    end
end
end
