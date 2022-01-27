function [r,ops,ctol,num_pts] = pre_processor_IH
% [r,ops,ctol,num_pts,jobs]
% a = dir(folder);
% jobs = {a.name};


% f3d = 0;
r = 13.4/2; % minor radius of torus
ops = optimset(@fminsearch);
ops = optimset(ops,'Display','off');
% ops2 = 0;%optimoptions(@fminunc,'Display','Off','Algorithm','quasi-newton');
ctol = 1e-4;
% track = 1; % 1 = yes, check to make sure points haven't moved too much
% ttol = 0.5; % in
% coded=1; % 1 = only use coded points
% ptol = 25.4*2; % mm, tolerance for locating Pontos dots on steel fixture
%fprintf('NUMBER OF FOLDERS TO PROCESS = %g \n',length(jobs));
% cores = 16;
num_pts = 13; % points to use for fitting torus to local regions
%warning('off','all')
% spmd
%   warning('off','all')
% end
% ref = 1; % reference stage number