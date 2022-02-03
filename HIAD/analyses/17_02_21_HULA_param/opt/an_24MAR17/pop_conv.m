


pop = pop_hist(:,3:end,1:generation);


% for i = 1:size(pop,2)
%     pop(:,i) = pop(:,i)/pop(1,i,end);
% end


figure(100)
clf
box on
hold on

for i = 1:size(pop,2)
    plot(permute(pop(1,i,:),[3 1 2]))
end

