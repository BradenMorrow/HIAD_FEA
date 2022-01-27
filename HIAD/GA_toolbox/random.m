function [number] = random(n)
%Random number generator
%Andrew Goupee
%Last modified:  4-21-04

%This function generates a random integer between 1 and n (an
%integer value) and places that value in number (the ouput).

%Create random number
number = round((n)*rand(1)+0.5);

%Ensure a reasonable number
if number < 1;
    number = 1;
elseif number > n;
    number = n;
else;
    %nothing new happens
end;