function [torus_pts,bad_points,strap_data,trans_pts,bp2] = pre_proc_pts(ppath,tor_num,save_var)

% Get export file
txt_dir = dir([ppath,'\**\*.txt']);

if length(txt_dir) == 1
    exp_file = [txt_dir.folder,'\' txt_dir.name];
else
    txt_list = strcat({txt_dir.folder}',repmat({'\'},length(txt_dir),1),{txt_dir.name}');
    ef_ind = listdlg('PromptString','Choose export file','SelectionMode','single','ListSize',[500,200],'ListString',txt_list);
    exp_file = txt_list{ef_ind};
end

% Get data from text file
a = load_export_IH(exp_file);

% Get strap points
strap_pts = get_strap_pts(tor_num);
strap_pts_all = strap_pts;

% Initialize
data_s = cell(size(a));
torus_pts = data_s;
trans_pts = data_s;
bad_points = zeros(0,5);
strap_data = repmat({zeros(16,4)},length(a),1);


old_disp = [];

% Loop thru each stage
for i = 1 : length(a)
    
    % Get current points and remove noncoded
    datas = a{i};
    datas(datas(:,1) > 1000,:) = [];
    
    % Get points used for transformation
    [trans_pts_ind,trans_loc] = ismember([0:4],datas(:,1));
    trans_pts{i} = datas(trans_pts_ind,1:4);
    
    % Get translations (transformation of all stages based off of first
    % stage)
    if i == 1
        dsx = datas(1,2); dsy = datas(1,3); dsz = datas(1,4);
    end
    
    % Apply translations to current stage
    datas(:,2) = datas(:,2) - dsx;
    datas(:,3) = datas(:,3) - dsy;
    datas(:,4) = datas(:,4) - dsz;
    
    % Get rotation angle
    if i == 1
        thetaxy = atan2(datas(2,3),datas(2,2));
    end
    
    % Apply rotation
    Ri = sqrt(datas(:,2).^2+datas(:,3).^2);
    thetai = atan2(datas(:,3),datas(:,2));
    thetain = thetai - thetaxy;
    datas(:,2) = Ri.*cos(thetain);
    datas(:,3) = Ri.*sin(thetain);
    
    % Get rotation angle
    if i == 1
        thetazx = atan2(datas(2,4),datas(2,2));
    end
    
    % Apply rotation
    Ri = sqrt(datas(:,2).^2+datas(:,4).^2);
    thetai = atan2(datas(:,4),datas(:,2));
    thetain = thetai - thetazx;
    datas(:,2) = Ri.*cos(thetain);
    datas(:,4) = Ri.*sin(thetain);
    
    % Get rotation angle
    if i == 1
        thetazy = atan2(datas(3,4),datas(3,3));
    end
    
    % Apply rotation
    Ri = sqrt(datas(:,3).^2+datas(:,4).^2);
    thetai = atan2(datas(:,4),datas(:,3));
    thetain = thetai - thetazy;
    datas(:,3) = Ri.*cos(thetain);
    datas(:,4) = Ri.*sin(thetain);
    
    % Get locations of strap points
    [la,lb] = ismember(strap_pts,datas(:,1));
    
    % Find angle of strap 4
    if i == 1
        
        d4 = lb(4);
        %         if ~d4
        %
        %                 d4 = lb(16);
        %         end
        
        rot_ang = cart2pol(datas(d4,2),datas(d4,3));
    end
    
    % Rotate so strap 4 aligns with +x
    Ri = sqrt(datas(:,2).^2+datas(:,3).^2); % distance to points in x-y
    thetai = atan2(datas(:,3),datas(:,2)); % angle from x-y plane to point about x-axis
    thetain = thetai - rot_ang; % new angle from x-y plane to point about x-axis
    datas(:,2) = Ri.*cos(thetain); % new x-coordinate
    datas(:,3) = Ri.*sin(thetain); % new y-coordinate
    
    % Save translated data
    data_s{i} = datas;
    
    % Convert from mm to in
    datas(:,2:4) = datas(:,2:4)./25.4;
    
    % Save strap dot data in separate variable
    nc = size(datas,2);
    strap_data{i}(la,1:nc) = datas(lb(~~lb),:);
    strap_data{i}(la,nc + 1) = sqrt(strap_data{i}(la,2).^2 + strap_data{i}(la,3).^2);
    strap_data{i}(la,nc + 2) = cart2pol(strap_data{i}(la,2),strap_data{i}(la,3));
    
    % Remove strap dots from main variable
    strap_inds = ismember(datas(:,1),strap_pts_all);
    datas(strap_inds,:) = [];
    datas(trans_loc(~~trans_loc),:) = [];
    
    % Find outliers in r and z
    r = sqrt(datas(:,2).^2 + datas(:,3).^2);
    r_out = isoutlier(r,'quartiles');
    z_out = isoutlier(datas(:,4),'quartiles');
    
    out_ind = r_out + z_out;
    
    % Check for outliers in displacements from first stage (disp_out_full)
    % and previous stage (jc)
%     if i > 1
%         
%         [old_ind,cur_ind] = ismember(torus_pts{i - 1}(:,1),datas(:,1));
%         if i > 2
%             old_disp = old_disp(old_ind);
%         end
%         cur_disp = sqrt(sum((datas(cur_ind(cur_ind ~= 0),2:4) - torus_pts{i - 1}(old_ind,2:4)).^2,2));
%         disp_out = isoutlier(cur_disp,'quartiles') + abs(cur_disp) > 25.4/4;
%         disp_out_full = zeros(size(out_ind));
%         disp_out_full(cur_ind(cur_ind ~= 0)) = disp_out;
%         disp_full = disp_out_full;
%         disp_full(cur_ind(cur_ind ~= 0)) = cur_disp;
%         do_ch{i} = find(disp_out_full);
%         if i > 2
%             jump_ch = isoutlier(old_disp - cur_disp,'quartiles');
%             jc = zeros(size(out_ind));
%             jc(cur_ind(cur_ind ~= 0)) = jump_ch & ~isnan(old_disp - cur_disp);
%             jc_ch{i} = find(jc);
%             
%         else
%             jc = zeros(size(out_ind));
%         end
%         out_ind = out_ind + disp_out_full + jc;
%         old_disp = disp_full;
%         old_disp(~old_disp) = nan;
%     end
    
    % Fit points to surface and remove those whose residuals are outliers
%     [~,~,sf_output] = fit(datas(~out_ind,2:3),datas(~out_ind,4),'loess');
%     f_out = isoutlier(sf_output.residuals,'quartiles');
%     out_ind(~out_ind) =  f_out;
    
    % Save removed points in separate variable
    if sum(out_ind)
        cur_bp = datas(~~out_ind,:);
        bad_points = [bad_points;[ones(size(cur_bp,1),1).*i,cur_bp]];
    end
    
    % Save good points
    torus_pts{i}= [datas(~out_ind,1),datas(~out_ind,2:4)];
    
end


[r,th,z,pt_nums] = proc_torus_pts(torus_pts);

many_nans = sum(isnan(r)) > .5*size(r,1);

bad_ids = pt_nums(many_nans);

png = pt_nums(~many_nans);
r1 = r(:,~many_nans);
th1 = th(:,~many_nans);
z1 = z(:,~many_nans);
% f1 = figure('Visible','off');
% hold on
% f2 = figure('Visible','off');
% hold on
% f3 = figure('Visible','off');
% hold on
sz = [size(r1),3];

jc = nan(sz);
dc = nan(sz);
for i = 1:length(png)
    gp(:,i) = ~isnan(r1(:,i));
    gpc = gp(:,i);
    fgp = find(gpc);
    pc = [r1(gpc,i),th1(gpc,i),z1(gpc,i)];
    jc(fgp(2:end),i,:) = reshape(diff(pc),[],1,3);
    dc(gpc,i,:) = reshape(pc - pc(1,:),[],1,3);
%     figure(f1);
%     plot(find(gpc),dc{i}(:,1))
%     figure(f2);
%     plot(find(gpc),dc{i}(:,2))
%     figure(f3);
%     plot(find(gpc),dc{i}(:,3))
end
% figure
% plot(dc(:,:,1))
% figure
% plot(dc(:,:,2))
% figure
% plot(dc(:,:,3))

out = sum(isoutlier(dc,'quartiles',2),3);
out1 = sum(isoutlier(jc,'quartiles',2),3);
full_out = (out1 | out) & ~isnan(dc(:,:,1));
for i = 1:3
    dc_temp = dc(:,:,i);
dc_temp(full_out) = nan;
dc(:,:,i) = dc_temp;
end

many_nans2 = isoutlier(sum(isnan(dc(:,:,1))),'quartiles');

bad_ids = [bad_ids;png(many_nans2)];

png1 = png(~many_nans2);
dc1 = dc(:,~many_nans2,1);
for i = 1:size(dc1,1)
    cn = isnan(dc1(i,:));
    bp2{i} = sort([png1(cn);bad_ids]);
    bad_ind = ismember(torus_pts{i}(:,1),bp2{i});
    torus_pts{i}(bad_ind,:) = [];
end

% figure
% dc1 = dc(:,:,1);
% dc1(out) = nan;
% plot(dc1)
%   f1.Visible = 'on';
%   f2.Visible = 'on';
%   f3.Visible = 'on';
% Save results if requested
if nargin < 3 || save_var
    save([ppath,'\torus_pts_strict.mat'],'torus_pts');
    save([ppath,'\data_s_test.mat'],'data_s');
    save([ppath,'\strap_data.mat'],'strap_data');
end
