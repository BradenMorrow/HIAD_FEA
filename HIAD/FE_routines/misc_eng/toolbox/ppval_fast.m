function v=ppval_fast(pp,xx)
%PPVAL  Evaluate piecewise polynomial.
%   V = PPVAL(PP,XX) returns the value, at the entries of XX, of the 
%   piecewise polynomial f contained in PP, as constructed by PCHIP, SPLINE,
%   INTERP1, or the spline utility MKPP.
%
%   V is obtained by replacing each entry of XX by the value of f there.
%   If f is scalar-valued, then V is of the same size as XX. XX may be ND.
%
%   If PP was constructed by PCHIP, SPLINE or MKPP using the orientation of
%   non-scalar function values specified for those functions, then:
%
%   If f is [D1,..,Dr]-valued, and XX is a vector of length N, then V has
%   size [D1,...,Dr, N], with V(:,...,:,J) the value of f at XX(J).
%   If f is [D1,..,Dr]-valued, and XX has size [N1,...,Ns], then V has size
%   [D1,...,Dr, N1,...,Ns], with V(:,...,:, J1,...,Js) the value of f at
%   XX(J1,...,Js).
%
%   If PP was constructed by INTERP1 using the orientation of non-scalar
%   function values specified for that function, then:
%
%   If f is [D1,..,Dr]-valued, and XX is a scalar, then V has size
%   [D1,...,Dr], with V the value of f at XX.
%   If f is [D1,..,Dr]-valued, and XX is a vector of length N, then V has
%   size [N,D1,...,Dr], with V(J,:,...,:) the value of f at XX(J).
%   If f is [D1,..,Dr]-valued, and XX has size [N1,...,Ns], then V has size
%   [N1,...,Ns,D1,...,Dr], with V(J1,...,Js,:,...,:) the value of f at
%   XX(J1,...,Js).
%
%   Example:
%   Compare the results of integrating the function cos and its spline
%   interpolant:
%
%     a = 0; b = 10;
%     int1 = integral(@cos,a,b);
%     x = a:b; y = cos(x); pp = spline(x,y); 
%     int2 = integral(@(x)ppval(pp,x),a,b);
%
%   int1 provides the integral of the cosine function over the interval [a,b]
%   while int2 provides the integral, over the same interval, of the piecewise
%   polynomial pp that approximates the cosine function by interpolating the
%   computed x,y values.
%
%   Class support for input X and the fields of PP:
%      float: double, single
%
%   See also SPLINE, PCHIP, INTERP1, MKPP, UNMKPP.

%   Carl de Boor
%   Copyright 1984-2015 The MathWorks, Inc.

%  obtain the row vector xs equivalent to XX
sizexx = size(xx); lx = numel(xx); xs = reshape(xx,1,lx);
%  if XX is row vector, suppress its first dimension
if length(sizexx)==2&&sizexx(1)==1 
%     sizexx(1) = [];
    size1xx = sizexx(2);
end

% take apart PP
[b,c,l,k,~]=unmkpp(pp);

% for each evaluation site, compute its breakpoint interval
% (mindful of the possibility that xx might be empty)
if lx, [~,index] = histc(xs,[-inf,b(2:l),inf]);
else index = ones(1,lx);
end

% adjust for troubles, like evaluation sites that are NaN or +-inf
infxs = find(xs==inf); if ~isempty(infxs), index(infxs) = l; end
nogoodxs = find(index==0);
if ~isempty(nogoodxs), xs(nogoodxs) = NaN; index(nogoodxs) = 1; end

% now go to local coordinates ...
xs = xs-b(index);

if length(size1xx)>1, dd = []; else dd = 1; end

% ... and apply nested multiplication:
v = c(index,1);
for i=2:k
   v = xs(:).*v + c(index,i);
end

% If evaluating a piecewise constant with more than one piece at NaN, return
% NaN.  With one piece return the constant.
v = reshape(v,[dd,size1xx]);

