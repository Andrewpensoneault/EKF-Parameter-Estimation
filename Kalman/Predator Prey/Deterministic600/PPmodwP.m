function dy=PPmodwP(t,x,g,q,pop)
dy=[];
dy(1:6)=pp_odew3p2(t,x(1:6),pop);
tempP=vec2mat(x(7:end));
% bigx=myAD(x(1:6));
% result1=pp_odew3p2(t,bigx,pop);
% dfdx=getderivs(result1);
a10 = x(3);
a12 = x(4);
a21 = x(5);
a20 = x(6);
dfdx = [a10-a12/pop*x(2) -a12/pop*x(1) x(1) -1/pop*x(1)*x(2) 0 0; ...
    a21/pop*x(2) a21/pop*x(1)-a20 0 0 1/pop*x(1)*x(2) -x(2);
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];
Pderiv=dfdx*tempP + tempP*dfdx' + g*q*g';
dy(7:42)=mat2vec(Pderiv);
dy=dy';