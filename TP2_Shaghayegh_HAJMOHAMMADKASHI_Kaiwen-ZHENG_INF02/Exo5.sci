//EXO5
exec('transformations.sci');
// desert.bmp
im = lire_imageBMPgris('desert.bmp');
s = 10;
[p0, p1] = calcul_p0p1(im, s);
disp(p0, p1);
im2 = T_affine(im, p0, p1);
im3 = seuillage(im2, p1);
afficher_image(im3);
