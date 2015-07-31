function[]=interval(bb,parameters)
%Finds Confidence Interval
meanbb=mean(bb);
SEM = std(bb)/sqrt(length(bb(:,1)));              % Standard Error
ts = tinv([0.025  0.975],length(bb(:,1))-1);      % T-Score
CIH = meanbb + ts(2)*SEM;                          % Confidence Intervals
CIL = meanbb - ts(2)*SEM;
errorr = abs(100*(meanbb-parameters)./parameters);
fprintf('With confidence of .95, beta lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(1),meanbb(1),CIH(1),errorr(1))
fprintf('With confidence of .95, gamma lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n ',CIL(2),meanbb(2),CIH(2),errorr(2))
fprintf('With confidence of .95, gamma lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(3),meanbb(3),CIH(3),errorr(3))
fprintf('With confidence of .95, gamma lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(4),meanbb(4),CIH(4),errorr(4))