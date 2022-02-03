function [mass] = get_mass(FEM)
% Estimate mass of HIAD (gas and shell)

m_gas = 0;
m_SA = 0;
VT = 0;
SAT = 0;
% Loop through elements
for i = 1:size(FEM.MODEL.connect,1)
    % If a torus element
    if FEM.MODEL.connect(i,3) == 3
        % Element nodes
        ni = FEM.MODEL.nodes(FEM.MODEL.connect(i,1),:);
        nj = FEM.MODEL.nodes(FEM.MODEL.connect(i,2),:);
        
        % Element length
        L = sqrt(sum((nj - ni).^2));
        
        % Gas mass
        p_e = 15; % FEM.EL(i).el_in0.p; % Pressure (psi)
        p = p_e*6894.757; % Pressure (Pa)
        r = FEM.EL(i).el_in0.r; % Radius of tube (in)
        V_e = pi*r^2*L; % Volume (in^3)
        V = V_e*(25.4/1000)^3; % Volume (m^3)
        
        T = 295.372222; % 300; % 300; % Temperature (K)
        M_N2 = 14.07*2; % Atomic mass of Nitrogen (g/mol)
        GC = 8.3144598; % Gas constant (m^3*Pa/(K*?mol)
        lbm_fac = 453.59237; % Conversion factor (g/lbm)
        
        m_gas_i = p*V*M_N2/(GC*T*lbm_fac); % Mass of gas in element (lbm)
        m_gas = m_gas + m_gas_i; % Total mass of gas (lbm)
        
        % Braid and bladder mass
        rho_A = .00068895; % Areal mass of braid and bladder (lbf/in^2)
        m_SA_i = 2*pi*r*L*rho_A;
        m_SA = m_SA + m_SA_i;
        
        VT = VT + V_e;
        SAT = SAT + 2*pi*r*L;
    end
    
end

(VT - 503334.2)/503334.2*100
(SAT - 138995.6)/138995.6*100


end

