function [ D_tor ] = fix_data( D_tor,dif,limit )
% fix_data 
%   Changes D_tor matrix to fix 'bad' points

dif2 = dif(abs(dif) > limit);
while isempty(dif2) == 0
% Translate big jumps
for i = 1:size(dif,2);
    for j = 1:size(dif,1) - 1
        dif1 = abs(dif(j + 1:end - 1,i));
        dif1 = dif1(dif1 > limit);
        if abs(dif(j,i)) > limit && isempty(dif1) == 1
            D_tor(j + 1:end,i) = D_tor(j + 1:end,i) - dif(j,i);
        end
    end
end

% Update diff and dif 2
dif = D_tor(2:end,:) - D_tor(1:end-1,:);
dif2 = dif(abs(dif(1:end -1,:)) > limit);
end
end