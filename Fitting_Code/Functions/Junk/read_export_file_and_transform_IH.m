function [torus_pts,bad_points,strap_data,trans_pts] = read_export_file_and_transform_IH(ppath,tor_num,save_var)

txt_dir = dir([ppath,'\**\*.txt']);

if length(txt_dir) == 1
    exp_file = [txt_dir.folder,'\' txt_dir.name];
else
    txt_list = strcat({txt_dir.folder}',repmat({'\'},length(txt_dir),1),{txt_dir.name}');
    ef_ind = listdlg('PromptString','Choose export file','SelectionMode','single','ListSize',[500,200],'ListString',txt_list);
    exp_file = txt_list{ef_ind};
end

a = load_export_IH(exp_file);
strap_pts = get_strap_pts(tor_num);
strap_pts_all = strap_pts;
data_s = cell(size(a));
torus_pts = data_s;
trans_pts = data_s;
bad_points = zeros(0,5);
strap_data = repmat({zeros(16,4)},length(a),1);
for i = 1 : length(a)
% Get current points and remove noncoded
    datas = a{i};
    datas(datas(:,1) > 1000,:) = [];
    % Perform Transformation
    [trans_pts_ind,trans_loc] = ismember([0:4],datas(:,1));
    trans_pts{i} = datas(trans_pts_ind,1:4);
    if sum(trans_pts_ind) > 2 && datas(1,1) == 0
        dsx = datas(1,2); dsy = datas(1,3); dsz = datas(1,4); % rigid body correction
        %         dsx = a(1,2); dsy = a(1,3); dsz = a(1,4); % zero to first stage
        %         only
    else
        CRASH
    end
%      if datas(4,1) == 4 %% remove coded point 4 since not directly on torus
%          datas = datas([1:3,5:end],:);
%      end
    
    % translations
    datas(:,2) = datas(:,2) - dsx;
    datas(:,3) = datas(:,3) - dsy;
    datas(:,4) = datas(:,4) - dsz;
    
    % rotations
    thetaxy = atan2(datas(2,3),datas(2,2)); % angle to pt1 in x-y
    % align x-axis with coded point 1
    Ri = sqrt(datas(:,2).^2+datas(:,3).^2); % distance to points in x-y
    thetai = atan2(datas(:,3),datas(:,2)); % angle from x-y plane to point about x-axis
    thetain = thetai - thetaxy; % new angle from x-y plane to point about x-axis
    datas(:,2) = Ri.*cos(thetain); % new y-coordinate
    datas(:,3) = Ri.*sin(thetain); % new z-coordinate
    
    thetazx = atan2(datas(2,4),datas(2,2)); % angle to pt1 in x-y
    Ri = sqrt(datas(:,2).^2+datas(:,4).^2); % distance to points in x-y
    thetai = atan2(datas(:,4),datas(:,2)); % angle from x-y plane to point about x-axis
    thetain = thetai - thetazx; % new angle from x-y plane to point about x-axis
    datas(:,2) = Ri.*cos(thetain); % new y-coordinate
    datas(:,4) = Ri.*sin(thetain); % new z-coordinate
    
    thetazy = atan2(datas(3,4),datas(3,3)); % angle to pt1 in x-y
    Ri = sqrt(datas(:,3).^2+datas(:,4).^2); % distance to points in x-y
    thetai = atan2(datas(:,4),datas(:,3)); % angle from x-y plane to point about x-axis
    thetain = thetai - thetazy; % new angle from x-y plane to point about x-axis
    datas(:,3) = Ri.*cos(thetain); % new y-coordinate
    datas(:,4) = Ri.*sin(thetain); % new z-coordinate
    
    
    
    
    [la,lb] = ismember(strap_pts,datas(:,1));
    
    % Find angle of strap 4
    if i == 1
        d4 = lb(4);
        rot_ang = cart2pol(datas(d4,2),datas(d4,3));
    end
    
    % Rotate so strap 4 aligns with +x
    Ri = sqrt(datas(:,2).^2+datas(:,3).^2); % distance to points in x-y
    thetai = atan2(datas(:,3),datas(:,2)); % angle from x-y plane to point about x-axis
    thetain = thetai - rot_ang; % new angle from x-y plane to point about x-axis
    datas(:,2) = Ri.*cos(thetain); % new x-coordinate
    datas(:,3) = Ri.*sin(thetain); % new y-coordinate
    
    data_s{i} = datas;
%     trans_pts = datas(trans_loc,:);
    
    datas(:,2:4) = datas(:,2:4)./25.4;
    
    nc = size(datas,2);
    strap_data{i}(la,1:nc) = datas(lb(~~lb),:);
    strap_data{i}(la,nc + 1) = sqrt(strap_data{i}(la,2).^2 + strap_data{i}(la,3).^2);
    strap_data{i}(la,nc + 2) = cart2pol(strap_data{i}(la,2),strap_data{i}(la,3));

    strap_inds = ismember(datas(:,1),strap_pts_all);
    datas(strap_inds,:) = [];
    datas(trans_loc(~~trans_loc),:) = [];
    
    r = sqrt(datas(:,2).^2 + datas(:,3).^2);
    r_out = isoutlier(r);
    z_out = isoutlier(datas(:,4));
    
   
    
    
    out_ind = r_out + z_out;
   
    
    if i > 1
        [old_ind,cur_ind] = ismember(torus_pts{i - 1}(:,1),datas(:,1));
        cur_disp = sqrt(sum((datas(cur_ind(cur_ind ~= 0),2:4) - torus_pts{i - 1}(old_ind,2:4)).^2,2));
        disp_out = isoutlier(cur_disp) + abs(cur_disp) > 25.4/4;
        disp_out_full = zeros(size(out_ind));
        disp_out_full(cur_ind(cur_ind ~= 0)) = disp_out;
        out_ind = out_ind + disp_out_full;
    end
    
    [~,~,sf_output] = fit(datas(~out_ind,2:3),datas(~out_ind,4),'loess');
    
    f_out = isoutlier(sf_output.residuals);
    out_ind(~out_ind) =  f_out;
    
if sum(out_ind)
    cur_bp = datas(~~out_ind,:); 
%     figure
%     clf
%     hold on
%     plot3(datas(~out_ind,2),datas(~out_ind,3),datas(~out_ind,4),'k.')
%     plot3(datas(~~out_ind,2),datas(~~out_ind,3),datas(~~out_ind,4),'r.')
% %     axis equal
%     view(30,30)
%     pause
    bad_points = [bad_points;[ones(size(cur_bp,1),1).*i,cur_bp]];
end
    torus_pts{i}= [datas(~out_ind,1),datas(~out_ind,2:4)];

end

%pause
if nargin < 3 || save_var 
 save([ppath,'\torus_pts_test.mat'],'torus_pts');
save([ppath,'\data_s_test.mat'],'data_s');
end
% save([ppath,'\data_s1.mat'],'data_s1');