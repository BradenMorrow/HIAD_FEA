function [T] = get_T(theta)
%GET_T function [T] = get_T(theta)
%   This function takes the anglular orientation of the laminate, theta, in
%   degrees and returns the transformation matrix.

% Convert theta into radians
theta = theta*pi/180;

% Determine the sin and cosine of the angle
mc = cos(theta);
ns = sin(theta);

% Generate the transformation matrix, T
T = [mc^2   ns^2    2*mc*ns;
     ns^2   mc^2   -2*mc*ns;
    -mc*ns  mc*ns   mc^2 - ns^2];

end

