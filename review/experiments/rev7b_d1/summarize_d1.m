function summarize_d1(files)
%SUMMARIZE_D1  Prints per-variant averages and paired differences with respect to S0.
A = struct();  dropsAll = [];
for k = 1:numel(files)
    if ~exist(files{k}, 'file'), continue; end
    L = load(files{k});  f = fieldnames(L.R);
    for j = 1:numel(f), A.(f{j}) = L.R.(f{j}); end
end
if ~isfield(A, 'S0'), disp('no S0 results yet'); return; end
ref = A.S0;  v = fieldnames(A);
printf('%-13s %5s %9s %9s %14s %14s %6s %7s %8s %9s %10s %10s\n', 'variant', 'drops', 'mean F', 'mean ESSR', 'dF vs S0 (SE)', 'dESSR vs S0', 'AO it', 'MM it', 'solver', 'time (s)', 'curv med', 'step med');
for j = 1:numel(v)
    r = A.(v{j});  nd = numel(r.F);  dF = r.F - ref.F(1:nd);  dE = r.essr - ref.essr(1:nd);
    c = r.curv;  if isfield(r, 'curvEff') && ~isempty(r.curvEff), c = r.curvEff; end
    if isempty(c), cm = NaN; else, cm = median(c); end
    if isempty(r.step), sm = NaN; else, sm = median(r.step); end
    printf('%-13s %5d %9.4f %9.4f %+7.4f(%.4f) %+7.4f(%.4f) %6.1f %7.1f %8.1f %9.2f %10.2f %10.4f\n', v{j}, nd, mean(r.F), mean(r.essr), ...
        mean(dF), std(dF)/sqrt(max(nd,1)), mean(dE), std(dE)/sqrt(max(nd,1)), mean(r.aoIt), mean(r.mmIt), mean(r.solver), mean(r.tNoOr), cm, sm);
end
end
