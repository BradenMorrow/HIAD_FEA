function a = load_export_IH(filename)
all_dat = readmatrix(filename);
switch_inds = find(diff(all_dat(:,1)) < 0);
switch_inds = [0;switch_inds;length(all_dat)];
num_stages = length(switch_inds) - 1;
a = cell(num_stages,1);
for i = 1:num_stages
    a{i} = all_dat(switch_inds(i) + 1:switch_inds(i + 1),:);
end