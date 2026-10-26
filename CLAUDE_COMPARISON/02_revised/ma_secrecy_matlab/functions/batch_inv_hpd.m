function X = batch_inv_hpd(G)
%BATCH_INV_HPD  Inverts S Hermitian positive definite M x M matrices stored in
%   G (M x M x S) by Gauss-Jordan elimination vectorized over the third dimension
%   (no pivoting is needed for positive definite matrices in exact arithmetic).
%   Numerical safeguards reject unsafe pivots or reciprocal infinity-condition
%   estimates <= 1e-12. Rejection fails the experiment; no fading sample is
%   removed or redrawn. Accepted matrices retain the original arithmetic.

[M, ~, S] = size(G);
if M == 0 || size(G,2) ~= M || any(~isfinite(G(:)))
    error('revision:InvalidGram','Gram matrices must be finite, nonempty and square');
end
normG = max(sum(abs(G),2),[],1);
pivotTolerance = 64*eps(class(G))*normG;
A = G;
X = repmat(eye(M), [1 1 S]);
for k = 1:M
    piv = A(k, k, :);
    if any(~isfinite(piv(:))) || any(real(piv(:)) <= pivotTolerance(:)) ...
            || any(abs(imag(piv(:))) > pivotTolerance(:))
        error('revision:IllConditionedGram', ...
            'Unsafe Gram pivot; experiment aborted without dropping fading samples');
    end
    A(k, :, :) = A(k, :, :) ./ repmat(piv, [1 M 1]);
    X(k, :, :) = X(k, :, :) ./ repmat(piv, [1 M 1]);
    for i = [1:k-1, k+1:M]
        f = A(i, k, :);
        A(i, :, :) = A(i, :, :) - repmat(f, [1 M 1]) .* A(k, :, :);
        X(i, :, :) = X(i, :, :) - repmat(f, [1 M 1]) .* X(k, :, :);
    end
end
reciprocalCondition = 1 ./ (normG .* max(sum(abs(X),2),[],1));
if any(~isfinite(X(:))) || any(~isfinite(reciprocalCondition(:))) ...
        || any(reciprocalCondition(:) <= 1e-12)
    error('revision:IllConditionedGram', ...
        'Reciprocal Gram condition estimate <= 1e-12; experiment aborted');
end
end
