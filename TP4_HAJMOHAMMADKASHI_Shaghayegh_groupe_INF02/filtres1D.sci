function afficher_fenetre(s,m)
    M = size(s,2);
    for u = m+1:M-m
        disp(s(u-m:u+m))
    end
endfunction

function s2 = moyenne(s1, m)
    M = size(s1,2);
    s2 = zeros(s1);
    for i = m+1:M-m
        s2(i) = mean(s1(i-m:i+m));
    end
endfunction

function s2 = moyenne_W(s1, W)
    M = size(s1,2);
    m = (size(W,2)-1)/2;
    s2 = zeros(s1);
    for i = m+1:M-m
        s2(i) = sum(s1(i-m:i+m).*W);
    end
    
endfunction

function y = g_sigma(x, sigma)
    y = exp(-0.5*x.^2/sigma^2);    
endfunction

function G = W_gauss(sigma)
    eps = 1e-3;
    L = floor(sqrt(-2*log(eps))*sigma);
    indices = -L:L;
    G = g_sigma(indices, sigma);
    G = 1/sum(G)*G;
endfunction


