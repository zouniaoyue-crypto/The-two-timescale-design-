A = load('d1_A.mat');  B = load('d1_B.mat');
R = A.R;  R.S1zheng = B.R.S1zheng;
v = {'S0','Stage1only','S1best','S1zheng','S0local'};
for j = 1:numel(v)
  r = R.(v{j});  c = r.curv;  if ~isempty(r.curvEff), c = r.curvEff; end
  if isempty(c), q = [NaN NaN NaN]; else, s = sort(c); q = [s(max(1,round(0.25*numel(s)))) median(s) s(max(1,round(0.75*numel(s))))]; end
  if isempty(r.step), sm = NaN; else, sm = median(r.step); end
  dF = r.F - R.S0.F;  dE = r.essr - R.S0.essr;
  printf('%-11s F %.4f dF %+.4f (%.4f) E %.4f dE %+.4f (%.4f) AO %.1f [%d-%d] MM %.1f [%d-%d] t %.3f curv q25/50/75 %.2f/%.2f/%.2f step %.5f viol %d\n', v{j}, mean(r.F), mean(dF), std(dF)/sqrt(10), mean(r.essr), mean(dE), std(dE)/sqrt(10), mean(r.aoIt), min(r.aoIt), max(r.aoIt), mean(r.mmIt), min(r.mmIt), max(r.mmIt), mean(r.tNoOr), q, sm, sum(r.viol));
end
printf('S1best oracle curv (curv field) median %.2f\n', median(R.S1best.curv));
printf('S1zheng curv field (Eve oracle) median %.2f\n', median(R.S1zheng.curv));
