function [cgall] = SOLVE_POOL_OF_STAGES_IH(num_stages, r, Xguess, ops, ctol, ...
    num_pts, torus_pts)
% R_range = 2;
% trans_range = inf;
% z_range = [-inf,inf];
% torus_pts = load([ppath,'\torus_pts.mat']);
% torus_pts = torus_pts.torus_pts;
cgall = cell(num_stages,1);
% cgall{1} = lastpts;

%nstages = jobs(end) - jobs(1);
%Xguess2 = [0.1; 0.1; 1; 55; 0.01; 0.01];% x, y, z [shifts], R, thetaX, thetaY
% pts95 = zeros(num_pts,3,num_stages);
Xg = zeros(6,430);
%Xg1 = Xg;
for j = 1:num_stages%par
    tp = torus_pts{j};
    aptsnum = tp(:,1); 
    x0 = tp(:,2); 
    y0 = tp(:,3); 
    z0 = tp(:,4);
    [thetapt, ind] = atan2pos(tp(:,2:4)); 
    x0 = x0(ind); 
    y0 = y0(ind); 
    z0 = z0(ind);
    aptsnum = aptsnum(ind); 
    apts = tp(ind,2:4); 
    n = (num_pts-1)/2;
    pts_wextra = get_indices_IH(x0,y0,z0,n); 
    
    ractual = zeros(size(x0,1),1);
    thetaactual = zeros(size(x0,1),1);
    cgrall = zeros(size(x0,1),3);
    Rc = zeros(size(x0,1),1);
   Xgc = Xg(:,aptsnum);
   Xgc(:,~sum(Xgc)) = repmat(Xguess,1,sum(~sum(Xgc)));
   %Xgc1 = Xg1(:,aptsnum);
   %Xgc1(:,~sum(Xgc1)) = repmat(Xguess,1,sum(~sum(Xgc1)));
   Xgn = zeros(6,length(x0));
   %Xgn1 = Xgn;
%    ind329 = find(aptsnum == 329);
   %cg2 = cgrall;
    parfor i = 1 : size(x0,1)
        ptsi = pts_wextra(i:i+2*n,:);

        fun2min = @(x) get_phi_best_fit_torus_point_cloud(x,ptsi,r);

        [X2,phi] = fminsearch(fun2min,Xgc(:,i),ops); % create blue torus
        %[X1,phi1] = fmincon(fun2min,Xgc1(:,i),[],[],[],[],[-trans_range,-trans_range,z_range(1),Xgc1(4,i) - R_range,-inf,-inf],[trans_range,trans_range,z_range(2),Xgc1(4,i) + R_range,inf,inf],[],ops);
        philast = 10^6; iter = 1;
       % philast1 = 10^6;
        while (philast - phi > ctol ) && iter < 1000 % || philast1 - phi1 > ctol
            philast = phi;
            [X2,phi] = fminsearch(fun2min,X2,ops); % create blue torus
            %philast1 = phi1;
            %[X1,phi1] = fmincon(fun2min,X1,[],[],[],[],[-trans_range,-trans_range,z_range(1),X1(4) - R_range,-inf,-inf],[trans_range,trans_range,z_range(2),X1(4) + R_range,inf,inf],[],ops);
            iter = iter + 1;
        end
%         if phi > e_tol
        Xgn(:,i) = X2;
        %Xgn1(:,i) = X1; 
% iter
% phi
        fun2min2 = @(x) get_phi_cg_best_fit(x,X2,thetapt(i));
        [alpha, phi2] = fminsearch(fun2min2,thetapt(i),ops); % solve for blue torus intersecting with theta plane
%          phi2a(i) = phi2;
         
         
        cg = get_local_coords_of_cg(alpha, X2);
        
        %pt = apts(i,:)';
        %A = trans_mat(X1(5),X1(6));
        %ptp = A*pt + X1(1:3);
        %thp = atan2(ptp(2),ptp(1));
        %cgp = X1(4).*[cos(thp),sin(thp),0]';
        %cg2(i,:) = [A\(cgp - X1(1:3))]';
        
        [ractuali, thetaactuali] = get_minor_radius_and_theta(apts(i,:),cg);
        ractual(i,1) = ractuali; thetaactual(i,1) = thetaactuali;
        Rc(i,1) = X2(4);
        cgrall(i,:) = cg;
%         phi_all(i,:) = [phi,phi1];
    end
%     figure
%     plot3(cgrall(:,1),cgrall(:,2),cgrall(:,3),'.')
% hold on
% plot3(cg2(:,1),cg2(:,2),cg2(:,3),'.')
    cgall{j} = [cgrall ractual thetaactual Rc aptsnum apts];
    Xg(:,aptsnum) = Xgn;
    %Xg1(:,aptsnum) = Xgn1;
%    max(abs(phi2a))
end



