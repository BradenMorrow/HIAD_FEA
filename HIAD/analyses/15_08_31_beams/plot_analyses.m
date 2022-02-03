% Plot analysis results on test results
Di = 128; %FEM.MODEL.Di;
% out = 1;

if plot_ref_i == 1
    figure(11)
    subplot(2,1,1)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 2
    figure(11)
    subplot(2,1,2)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 3
    figure(12)
    subplot(2,1,1)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 4
    figure(12)
    subplot(2,1,2)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 5
    figure(13)
    subplot(2,1,1)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 6
    figure(13)
    subplot(2,1,2)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = out(an).FEM_out.OUT.Finc(6 - 4,:)'*2; % - out(an).FEM_out.OUT.Fext_inc(8,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 7
    figure(14)
    subplot(2,1,1)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 8
    figure(14)
    subplot(2,1,2)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 9
    figure(15)
    subplot(2,1,1)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 10
    figure(15)
    subplot(2,1,2)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 11
    figure(16)
    subplot(2,1,1)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = -out(an).FEM_out.OUT.Finc(Di + 6,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'r-.','linewidth',2.5)
    
elseif plot_ref_i == 12
    figure(16)
    subplot(2,1,2)
%     u = -out(an).FEM_out.OUT.Uinc(end - 4,:)';
%     f = out(an).FEM_out.OUT.Finc(6 - 4,:)'*2; % - out(an).FEM_out.OUT.Fext_inc(8,:)'*2;
%     u(u == 0) = [];
%     f(f == 0) = [];
%     plot([0; u],[0; f],'c-.','linewidth',2.5)
    
end

ind = 4;

u = -out(an).FEM_out.OUT.Uinc(end - ind,:)';
f = out(an).FEM_out.OUT.Finc(6 - ind,:)'*2; % - out(an).FEM_out.OUT.Fext_inc(8,:)'*2;
u(u == 0) = [];
f(f == 0) = [];
plot([0; u],[0; f],'r-.','linewidth',2.5)
