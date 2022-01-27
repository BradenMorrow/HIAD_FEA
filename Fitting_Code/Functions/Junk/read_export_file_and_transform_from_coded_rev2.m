function torus_pts = read_export_file_and_transform_from_coded_rev2(ppath,ptol,ctol,ops,rt,zt)

% a = load_export(ppath,4);
a = load_export([ppath,'\Export.txt'],4);
% if ~exist([ppath,'\\Binary'],'dir')
%     mkdir([ppath,'\\Binary']);
% end
% nums = zeros(429,1);
% for j = 1 : length(a)
%     if a(j,1) < 429
%     nums(a(j,1)+1,1) = nums(a(j,1)+1,1)+1;
%     end
% end
% plot(nums)
i0 = find(a(:,1) == 0);
i1 = find(a(:,1) == 1);
i2 = find(a(:,1) == 2);
% noise0 = hypot(a(i0,2),a(i0,3));
% noise0 = 1/25.4*(noise0-noise0(1));
% hold on; box on;
% plot(noise0)
[~,F] = mode(a(:,1));
lasts = [find(a(2:end,1)-a(1:end-1,1)<0);size(a,1)];
data_s = cell(length(lasts),1);
for i = 1 : length(lasts)
    if i == 1
        datas = a(1:lasts(1),:);
    else
        datas = a(lasts(i-1)+1:lasts(i),:);
    end
    
    if ~ismember(0,datas(:,1))
        datas = recover_missing_coded_points(datas,a,F,'i0',i0,ptol,ctol,ops);
    end
    if ~ismember(1,datas(:,1))
        datas = recover_missing_coded_points(datas,a,F,'i1',i1,ptol,ctol,ops);
    end
    if ~ismember(2,datas(:,1))
        try
            datas = recover_missing_coded_points(datas,a,F,'i2',i2,ptol,ctol,ops);
        catch
            asd = e2;
        end
    end
    
    %% Perform Transformation
    if datas(1,1) == 0 && datas(2,1) == 1 && datas(3,1) == 2
        dsx = datas(1,2); dsy = datas(1,3); dsz = datas(1,4); % rigid body correction
        %         dsx = a(1,2); dsy = a(1,3); dsz = a(1,4); % zero to first stage
        %         only
    else
        CRASH
    end
     if datas(4,1) == 4 %% remove coded point 4 since not directly on torus
         datas = datas([1:3,5:end],:);
     end
    
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
    
    % 206 mm = vertical distance top of fixture to middle of torus cross-section
    datas(:,4) = datas(:,4) + 206;
    data_s{i}(:,:) = datas;
    %     data_s1{i}(:,:) = datas;
    %     if i == 1
    %         if ~exist([ppath,sprintf('\\Binary\\stage%g.raw',i)],'file');
    yeswrite = 1;
    %         else
    %             yeswrite = 0;
    %         end
    %     end
    %     if yeswrite
    %         try
    %             fid = -1; tries = 1;
    %             while fid < 0 && tries < 100
    %         fid=fopen([ppath,sprintf('\\Binary\\s%g.raw',i)],'w');
    %         tries = tries + 1;
    %             end
    %         fwrite(fid,datas(:,:),'double');
    %         fclose(fid);
    %         catch
    %             fclose(fid);
    %         end
    %     end
end
if strfind(ppath,'T3AP-5')
    disp('Function T3AP-5')
    torus_pts = get_valids_T3AP_5_Dan_Method(data_s,rt,zt);
elseif strfind(ppath,'T3A-2')
    torus_pts = get_valids_T3A_2_Dan_Method(data_s,rt,zt);
elseif strfind(ppath,'T3AP-1-4Cord')
    torus_pts = get_valids_T3A_2_Dan_Method(data_s,rt,zt);
elseif strfind(ppath,'T3AP-2-L')
    torus_pts = get_valids_T3AP_2_L_Dan_Method(data_s,rt,zt);
elseif strfind(ppath,'T3AP-3')
    if strfind(ppath,'2016-04')
        torus_pts = get_valids_T3AP_3_Dan_Method_April(data_s,rt,zt);
    elseif strfind(ppath,'f-Plane')
        torus_pts =get_valids_T3AP_3_Dan_Method_Out_of_plane(data_s,rt,zt);
    else
        %         torus_pts = get_valids_T3AP_3_Dan_Method(data_s,rt,zt);
        torus_pts = get_valids_T3AP_3_from_stage1_1501(data_s,rt,zt);
    end
elseif strfind(ppath,'T4AP-1')
    torus_pts = get_valids_T4AP_1(data_s,rt,zt);
elseif strfind(ppath,'T4A-1')
    torus_pts = determine_torus_points_in_volumetric_window(data_s, rt, zt);
else
    crash_and_burn_need_new_valids
end
clear a;
save([ppath,'\torus_pts_IH_test.mat'],'torus_pts');
save([ppath,'\data_s_IH_test.mat'],'data_s');
% save([ppath,'\data_s1.mat'],'data_s1');