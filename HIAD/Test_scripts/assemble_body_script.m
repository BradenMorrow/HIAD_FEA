% ASSEMBLE_BODY_SCRIPT   Generate MEX-function assemble_body_mex from
%  assemble_body.
% 
% Script generated from project 'assemble_body.prj' on 20-Jul-2016.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.config('mex');
cfg.GenerateReport = true;
cfg.SaturateOnIntegerOverflow = false;
cfg.IntegrityChecks = false;
cfg.ResponsivenessChecks = false;
cfg.ExtrinsicCalls = false;
cfg.GlobalDataSyncMethod = 'SyncAtEntryAndExits';

%% Define argument types for entry-point 'assemble_body'.
ARGS = cell(1,1);
ARGS{1} = cell(3,1);
ARGS{1}{1} = coder.typeof(0,[1 2]);
ARGS{1}{2} = struct;
ARGS{1}{2}.el = coder.typeof('X',[1 20],[0 1]);
ARGS{1}{2}.el_in = struct;
ARGS{1}{2}.el_in.nodes_ij = coder.typeof(0,[2 3]);
ARGS{1}{2}.el_in.orient_ij = coder.typeof(0,[1 3]);
ARGS{1}{2}.el_in = coder.typeof(ARGS{1}{2}.el_in);
ARGS{1}{2}.el_in0 = struct;
ARGS{1}{2}.el_in0.break = coder.typeof(0);
ARGS{1}{2}.el_in0.mat = coder.typeof(0,[1 2]);
ARGS{1}{2}.el_in0.geom = coder.typeof(0,[1 5]);
ARGS{1}{2}.el_in0.axial = struct;
ARGS{1}{2}.el_in0.axial.form = coder.typeof('X',[1 2]);
ARGS{1}{2}.el_in0.axial.breaks = coder.typeof(0,[1 500],[0 1]);
ARGS{1}{2}.el_in0.axial.coefs = coder.typeof(0,[500 500],[1 1]);
ARGS{1}{2}.el_in0.axial.pieces = coder.typeof(0);
ARGS{1}{2}.el_in0.axial.order = coder.typeof(0);
ARGS{1}{2}.el_in0.axial.dim = coder.typeof(0);
ARGS{1}{2}.el_in0.axial = coder.typeof(ARGS{1}{2}.el_in0.axial);
ARGS{1}{2}.el_in0.axial_k = struct;
ARGS{1}{2}.el_in0.axial_k.form = coder.typeof('X',[1 2]);
ARGS{1}{2}.el_in0.axial_k.breaks = coder.typeof(0,[1 500],[0 1]);
ARGS{1}{2}.el_in0.axial_k.coefs = coder.typeof(0,[500 500],[1 1]);
ARGS{1}{2}.el_in0.axial_k.pieces = coder.typeof(0);
ARGS{1}{2}.el_in0.axial_k.order = coder.typeof(0);
ARGS{1}{2}.el_in0.axial_k.dim = coder.typeof(0);
ARGS{1}{2}.el_in0.axial_k = coder.typeof(ARGS{1}{2}.el_in0.axial_k);
ARGS{1}{2}.el_in0.eps0 = coder.typeof(0);
ARGS{1}{2}.el_in0.K0 = coder.typeof(0,[6 6]);
ARGS{1}{2}.el_in0.p = coder.typeof(0);
ARGS{1}{2}.el_in0.r = coder.typeof(0);
ARGS{1}{2}.el_in0.alpha = coder.typeof(0,[5 20],[1 1]);
ARGS{1}{2}.el_in0.beta = coder.typeof(0);
ARGS{1}{2}.el_in0.eps = coder.typeof(0,[5 2],[1 0]);
ARGS{1}{2}.el_in0.f = coder.typeof(0,[5 2],[1 0]);
ARGS{1}{2}.el_in0.nodes = struct;
ARGS{1}{2}.el_in0.nodes.cords = struct;
ARGS{1}{2}.el_in0.nodes.cords.axial = coder.typeof(0,[1000   2],[1 0]);
ARGS{1}{2}.el_in0.nodes.cords.load_point = coder.typeof(0,[1 2]);
ARGS{1}{2}.el_in0.nodes.cords.unload_point = coder.typeof(0,[1 2]);
ARGS{1}{2}.el_in0.nodes.cords.eps_rate = coder.typeof(0);
ARGS{1}{2}.el_in0.nodes.cords = coder.typeof(ARGS{1}{2}.el_in0.nodes.cords,[1 5],[0 1]);
ARGS{1}{2}.el_in0.nodes = coder.typeof(ARGS{1}{2}.el_in0.nodes,[1 20],[0 1]);
ARGS{1}{2}.el_in0.propsLH = coder.typeof(0,[5 1]);
ARGS{1}{2}.el_in0.D0 = coder.typeof(0,[6 1]);
ARGS{1}{2}.el_in0.P0 = coder.typeof(0,[6 1]);
ARGS{1}{2}.el_in0.n = coder.typeof(0);
ARGS{1}{2}.el_in0.flex = struct;
ARGS{1}{2}.el_in0.flex.break = coder.typeof(0);
ARGS{1}{2}.el_in0.flex.K = coder.typeof(0,[5 5]);
ARGS{1}{2}.el_in0.flex.D = coder.typeof(0,[5 20],[0 1]);
ARGS{1}{2}.el_in0.flex.Du = coder.typeof(0,[5 20],[0 1]);
ARGS{1}{2}.el_in0.flex.Q = coder.typeof(0,[5 1]);
ARGS{1}{2}.el_in0.flex.f = coder.typeof(0,[5  5 20],[0 0 1]);
ARGS{1}{2}.el_in0.flex.d = coder.typeof(0,[5 20],[0 1]);
ARGS{1}{2}.el_in0.flex.e = coder.typeof(0,[2 20],[0 1]);
ARGS{1}{2}.el_in0.flex = coder.typeof(ARGS{1}{2}.el_in0.flex);
ARGS{1}{2}.el_in0.state_it = coder.typeof(false);
ARGS{1}{2}.el_in0.el = coder.typeof(0);
ARGS{1}{2}.el_in0 = coder.typeof(ARGS{1}{2}.el_in0);
ARGS{1}{2} = coder.typeof(ARGS{1}{2});
ARGS{1}{3} = coder.typeof(0,[1 12  4]);

%% Invoke MATLAB Coder.
cd('C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE');
codegen -config cfg -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE\el1 -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE\coro -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE\coro\rotations -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\misc_eng\toolbox -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE\el2 -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE\el3_flex -I C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\FE\el4 assemble_body -args ARGS{1}
