
//EXO1
exec('init_tp_image.sce');

im = lire_imageBMPgris('cellules.bmp');
afficher_image(im);
// classes pour les valeurs de pixels
classes = [-0.1, linspace(0,255,256)];
// h est un tableau `a 256 entr´ees qui contient l'histogramme
// h(p) = nb de pixels valant p-1
h = histc(im, classes)
// attention cette syntaxe correspond aux versions r´ecentes de scilab
// la syntaxe ancienne est
// h = histc(classes, im, normalization=%f);
// trac´e de l'histogramme
scf();
histplot(classes, im, normalization=%f, strf='021');


//EXO3
exec('transformations.sci', -1)
im = lire_imageBMPgris('cellules.bmp');
// calcul de l'histogramme cumulé
Hist = hist_cumul(im);
// affichage de l'histogramme cumulé
plot2d3(Hist);

//EXO4

// chargement des fonctions de transformation
exec('transformations.sci');

// chargement de l'image et calcul de sa transformation affine
im = lire_imageBMPgris('desert.bmp');
a = 255 / (230 - 73);
b = -73 * (230 - 73);
im2 = T_affine(im, a, b);

// affichage des images et des histogrammes
afficher_image(im);
afficher_image(im2);

// classes pour les valeurs de pixels
classes = [-0.1, linspace(0, 255, 256)];

// h est un tableau `a 256 entr´ees qui contient l'histogramme
// h(p) = nb de pixels valant p-1
h = histc(im, classes);

scf();
histplot(classes, im, normalization=%f, strf='021');
histplot(classes, im2, normalization=%f, strf='021');

histo = hist(im);
histo2 = hist(im2);

plot2d(histo, style=3);
plot2d(histo2, style=3, color=2);*/

