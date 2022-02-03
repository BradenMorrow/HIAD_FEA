% Plot analysis results on test results
Di = FEM.MODEL.Di;
% out = 1;

Di_ind = 1:length(Di);
Di2 = Di_ind(Di == 1);
Di3 = Di2(1);

ind = ceil(size(FEM_out.OUT.Uinc,1)/6/2);

if plot_ref_i == 1
    figure(11)
    subplot(2,1,1)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 2
    figure(11)
    subplot(2,1,2)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 3
    figure(12)
    subplot(2,1,1)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 4
    figure(12)
    subplot(2,1,2)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 5
    figure(13)
    subplot(2,1,1)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 6
    figure(13)
    subplot(2,1,2)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 7
    figure(14)
    subplot(2,1,1)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 8
    figure(14)
    subplot(2,1,2)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 9
    figure(15)
    subplot(2,1,1)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 10
    figure(15)
    subplot(2,1,2)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 11
    figure(16)
    subplot(2,1,1)
    u = -out(an).OUT.Uinc(end - 4,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 12
    figure(16)
    subplot(2,1,2)
    u = -out(an).OUT.Uinc(ind*6 - 4,:)';
    u2 = -out(an).OUT.Uinc(ind*6 - 3,:)';
    f = -out(an).OUT.Finc(Di3,:)'*2;
    u(u == 0) = [];
    u2(u2 == 0) = [];
    f(f == 0) = [];
    plot([0; u],[0; f],'r-.','linewidth',2.5)
    plot([0; -u2],[0; f],'g-.','linewidth',2.5)
end


