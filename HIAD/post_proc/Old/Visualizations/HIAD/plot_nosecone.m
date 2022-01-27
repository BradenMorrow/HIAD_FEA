function plot_nosecone( nosecone )
% plot_nosecone 
%   Plots nosecone for HIAD

% Get rest of structure
[nosecone] = HIAD_var(nosecone);

% Get variables
c_l = nosecone.c_l;
c_n = nosecone.c_n;
c_t = nosecone.c_t;
h_z = nosecone.h_z;
i_z = nosecone.i_z;
n = nosecone.n;
r_c1 = nosecone.r_c1;
s_l = nosecone.s_l;

% Find radius of sphere
c_z = (r_c1 + h_z*s_l)/s_l;
r_s = sqrt(r_c1.^2 + (h_z - c_z).^2);

% Sphere with radius 1
[x,y,z] = sphere(n);
% Change radius
x = x*r_s;
y = y*r_s;
z = z*r_s;

% Find location where radius of cross section of sphere is closest to r_c
for i = 1:n
  if x(i,1) <= -r_c1
      break
  end
end
if abs(r_c1 + x(i,1)) > abs(r_c1 + x(i - 1,1))
    i = i - 1;
end
    
% Convert coordinates of sphere to nosecone and move up
x = x(1:i,:);
y = y(1:i,:);
z = z(1:i,:) - (z(i,1) - h_z);

% Plot nose cone
surf(x,y,z,'LineStyle','none','FaceColor',c_n)

% Plot connection from nose cone to torus 
if c_t == 1;
    t = linspace(h_z,i_z,n);
    [a,b,c] = cylinder((t - c_l)/s_l,n);
    c = c*(i_z - h_z) + h_z;
    c(1,:) = z(end,:);
    surf(a,b,c,'LineStyle','none','FaceColor',c_n);
end

end

