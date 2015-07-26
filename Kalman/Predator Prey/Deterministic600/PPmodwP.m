function dy=PPmodwP(t,x,g,q)
dy=[];
dy(1:6)=pp_odew3p2(t,x(1:6));
tempP=vec2mat(x(7:end));
a10 = x(3);
a12 = x(4);
a21 = x(5);
a20 = x(6);
dfdx = [a10-a12*x(2) -a12*x(1) x(1) -1*x(1)*x(2) 0 0; ...
    a21*x(2) a21*x(1)-a20 0 0 1*x(1)*x(2) -x(2);
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];
Pderiv=dfdx*tempP + tempP*dfdx' + g*q*g';
dy(7:42)=mat2vec(Pderiv);
dy=dy';