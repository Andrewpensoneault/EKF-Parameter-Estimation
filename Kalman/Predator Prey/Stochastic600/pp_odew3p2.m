function dy=pp_odew3p2(t,y,pop)
a10=y(3);
a12=y(4);
a21=y(5);
a20=y(6);
dy=[y(1)*a10-y(1)*y(2)*a12/pop;y(2)*y(1)*a21/pop-a20*y(2);0;0;0;0];
end
