exec('init_tp_image.sce');
im1 = lire_imageBMPgris('papillon.bmp');
// filtre moyenne
M = 1/9*ones(3, 3);
im2 = conv2(im1, M, "same");
afficher_image(im2)
