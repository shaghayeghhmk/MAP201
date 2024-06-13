// chargement des fonctions necessaires au TP
exec("init_tp_image.sce",-1);

// définition de la fonction ramenant les valeurs entre 0 et 255
deff('z = min0_max255(y)','z=min(max(y,0),255)');

// transformation identité
deff("q = f_identite(p)","q = p+50");

function im2 = T_identite(im)
    im2 = f_identite(im);     // appliquer la fonction
    im2 =  min0_max255(im2); // repasser à des valeurs entre 0 et 255 
endfunction

// tracé de la fonction
t = 0:1:255;
scf(); // creer une nouvelle fenêtre graphique
plot2d(t, f_identite(t),style=5); // tracer la fonction en rouge
axe = gca();
// repère limité à x entre 0 et 1 et y entre 0 et 1
axe.data_bounds = [0,0;255,255]; 

// lecture et affichage de l'image 
im = lire_imageBMPgris("papillon.bmp");
afficher_image(im);
// affichage de son histogramme
scf();
classes = [-0.1, linspace(0,255,256)];
histplot(classes, im, normalization=%f, strf='021');
title('Histogramme original')

// opération sur im
im2 = T_identite(im);     // appliquer la fonction
// affichage de l'image transformée
afficher_image(im2);
// tracé du nouvel histogramme
scf();
histplot(classes, im2, normalization=%f, strf='021');
title('Histogramme transformé')


