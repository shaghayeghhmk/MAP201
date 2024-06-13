// calcule la norme du gradient d'une image
// le tableau imn en sortie peut comporter 
// des valeurs non entieres
function imn = norme_gradient(im)
    // tableau imn initialise a la meme 
    // taille que l'image
    imn = zeros(im);
    Dx = 0.5*[-1, 0, 1];
    Dy = 0.5*[1; 0; -1];
    imx = conv2(im, Dx, "same");
    imy = conv2(im, Dy, "same");
    imn=sqrt(imx.^2+imy.^2);
    imn = (imn - min(imn(:))) * 255 / (max(imn(:)) - min(imn(:)));
endfunction

/*exec('init_tp_image.sce');
exec('contours.sci');
im = lire_imageBMPgris('sweets.bmp');
imn = norme_gradient(im);
afficher_image(int(imn));*/


// determine les contours :
// valeur = 0 partout
// sauf pour pixels ou la norme du gradient est superieure 
// a un seuil, dans ce cas valeur = 255
function imc = contours_seuil(im, seuil)
    imn = norme_gradient(im);
    imc = zeros(im);
    [M,N]=size(imc)
    for u=1:M
        for v=1:N
            if imn(u,v)< seuil then
                imc(u,v)=0
            else
                imc(u,v)=255
            end
        end    
    end
endfunction
/*exec('contours.sci', -1);
im = lire_imageBMPgris('barque.bmp');
seuil = 20;
imc = contours_seuil(im, seuil);
afficher_image(imc);*/

// identifie le seuil tel qu'il y a
// un pourcentage p des pixels pour 
// lesquels la norme du gradient est 
// inferieure a ce seuil
function seuil = trouver_seuil(im, p)
    G = norme_gradient(im);
    H = hist_cumul(G);
    seuil = 1;
    while H(seuil)/H(256) < p
        seuil = seuil + 1;
    end
endfunction

/*exec('init_tp_image.sce');
exec('contours.sci', -1);
p = 0.8;
im = lire_imageBMPgris('barque.bmp');
seuil = trouver_seuil(im, p);
disp(seuil);*/

//pour p=0,8 seuil=31 
//pour p=0,5 seuil=11 
//pour p=0 seuil=256 
//pour p=1 seuil=1 
/*
im = lire_imageBMPgris('barque.bmp');
p = 0.9;
afficher_image(contours_p(im, p));
seuil = trouver_seuil(im, p);
disp(seuil);
*/
// determine le seuil a partir d'un 
// pourcentage p
function imc = contours_p(im, p)
    G = norme_gradient(im);
    imc = contours_seuil(im, trouver_seuil(im, p));
endfunction

// filtre Gaussien
/*exec('filtres2D.sci');
p = 0.8;
im = lire_imageBMPgris('barque.bmp');
sigma = 0.5;*/
//afficher_image(contours_p(conv2(im, W_gauss_2D(sigma), "same"), p));

// filtre moyenne
/*M = 1/9*ones(8, 8);*/
//afficher_image(contours_p(conv2(im, M, "same"), p));


exec('filtres1D.sci');

// image intialement noire
N = 40;
M = 2*N
im = zeros(N,M);

// l'image est compos´ee de trois bandes de taille n:
n = floor(M/3)

// le premier tiers reste noir
// le deuxi`eme tiers est un d´egrad´e avec un fort gradient
// de 30 `a 255
for j = n:2*n
    im(:, j) = 30 + ((j - n)/n)^4*225;
end

// le dernier tiers est `a 255
im(:, 2*n+1:M) = 255;

// lissage gaussien
G = W_gauss(0.5);
im = conv2(im, G);

// extraction des contours
contours = contours_p(im, 0.95);

// affichage des contours
//afficher_image(contours);

// tracé de la ligne médiane de l'image pour visualiser l'épaisseur des contours
//scf();
//plot(contours(N/2, :));


// calcul de l'histogramme cumule
function Hist = hist_cumul(im)
    // calcul de l'histogramme
    classes = [-0.1, linspace(0,255,256)];
    hist = histc(classes, im, normalization=%f);
    Hist = zeros(256)
    Hist(1) = hist(1)
    for i = 2:256
        Hist(i) = Hist(i-1) + hist(i) 
    end
endfunction

//afficher_image(contours_p(conv2(im, W_gauss_2D(sigma),"same"),p));



function [u1,v1,u2,v2] = indices_voisins(u,v,phi)
    //ici en fonction de l'angle donné on définit la direction du gradient et on retourne les indice des voisins avant et après dans cette direction
    if (phi <= %pi/8) || (phi >= 7*%pi/8)  then //cas 1
        u1=u ; u2=u ; v1=v-1 ; v2=v+1
    elseif (phi > %pi/8) &&  (phi <= 3*%pi/8)  then //cas2
        u1=u+1 ; u2=u-1 ; v1=v-1 ; v2=v+1
    elseif (phi > 3*%pi/8) && (phi < 5*%pi/8)  then //cas3
        u1=u-1 ; u2=u+1 ; v1=v ; v2=v
    else  //cas 4
        u1=u+1 ; u2=u-1 ; v1=v+1 ; v2=v-1      
    end
endfunction
// renvoie une image 500x500 avec un disque blanc
// sur fond noir
function im_out=contours_max(im,p)
 /* dans cette fonction ,pour chaque pixel
    on trouve d'abord l'angle de dérivé horizontalement et de dérivé verticalemet 
    et puis en utilisant la fonction précédent on récupère les coordonées des voisins 
    dans la direction de gradient et on verifie si tous les deux voisins ont une norme    gradient inférieur à la norme de gradient du pixel central, on sait qu'on est dans    le pique et on met à 255 la valeur de cette pixels eet 0 les autre
    */

    [M,N]=size(im)
    im_out=zeros(M,N)
    apres_p=contours_p(im,p)
    imn = norme_gradient(im)
    Dx=[-1,0,1]  
    Dy=[1;0;-1]
    imx=conv2(im,Dx,"same")
    imy=conv2(im,Dy,"same")
    for i=2:M-1
        for j=2:N-1
            if apres_p(i,j)==255 then
                phi=atan(imy(i,j),imx(i,j))
                [u1,v1,u2,v2] = indices_voisins(i,j,phi)
                if imn(u1,v1)<= imn(i,j) && imn(u2,v2)<= imn(i,j) then
                    im_out(i,j)=255
                else im_out(i,j)=0
                end
            else im_out(i,j)=0
            end
        end
    end
endfunction

function im = disque()
    im = zeros(500, 500)
    for i = 1:500
        for j = 1:500
            if abs(i-250)^2 + abs(j-250)^2 < 150^2 then
                im(i,j) = 255
            end
        end
    end
endfunction
exec('filtres2D.sci');
p = 0.7;
im = lire_imageBMPgris('sweets.bmp');
sigma = 2;
afficher_image(contours_max(conv2(im, W_gauss_2D(sigma),"same"),p));
