function [torus_pts,bad_pts,strap_data,r_out,theta,r_def,r_plot,dn,dn_all,trans_pts,cgall] = MASTER_Andy;


addpath Functions


% Folder to batch process
ppath = [cd, '\Test Data'];

% Inputs
save_var = 0;
vid_inp.do_video = 0;
vid_inp.vid_fr = 20;
vid_inp.plot_rad = 2;
vid_inp.plot_int = 1;

% More inputs
[r,ops,ctol,num_pts] = pre_processor_IH;

% Get optimization initial guess values and torus point limits
[Xguess] = get_major_radius_dependent_values('T5');

% Transform data and remove bad points
[torus_pts,bad_pts,strap_data,trans_pts]  = pre_proc_pts(ppath, 5,save_var);



% Number of stages
stages = length(torus_pts);

% Get fitted data
[cgall] = SOLVE_POOL_OF_STAGES_IH(stages,r,Xguess,ops,ctol,num_pts,torus_pts);

% Post process fitted data
[r_out,theta,r_def,r_plot,dn,dn_all] = post_proc_pontos(cgall,ppath,vid_inp);

% Save data
save([ppath,'\ml_out.mat'],'torus_pts','bad_pts','strap_data','r_out','theta','r_def','r_plot','dn','dn_all','trans_pts','cgall')

fclose all;
