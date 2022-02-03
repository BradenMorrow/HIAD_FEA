% Script to load test data for model preprocessing
% July 14, 2016

% Variables
torus_id = [1001,1016,1038,1062,1207,1336,1341,1346,1351,1434]; % Test number
p_r = .1; % Percent data removed from the end
fignum = 1:10;
alias1 = 20; % Number of points used
smooth_n = 5; % Used in smooth
fignum2 = 2;
lim = .7; % Limit of lines

% Loop through test data sets
for i = 1:10;
    % Load data
    load(sprintf('torus_%g',torus_id(i)))
    
    % Change p_r if needed
    if i == 1
        p_r = .25;
    elseif i == 5
        p_r = .3;
    end
    
    % Run function
    [d] = get_disp(cg_test,U);
    [pp] = cable_stiff_13JUL16(d,P,p_r,alias1,smooth_n,lim,fignum(i));
    
    % Create structure
    eval(sprintf('test_out.tor_%g.cg = cg;',torus_id(i)))
    eval(sprintf('test_out.tor_%g.cg_test = cg_test;',torus_id(i)))
    eval(sprintf('test_out.tor_%g.pp = pp;',torus_id(i)))
    eval(sprintf('test_out.tor_%g.U = U;',torus_id(i)))
    eval(sprintf('test_out.tor_%g.P = P;',torus_id(i)))
end

% Save output
save('.\analyses\16_07_13_tori_param\lookup\test_post','test_out')