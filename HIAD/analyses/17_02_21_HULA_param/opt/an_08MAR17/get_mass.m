function [mass] = get_mass(FEM,C,r,straps)
% Estimate mass of HIAD (gas and shell)

% Mass of gas and mass of shell
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
    m_ST_j = L*straps(j).rho*straps(j).num_straps;
    
    % Total mass of straps
    m_ST = m_ST + m_ST_j;
    %%
end





% Total mass
mass = m_gas + m_SH + m_ST;
end




% % % 
% % % % Mass of straps
% % % r = [0; r];
% % % m_ST = 0;
% % % for j = 1:size(straps,1)
% % %     % Tori
% % %     ii = straps(j).con(1);
% % %     jj = straps(j).con(2);
% % %     
% % %     % Torus centers
% % %     if ii == 0
% % %         x0 = straps(j).node1(1);
% % %         z0 = straps(j).node1(2);
% % %     else
% % %         x0 = C(ii + 1,1);
% % %         z0 = C(ii + 1,2);
% % %         if straps(j).side == 1
% % %             x0 = x0 - r(ii + 1)*sind(30);
% % %             z0 = z0 + r(ii + 1)*cosd(30);
% % %         else
% % %             x0 = x0 + r(ii + 1)*sind(30);
% % %             z0 = z0 - r(ii + 1)*cosd(30);
% % %         end
% % %     end
% % %     
% % %     if jj == 0
% % %         x1 = straps(j).node2(1);
% % %         z1 = straps(j).node2(2);
% % %     else
% % %         x1 = C(jj + 1,1);
% % %         z1 = C(jj + 1,2);
% % %         if straps(j).side == 1
% % %             x1 = x1 - r(jj + 1)*sind(30);
% % %             z1 = z1 + r(jj + 1)*cosd(30);
% % %         else
% % %             x1 = x1 + r(jj + 1)*sind(30);
% % %             z1 = z1 - r(jj + 1)*cosd(30);
% % %         end
% % %     end
% % %     
% % %     % Length of strap
% % %     L = sqrt((x1 - x0)^2 + (z1 - z0)^2) + pi*r(ii + 1) + pi*r(jj + 1);
% % %     
% % %     % Mass of strap set
% % %     m_ST_j = L*straps(j).rho*straps(j).num_straps;
% % %     
% % %     % Total mass of straps
% % %     m_ST = m_ST + m_ST_j;
% % % end

