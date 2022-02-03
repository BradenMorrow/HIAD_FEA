function [theta_ind] = indices(theta,strap_ind,EL_link)

% Indices of elements for post processing
% Preallocate
theta_ind(29,1).ind = [];

% Torus
theta_ind(1).ind = (1:size(theta,1))' + size(theta,1)*0;
theta_ind(2).ind = (1:size(theta,1))' + size(theta,1)*1;
theta_ind(3).ind = (1:size(theta,1))' + size(theta,1)*2;
theta_ind(4).ind = (1:size(theta,1))' + size(theta,1)*3;
theta_ind(5).ind = (1:size(theta,1))' + size(theta,1)*4;
theta_ind(6).ind = (1:size(theta,1))' + size(theta,1)*5;

% Interaction
theta_ind(7).ind = (1:size(theta,1))' + size(theta,1)*6;
theta_ind(8).ind = (1:size(theta,1))' + size(theta,1)*7;
theta_ind(9).ind = (1:size(theta,1))' + size(theta,1)*8;
theta_ind(10).ind = (1:size(theta,1))' + size(theta,1)*9;
theta_ind(11).ind = (1:size(theta,1))' + size(theta,1)*10;
theta_ind(12).ind = (1:size(theta,1))' + size(theta,1)*11;

% Links
theta_ind(13).ind = (1:size(EL_link,1))' + size(theta,1)*12;

% Straps
% All straps
strap_ind_all = (1:size(strap_ind,1))' + theta_ind(13).ind(end);

% Strap sets
theta_ind(14).ind = strap_ind_all(strap_ind == 1); % Loop1, aft1
theta_ind(15).ind = strap_ind_all(strap_ind == 2); % Loop1, aft2
theta_ind(16).ind = strap_ind_all(strap_ind == 3); % Loop1, aft3
theta_ind(17).ind = strap_ind_all(strap_ind == 4); % Loop1, fore1
theta_ind(18).ind = strap_ind_all(strap_ind == 5); % Loop1, fore2
theta_ind(19).ind = strap_ind_all(strap_ind == 6); % Loop1, fore3
theta_ind(20).ind = strap_ind_all(strap_ind == 7); % Loop2, aft1
theta_ind(21).ind = strap_ind_all(strap_ind == 8); % Loop2, aft2
theta_ind(22).ind = strap_ind_all(strap_ind == 9); % Loop2, aft3
theta_ind(23).ind = strap_ind_all(strap_ind == 10); % Loop2, fore1
theta_ind(24).ind = strap_ind_all(strap_ind == 11); % Loop2, fore2
theta_ind(25).ind = strap_ind_all(strap_ind == 12); % Loop2, fore3
theta_ind(26).ind = strap_ind_all(strap_ind == 13); % Radial, aft
theta_ind(27).ind = strap_ind_all(strap_ind == 14); % Chevron, aft
theta_ind(28).ind = strap_ind_all(strap_ind == 15); % Radial, fore
theta_ind(29).ind = strap_ind_all(strap_ind == 16); % Chevron, fore

end

