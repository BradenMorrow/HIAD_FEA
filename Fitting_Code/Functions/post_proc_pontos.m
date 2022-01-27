function [r,theta,r_def,r_plot,dn,all_pts] = post_proc_pontos(cgall,vid_fold,vid_inp)
tic
do_video = vid_inp.do_video;
vid_fr = vid_inp.vid_fr;
plot_rad = vid_inp.plot_rad;
plot_int = vid_inp.plot_int;

    


    

cgl = length(cgall);
theta = cell(cgl,1);
r = theta;

all_pts = [];
for i = 1:cgl
    all_pts = [all_pts;cgall{i}(:,7)];
end
all_pts = unique(all_pts);
r0 = zeros(length(all_pts),1);
r_plot = nan(cgl,length(all_pts));

rd_min = 1000;
for i = 1:cgl
    
    
    cur_dat = cgall{i};
    

    
    [theta{i},r{i}] = cart2pol(cur_dat(:,1),cur_dat(:,2)); %(cur_dat(:,1) - X2(1),cur_dat(:,2) - X2(2));
    
    dot_num = cgall{i}(:,7);
    [la,lb] = ismember(all_pts,dot_num);
    lb_nz = lb(lb ~= 0);
    if i < 10
        
        new0 = zeros(size(dot_num));
        ind0 = find(r0(la) == 0);
        new0(ind0) = r{i}(lb_nz(ind0));
        r0(la) = r0(la) + new0;
    end
    
    cur_r0 = r0(la);
    cr0_nz = ~~cur_r0;
    
    
    r_def{i} = [dot_num(lb_nz(cr0_nz)),cur_r0(cr0_nz) - r{i}(lb_nz(cr0_nz)),theta{i}(lb_nz(cr0_nz))];
    
    rm = min(r_def{i}(:,2),[],'all');
    rd_min = min(rm,rd_min);
    
    r0_ind = find(la);
    r_plot(i,r0_ind(cr0_nz)) = r_def{i}(:,2)';

    dn{i} = dot_num;
end
x_plot = 1:cgl;
figure
clf
hold on
plot(x_plot,r_plot)

if do_video
    if nargin == 1
        vid_fold = fileparts(mfilename('fullpath'));
    end
    cur_date = datestr(datetime('today'),'yyyy_mm_dd');
    d = dir([vid_fold,'\plot_vid_', cur_date, '*.avi']);
    [~,filenames] = cellfun(@fileparts,{d.name},'UniformOutput',false);
    new_filename =   matlab.lang.makeUniqueStrings(['plot_vid_', cur_date],filenames);
    
    
    vid_loc = [vid_fold,'\' new_filename, '.avi'];
    vid_obj = VideoWriter(vid_loc);
    
    vid_obj.FrameRate = vid_fr;
    vid_obj.Quality = 100;
    open(vid_obj)
plot_stage_ind = 1:plot_int:min(cgl,plot_int*floor(cgl/plot_int) + 1);
rdp = r_def(plot_stage_ind);
    parfor i = 1:length(plot_stage_ind)
        
        f = figure('Visible','off');
        polarplot(rdp{i}(:,3),-rdp{i}(:,2) + plot_rad,'.')
        f.Children.RLim = [0,round(-rd_min + plot_rad + .1,1)];
        f.Children.GridAlpha = .5;
%         f.WindowState = 'maximized';
        vid_frames(i) = getframe(f);
        delete(f)
    end
    writeVideo(vid_obj,vid_frames)
    close(vid_obj)
    
    
end
toc
end

function err = fit_circ(X,x,y)
r_act = sqrt((x-X(1)).^2 + (y - X(2)).^2);
err = norm(r_act - X(3));
end



