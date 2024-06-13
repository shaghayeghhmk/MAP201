// chargement des fonctions necessaires au TP
exec("init_tp_image.sce",-1);

// définition de la fonction ramenant les valeurs entre 0 et 255
deff('z = min0_max255(y)','z=min(max(y,0),255)');

////// Histogramme cummulé /////

function Hist = hist_cumul(im)
    // classes pour le calcul de l'histogramme
    classes = [-0.1, linspace(0,255,256)];
    // calcul de l'histogramme
    hist = histc(classes, im, normalization=%f);
    // calcul de l'histogramme cumulé
    Hist = zeros(256);
    //à compléter
    for i = 1:256
        Hist(i) = sum(hist(1:i));
    end
endfunction

////// correction affine ///////
deff("q = f_affine(p, p0, p1)","q =(p-p0)*(255/(p1-p0))");// A MODIFIER
function im2 = T_affine(im, p0, p1)
    im2 = f_affine(im, p0, p1);     // appliquer la fonction
    im2 =  min0_max255(im2); // repasser à des valeurs entre 0 et 255 
endfunction

function [p0, p1] = calcul_p0p1(im, s)
    // calcul de l'histogramme cumulé normalisé
    H = hist_cumul(im);
    H_norm = H ./ (size(im, 1) * size(im, 2));
    // détermination de p0
    p0 = 0;
    for i = 1:256
        if H_norm(i) >= s/100
            p0 = i - 1;
            break;
        end
    end
    
    // détermination de p1
    p1 = 255;
    for i = 256:-1:1
        if H_norm(i) <= (1 - s/100)
            p1 = i - 1;
            break;
        end
    end
endfunction

////// Egalisation d'histogramme ///////
function im_out = hist_egal(im)
    // calcul de l'histogramme cumulé
    H1 = hist_cumul(im);
    factor = 255/(size(im, 1) * size(im, 2)); // normalisation
    // créer une nouvelle image
    im_out = zeros(size(im));
    // appliquer la transformation à chaque pixel
    for i = 1:size(im, 1)
        for j = 1:size(im, 2)
            im_out(i, j) = factor * H1(im(i, j)+1);
        end
    end
    // retourner la nouvelle image
    im_out = min0_max255(im_out);
endfunction

////// seuillage //////

deff("im3 = produit(im1,im2)","im3 = im1.*im2/255");

function im2 = seuillage(im, s)
    [M,N] = size(im);
    im2 = zeros(M,N);
    // à compléter
    for i = 1:M
        for j = 1:N
            if im(i, j) >= s
                im2(i, j) = 255;
            end
        end
    end
endfunction




