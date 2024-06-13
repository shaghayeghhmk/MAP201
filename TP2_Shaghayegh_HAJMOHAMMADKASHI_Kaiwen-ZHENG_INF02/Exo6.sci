//EXO6
//Image égalisée
exec('transformations.sci', -1);
im = lire_imageBMPgris('fruits.bmp');
// calcul de l'image égalisée
im_egal = hist_egal(im);
// affichage 
afficher_image(im_egal);

//l'histogramme de l’image égalisée
exec('init_tp_image.sce');
im = lire_imageBMPgris('fruits.bmp');
// calcul de l'image égalisée
im_egal = hist_egal(im);
// classes pour les valeurs de pixels
classes = [-0.1, linspace(0,255,256)];
// h est un tableau `a 256 entrées qui contient l'histogramme
// h(p) = nb de pixels valant p-1
h = histc(im_egal, classes)
// tracé de l'histogramme
scf();
histplot(classes, im_egal, normalization=%f, strf='021');

//l'histogramme cumulé de l’image égalisée
exec('transformations.sci', -1);
im = lire_imageBMPgris('fruits.bmp');
im_egal = hist_egal(im);
// calcul de l'histogramme cumulé
Hist = hist_cumul(im_egal);
// affichage de l'histogramme cumulé
plot2d3(Hist);
