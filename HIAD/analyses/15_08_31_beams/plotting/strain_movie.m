% Create strain movie
% December 01, 2015

% Load output
% 60 degree
% load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\plotting\M_01DEC15.mat')
% 71 degree
% load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\plotting\M_08DEC15.mat')
% 55 degree
load('C:\Users\andrew.young\Desktop\FE_code\flex_06NOV15\analysis\15_08_31_beams\plotting\M2_08DEC15.mat')

M = FEM_out.OUT.M';
M_ind = (1:size(M,1))';
M_ind = [M_ind; (M_ind(end):-1:1)'];

movie_test = VideoWriter('beam_strain_55.avi');
movie_test.FrameRate = 10; %150;
open(movie_test)
writeVideo(movie_test,M(M_ind))
close(movie_test)

