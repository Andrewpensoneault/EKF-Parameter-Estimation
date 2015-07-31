function dy=pp_ode_6_19(t,y,q,pop)
a10=q(1);
a12=q(2);
a21=q(3);
a20=q(4);
dy=[y(1)*a10-y(1)*y(2)*a12/pop;y(2)*y(1)*a21/pop-a20*y(2)];
end