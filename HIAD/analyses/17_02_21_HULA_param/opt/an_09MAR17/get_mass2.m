function [mass] = get_mass2(FEM,C,r,straps,param)
% Estimate mass of HIAD (gas and shell)

% Mass of gas, mass of shell and cord mass
m_gas = 0;
m_SH = 0;
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
        p_e = FEM.EL(i).el_in0.p; % Pressure (psi)
        p = p_e*6894.757; % Pressure (Pa)
        r_e = FEM.EL(i).el_in0.r; % Radius of tube (in)
        V_e = pi*r_e^2*L; % Volume (in^3)
        V = V_e*(25.4/1000)^3; % Volume (m^3)
        
        T = 295.372222; % 300; % 300; % Temperature (K)
        M_N2 = 14.07*2; % Atomic mass of Nitrogen (g/mol)
        GC = 8.3144598; % Gas constant (m^3*Pa/(K*?mol)
        lbm_fac = 453.59237; % Conversion factor (g/lbm)
        
        m_gas_i = p*V*M_N2/(GC*T*lbm_fac); % Mass of gas in element (lbm)
        m_gas = m_gas + m_gas_i; % Total mass of gas (lbm)
        
        
        % Braid and bladder mass
        rho_A = .00068895; % Areal mass of braid and bladder (lbf/in^2)
        m_SA_i = 2*pi*r_e*L*rho_A; % Mass of shell in element (lbm)
        m_SH = m_SH + m_SA_i; % Total mass of shell (lbm)
        
        VT = VT + V_e; % Total volume
        SAT = SAT + 2*pi*r_e*L; % Total surface area
    end
    
end


% Mass of straps
c = [0 0; 0 0];
C(1,:) = [];
m_ST = 0;
for j = 1:size(straps,1)
    %% Link Node Locations
    con = straps(j).con;
    
    if con(1) == 0 && con(2) == 0 % Node to node
        ri = 0;
        rj = 0;
        
        c(1,:) = straps(j).node1; % Set nodal location
        c(2,:) = straps(j).node2; % Set nodal location
        
    elseif con(1)~= 0 && con(2) ~= 0 % Torus to torus
        ri = r(con(1));
        rj = r(con(2));
        
        tangent  = circle_tan([C(con(1),:) C(con(2),:)], [ri rj], straps(j).side); % Find tangent line beetween tori
        c(1,:) = tangent(1,:); % Set the left node to the external tangent on the left side
        c(2,:) = tangent(2,:); % Set the right node to the external tangent on the right side
    
    elseif con(1) == 0 && con(2) ~= 0 % Node to torus
        ri = 0;
        rj = r(con(2));
        
        c(1,:) = straps(j).node1; % Set nodal location
        tangent  = circle_tan([straps(j).node1 C(con(2),:)], [ri rj], straps(j).side); % Find tangent line beetween tori
        c(2,:) = tangent(2,:); % Set the right node to the external tangent on the right side
    
    elseif con(1)~= 0 && con(2) == 0 % Torus to node
        ri = r(con(1));
        rj = 0;
        
        tangent  = circle_tan([C(con(1),:) straps(j).node2], [ri rj], straps(j).side); % Find tangent line beetween tori
        c(1,:) = tangent(1,:); % Set the left node to the external tangent on the left side
        c(2,:) = straps(j).node2; % Set nodal location
    end
    
    x0 = c(1,1);
    z0 = c(1,2);
    x1 = c(2,1);
    z1 = c(2,2);
    
    % Length of strap
    L = sqrt((x1 - x0)^2 + (z1 - z0)^2) + pi*ri + pi*rj;
    
    % Mass of strap set
    num = straps(j).num_straps;
    m_ST_j = L*straps(j).rho*num;
    
    % additional strap penalty
    num_pen = (num - 32);
    if num_pen > 0
        m_ST_j = m_ST_j + num_pen; % Extra 2% of total strap mass for every extra strap
    end
    
    % Total mass of straps
    m_ST = m_ST + m_ST_j;
    %%
end


%%
% Mass of cords
param.k_cord_fac_i = ones(7,1)*1;

k_cord = param.k_cord_fac_i; % Area of cords
L = 2*2*pi*C(:,1); % Length of cords
m_c_k = L.*k_cord*(94.531*.1/6516.1); % Mass of cords (assume 10% of shell mass)
m_c = sum(m_c_k); % Total cord mass



% Total mass
% mass0 = m_gas + m_SH + m_ST + m_c;
mass = (m_gas/21.164 + m_SH/94.531 + m_ST/51.968 + m_c/9.4532)/4*1000;
end



