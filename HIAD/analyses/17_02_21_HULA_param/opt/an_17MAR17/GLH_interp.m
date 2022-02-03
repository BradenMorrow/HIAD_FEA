function [GLH] = GLH_interp(p0,beta0)

p = [.5 5 10 15 20]; % Rows
beta = [55 60 65 71]; % Columns

GLH_table = [2006       1154.9       1063.4       728.41
    14564       6101.9       4039.3         2491
    20284       8571.4       6602.4       3554.4
    22220        10359       8435.1       4668.4
    23387        12102       9615.3       5200.1]';

GLH = interp2(p,beta,GLH_table,p0,beta0)

end

