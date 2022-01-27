function [x_min,obj_value] = GAmain(max_gen,n_pop,n_genes,ub_1,lb_1,ub_2,lb_2,...
    elite,best,pc,pcg,nc,pm,pmg,nm,d_nich,nf_f,drop,dyn,tolerance,...
    span,objective,constraint,grad_switch,plot_switch,ind_an,RESTART)
% Main genetic algorithm (GA) program
% Andrew Goupee
% Last modified:  4-27-04
% 
% This m-file is the main GA program.  It peforms the actual search and
% optimization using the inputs and outputs shown above.  This program is
% called from the m-file 'GA', in which the values of the inputs are
% established for this program.  For descriptions of these inputs, as well
% as a description of the output, please see m-file 'GA'.
% 
% This GA is a real-coded GA which utilizes tournament selection for a
% reproduction operator, a simulated binary crossover operator (SBX) and a
% parameter based mutation oparator (PBM).  See UMGAtoolbox1.0 User's Guide
% for references on these various genetaic algorithm operators.
% 
% Additional variables used in this program:
% pc_o, pcg_o, nc_o, pm_o, pmg_o, nm_o - same as pc, pcg, nc, pm, pmg and nm
%   at the start of the GA.  These parameters are used in the dynamic 
%   alteration process.
% pc_v, pcg_v, nc_v, pm_v, pmg_v, nm_v - vectors which store the parameters
%   at each generation for plotting purposes.
% generation - generation number.
% population - matrix containing fitness, constraint and chromosome for each
%   member of the population.  Dimensions of n_pop rows x (n_genes + 2) columns.
% elite_no - individual number (corresponds to row in population) of the
%   elite individual of the current population.
% avg_fit_vect - vector containing the average fitness of each generation.
% best_fit_vect - vector containing the fitness of the best individual in
%   each generation.
% diff - difference between best individual in current generation and best
%   individual 'span' generations prior.
% mating_pool - intermediate population
c = clock;
fprintf('%s\n',datestr(datenum(c(1),c(2),c(3),c(4),c(5),c(6))))
    

if ~RESTART.restart % If starting a new optimization analysis
    % Reset random number generator
    % rand('state',sum(100*clock));
    rng(sum(100*clock));
    
    % Time analysis
    Ttot = tic;

    % Store initial parameters used in dynamic alteration process
    pc_o = pc;
    pcg_o = pcg;
    nc_o = nc;
    pm_o = pm;
    pmg_o = pmg;
    nm_o = nm;

    % Initialize parameter vectors used for plotting purposes
    avg_fit_vect = zeros(max_gen,1);
    best_fit_vect = zeros(max_gen,1);

    pc_v = zeros(max_gen,1);
    pcg_v = zeros(max_gen,1);
    nc_v = zeros(max_gen,1);
    pm_v = zeros(max_gen,1);
    pmg_v = zeros(max_gen,1);
    nm_v = zeros(max_gen,1);

    pc_v(1) = pc;
    pcg_v(1) = pcg;
    nc_v(1) = nc;
    pm_v(1) = pm;
    pmg_v(1) = pmg;
    nm_v(1) = nm;
    
    pop_hist = zeros(n_pop,n_genes + 2,max_gen);

    % Initialize generation number, corresponding generation
    generation = 0;
    % fprintf('\ngeneration = %d\n',generation + 1)
    [population] = create_population(n_pop,n_genes,ub_1,lb_1,objective,constraint,ind_an);
    pop_hist(:,:,1) = population;
    
    % Create generation 0 fitness report, begin fitness trend vectors
    [elite_no,avg_fit_vect(1),best_fit_vect(1)] = pop_report(generation,n_pop,...
        population,n_genes);

    % Initialize diff
    diff = 10*tolerance;

    % Begin looping through generations
    generation = 1;
    c = clock;
    fprintf('\n%s\n',datestr(datenum(c(1),c(2),c(3),c(4),c(5),c(6))))
    fprintf('Initialization complete\n')
    fprintf('Generation time = %g seconds\n',toc(Ttot))
    fprintf('Average fitness = %g\n',avg_fit_vect(1))
    fprintf('Fitness = %g\n\n',best_fit_vect(1))
    
else % If restarting an optimization analysis
    % Load optimization variables
    load(RESTART.ga_info)
    
    % Time analysis from restart
    Ttot = tic;
end

while diff > tolerance && generation <= max_gen - 1
    % Time generation
    Tgen = tic;
    
    % Create mating pool via tournament selection with niching
    [mating_pool] = reproduction(population,n_pop,elite,elite_no,n_genes,...
        d_nich,nf_f,ub_2,lb_2);
    
    % Perform crossover with SBX and mutation with PBM operators
    [population] = SBX_PBM(mating_pool,pc,pcg,nc,pm,pmg,nm,ub_2,lb_2,...
        objective,constraint,elite,best,n_pop,n_genes,ind_an);
    
    % Create current generation fitness report, determine elite no, etc.
    [elite_no,avg_fit_vect(generation + 1),best_fit_vect(generation + 1)] = ...
        pop_report(generation,n_pop,population,n_genes);
    
    % Update GA parameters, plotting storage vectors
    pc = pc_o*(1 - drop*(1 - exp(-dyn*generation)));
    pcg = pcg_o*(1 - drop*(1 - exp(-dyn*generation)));
    nc = nc_o*(1 + drop*(1 - exp(-dyn*generation)));
    pm = pm_o*(1 - drop*(1 - exp(-dyn*generation)));
    pmg = pmg_o*(1 - drop*(1 - exp(-dyn*generation)));
    nm = nm_o*(1 + drop*(1 - exp(-dyn*generation)));
    
    pc_v(generation + 1) = pc;
    pcg_v(generation + 1) = pcg;
    nc_v(generation + 1) = nc;
    pm_v(generation + 1) = pm;
    pmg_v(generation + 1) = pmg;
    nm_v(generation + 1) = nm;
    
    % Calculate new diff
    if generation >= span && population(elite_no,2) <= 0
        diff = abs(best_fit_vect(generation+1)-...
            best_fit_vect(generation-span+1));
    end
    
    % Count up generation
    generation = generation + 1;
    
    % Save GA information
    pop_hist(:,:,generation) = population;
    save ga_info;
    
    % Plot best fit vector
    figure(10)
    clf
    hold on
    box on
    % leg(1) = plot(avg_fit_vect(avg_fit_vect ~= 0));
    plot(best_fit_vect(best_fit_vect ~= 0),'r');
    xlabel('Generation No.')
    ylabel('Fitness')
    title('Fitness Trends')
    % legend(leg, 'Population Average', 'Best Individual')
    drawnow
    
    % Print generation and time
    % fprintf('\nGeneration %g complete\nGeneration time = %g seconds\nFitness = %g\n\n',generation,toc(Tgen),best_fit_vect(generation))
    
    c = clock;
    fprintf('\n%s\n',datestr(datenum(c(1),c(2),c(3),c(4),c(5),c(6))))
    fprintf('Generation %g complete\n',generation)
    fprintf('Generation time = %g seconds\n',toc(Tgen))
    fprintf('Average fitness = %g\n',avg_fit_vect(generation))
    fprintf('Fitness = %g\n\n',best_fit_vect(generation))
    
% % %     %% MOVIE
% % %     fps = 3;
% % %     fig = 5;
% % %     figure(fig)
% % % %     M(generation - 1) = getframe(fig);
% % %     
% % %     
% % %     
% % %     
% % %     subplot(1,2,1)
% % %     hold on
% % %     plot3(population(:,3),population(:,4),population(:,1),'kx','markersize',5,'linewidth',2)
% % %     subplot(1,2,2)
% % %     hold on
% % %     plot(population(:,3),population(:,4),'kx')
end

best_fit_vect(best_fit_vect == 0) = [];
avg_fit_vect(avg_fit_vect == 0) = [];
pop_hist(:,:,sum(pop_hist(:,1)) == 0) = [];

% Print total time
fprintf('\nAnalysis time = %g seconds\n\n',toc(Ttot))


% Go to gradient based search if desired
if grad_switch == 1
    
    % Establish initial guess
    xo = population(elite_no,3:(n_genes+2));

    % Declare options
    options=optimset('Display','iter','MaxFunEvals',10000);

    % Call fmincon and perform optimization
    [x,fval,~] = fmincon(objective,xo,[],[],[],[],lb_2,ub_2,...
        constraint,options);
    
    % Evaluate x_min, obj_value
    x_min = x;
    obj_value = fval;
else
    % Evaluate x_min, obj_value
    x_min = population(elite_no,3:(n_genes+2));
    obj_value = population(elite_no,1);
end


% Plot objective function trends if required, parameter trends
if plot_switch == 1
    figure(1)
    clf
    hold on
    box on
%     leg(1) = plot(avg_fit_vect);
    leg(2) = plot(best_fit_vect(best_fit_vect ~= 0),'r');
    xlabel('Generation No.')
    ylabel('Fitness')
    title('Fitness Trends')
%     legend(leg, 'Population Average', 'Best Individual')
    
%     figure(2);
%     clf;
%     hold on;
%     box on;
%     leg1(1) = plot(pc_v);
%     leg1(2) = plot(pcg_v,'r');
%     leg1(3) = plot(pm_v,'g');
%     leg1(4) = plot(pmg_v,'k');
%     axis([1,generation+1,0,1]);
%     xlabel('Generation No.');
%     ylabel('Probability Value');
%     title('Crossover and Mutation Probability Trends');
%     legend(leg1, 'pc', 'pcg', 'pm', 'pmg');
    
%     figure(3);
%     clf;
%     hold on;
%     box on;
%     leg2(1) = plot(nc_v);
%     leg2(2) = plot(nm_v,'r');
%     xlabel('Generation No.');
%     ylabel('Parameter Value');
%     title('Crossover and Mutation Strength Parameter Trends');
%     legend(leg2, 'nc', 'nm');   
end

% % % fid = 'GA_demo0';
% % % movie2avi(M,fid,'compression','none','fps',fps);

