function [U_pt] = tor_disp(ind,tor)
% Generate the initial cable displacments


U0 = zeros(ind.ind8(end)*6,1);
U0(1:ind.ind1(end)*6) = tor.Utor0;

U_pt = [U0*0 U0];

end

