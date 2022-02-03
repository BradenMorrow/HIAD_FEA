function [X] = get_X(param)

X = [param.p_i
    param.beta_i
    270 - param.alpha_i(:,1)
    param.k_cord_fac_i
    param.n_loop1
    param.n_loop2
    param.n_rad
    param.PT_loop1
    param.PT_loop2
    param.PT_rad
    param.k_loop1_fac
    param.k_loop2_fac
    param.k_rad_fore_fac
    param.k_rad_aft_fac];

end

