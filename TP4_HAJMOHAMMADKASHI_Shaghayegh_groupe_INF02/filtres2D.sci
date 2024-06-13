// chargement des fonctions necessaires au TP
exec("init_tp_image.sce",-1);
exec("filtres1D.sci",-1);

// définition de la fonction ramenant les valeurs entre 0 et 255
deff('z = min0_max255(y)','z=min(max(y,0),255)');

function afficher_fenetre2D(im,m)
    [M,N] = size(im);
    for u = m+1:M-m
        for v = m+1:N-m
            disp(im(u-m:u+m, v-m:v+m));
        end
    end
endfunction

function im2 = moyenne2D(im1, m)
    [M,N] = size(im1);
    im2 = zeros(im1);
    for u = m+1:M-m
        for v = m+1:N-m
            im2(u,v) = mean(im1(u-m:u+m, v-m:v+m));
        end
    end
endfunction

function im2 = moyenne2D_W(im1, W)
    [M,N] = size(im1);
    m = (max(size(W))-1)/2;
    im2 = zeros(im1);
    for u = m+1:M-m
        for v = m+1:N-m
            im2(u,v) = sum(im1(u-m:u+m, v-m:v+m).*W);
        end
    end
endfunction

function y = g_sigma(x, sigma)
    y = exp(-0.5*x.^2/sigma^2);    
endfunction

function G = W_gauss_2D(sigma)
    exec('filtres1D.sci');
    G1D = W_gauss(sigma);
    G = G1D'*G1D;
endfunction

