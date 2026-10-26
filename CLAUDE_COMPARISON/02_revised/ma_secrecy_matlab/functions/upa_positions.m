function T = upa_positions(N, rows, cols, dx, dy)
%UPA_POSITIONS  Uniform planar array centered at the origin (N x 2 positions).
%   dx, dy: element spacings along x and y (default lambda/2 = 0.5).
if nargin < 4, dx = 0.5; end
if nargin < 5, dy = dx; end
xs = ((0:cols-1) - (cols-1)/2) * dx;
ys = ((0:rows-1) - (rows-1)/2) * dy;
[X, Y] = meshgrid(xs, ys);
T = [X(:), Y(:)];
T = T(1:N, :);
end
