function EXECUTE_PHOTOGRAMMETRY_PROCESSING_IH(stages,ppath,ptol,ctol,...
    r,Xguess,ops,rt,zt,num_pts)


torus_pts = read_export_file_and_transform_from_coded_rev2(ppath, ptol, ctol,ops,rt,zt);



    cgall = SOLVE_POOL_OF_STAGES_IH(stages,r,Xguess,ops,ctol,num_pts,torus_pts);

save([ppath,'\cgall_IH_test.mat'],'cgall');
