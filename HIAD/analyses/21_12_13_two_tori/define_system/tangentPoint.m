function [tang] = tangentPoint(P1,P2,r,side)
     P = P1-P2;
     d2 = dot(P,P);
     Q0 = P2+r^2/d2*P;
     T = r/d2*sqrt(d2-r^2)*P*[0,1;-1,0];
     Q1 = Q0+T;
     Q2 = Q0-T;
     if(side==1)
        tang = Q1;
     end
     if(side==0)
        tang = Q2;
     end