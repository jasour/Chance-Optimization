function pass = splittingtest
% Test for exact jump detection and singular function approximation.
% Rodrigo Platte.

if ~chebfunpref('splitting')
    error('splitting must be ON')
end
debug = false;
Ntests = 3;

pass = true;
try
    for j = 1:Ntests

        % test jumps
        x0 = rand;
        f= chebfun(@(x) exp(x) +cos(7*x) + sign(x-x0));
        pass = pass && f.ends(2) == x0 && (length(f.ends) < 4);
        if ~pass
            error('jump1')
        end

        x0 = rand;
        x0 = sign(x0-.5)*x0/100; % change sign and closer to origin
        f= chebfun(@(x) exp(x) +cos(7*x) + sign(x-x0));
        pass = pass && f.ends(2) == x0 && (length(f.ends) < 4);
        if ~pass
            error('jump2')
        end

        x0 = rand;
        x0 = sign(x0-.5)*x0/1000; % change sign and even closer to origin
        f= chebfun(@(x) exp(x) +cos(7*x) + 0.1*sign(x-x0))+1;
        pass = pass && f.ends(2) == x0 && (length(f.ends) < 4);
        if ~pass
            error('jump3')
        end

        % test C0 functions
        x0 = rand;
        x0 = sign(x0-.5)*x0; % change sign and closer to origin
        f= chebfun(@(x) exp(x) +cos(7*x) + abs(x-x0));
        pass = pass && abs(f.ends(2) - x0)< 1e-12 && (length(f.ends) < 4);
        if ~pass
            error('C0')
        end

        % test C1 functions
        x0 = rand;
        x0 = sign(x0-.5)*x0;
        f= chebfun(@(x) (x-x0).^2.*double(x>x0));
        pass = pass && abs(f.ends(2) - x0)< 1e-8 && (length(f.ends) < 4);
        if ~pass
            error('C1')
        end

        % test C2 functions
        x0 = rand;
        x0 = sign(x0-.5)*x0/100; % change sign and closer to origin
        f= chebfun(@(x) exp(x) + abs(x-x0).^3+1);
        pass = pass && abs(f.ends(2) - x0)< 1e-4 && (length(f.ends) < 4);
        if ~pass
            error('C2')
        end

        % test C3 functions
        x0 = rand;
        x0 = sign(x0-.5)*x0/100;
        f= chebfun(@(x) (x-x0).^4.*double(x>x0));
        pass = pass && (length(f.ends) < 5);
        if ~pass
            error('C3')
        end

    end
    
    % test sqrt
    ff = @(x) sqrt(x-2)+10;
    f = chebfun(ff, [2,20]);
    xx = linspace(2,10);
    pass = pass && length(f) <600 && norm(f(xx) - ff(xx),inf)<5e-7;
    if ~pass
        error('SQRT')
    end


catch
    
    if debug
        err=lasterror;
        disp('catch')
        disp(x0)
        disp(err.message)
    end
    
end