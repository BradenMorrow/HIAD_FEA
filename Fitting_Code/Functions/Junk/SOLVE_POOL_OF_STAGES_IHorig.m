function [cgall] = SOLVE_POOL_OF_STAGES_IH(num_stages, r, Xguess, ops, ctol, ...
    num_pts, torus_pts)

% torus_pts = load([ppath,'\torus_pts.mat']);
% torus_pts = torus_pts.torus_pts;
cgall = cell(num_stages,1);
% cgall{1} = lastpts;

%nstages = jobs(end) - jobs(1);
%Xguess2 = [0.1; 0.1; 1; 55; 0.01; 0.01];% x, y, z [shifts], R, thetaX, thetaY
% pts95 = zeros(num_pts,3,num_stages);
Xg = zeros(6,430);
for j = 1:num_stages%par
    
    aptsnum = torus_pts{j}(:,1); 
    x0 = torus_pts{j}(:,2); 
    y0 = torus_pts{j}(:,3); 
    z0 = torus_pts{j}(:,4);
    [thetapt, ind] = atan2pos(torus_pts{j}(:,2:4)); 
    x0 = x0(ind); 
    y0 = y0(ind); 
    z0 = z0(ind);
    aptsnum = aptsnum(ind); 
    apts = torus_pts{j}(ind,2:4); 
    n = (num_pts-1)/2;
    pts_wextra = get_indices_IH(x0,y0,z0,n); 
    
    ractual = zeros(size(x0,1),1);
    thetaactual = zeros(size(x0,1),1);
    cgrall = zeros(size(x0,1),3);
    Rc = zeros(size(x0,1),1);
   Xgc = Xg(:,aptsnum);
   Xgc(:,~sum(Xgc)) = repmat(Xguess,1,sum(~sum(Xgc)));
   Xgn = zeros(6,length(x0));
   ind329 = find(aptsnum == 329);
    parfor i = 1 : size(x0,1)
        ptsi = pts_wextra(i:i+2*n,:);

        fun2min = @(x) get_phi_best_fit_torus_point_cloud(x,ptsi,r);

        [X2,phi] = fminsearch(fun2min,Xgc(:,i),ops); % create blue torus
        philast = 10^6; iter = 1;
        while philast - phi > ctol && iter < 1000
            philast = phi;
            [X2,phi] = fminsearch(fun2min,X2,ops); % create blue torus
            iter = iter + 1;
        end
%         if phi > e_tol
        Xgn(:,i) = X2;
% iter
% phi
        fun2min2 = @(x) get_phi_cg_best_fit(x,X2,thetapt(i));
        [alpha, phi2] = fminsearch(fun2min2,thetapt(i),ops); % solve for blue torus intersecting with theta plane
         phi2a(i) = phi2;
        cg = get_local_coords_of_cg(alpha, X2);
        [ractuali, thetaactuali] = get_minor_radius_and_theta(apts(i,:),cg);
        ractual(i,1) = ractuali; thetaactual(i,1) = thetaactuali;
        Rc(i,1) = X2(4);
        cgrall(i,:) = cg;
    end
    
    cgall{j} = [cgrall ractual thetaactual Rc aptsnum apts];
    Xg(:,aptsnum) = Xgn;
   
end
max(abs(phi2a))
