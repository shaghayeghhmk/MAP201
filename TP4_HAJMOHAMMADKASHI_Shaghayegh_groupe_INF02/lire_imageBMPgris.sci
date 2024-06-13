// lecture d'une image en 256 niveaux de gris au format BMP non compressé
// syntaxe : IMAGE = lire_imageBMPgris(nom_fichier)
// avec nom_fichier = non du fichier à lire (chaine de caractères)
//      IMAGE = matrice de l'image (valeurs entières entre 0 et 255)
function IMAGE = lire_imageBMPgris(nom_fichier)
  
[fd,err] = mopen(nom_fichier, 'rb');
c = mget(2, 'uc', fd);
c = mget(4, 'uc', fd);
c = mget(2, 'uc', fd);
c = mget(2, 'uc', fd);
c = mget(4, 'uc', fd);
c = mget(4, 'uc', fd);
c = mget(4, 'uc', fd);
L = ((c(4)*256+c(3))*256+c(2))*256+c(1);
c = mget(4, 'uc', fd);
H = ((c(4)*256+c(3))*256+c(2))*256+c(1);
c = mget(2, 'uc', fd);
c = mget(2, 'uc', fd);
c = mget(4, 'uc', fd);
c = mget(4, 'uc', fd);
TAILLE = ((c(4)*256+c(3))*256+c(2))*256+c(1);
c = mget(4, 'uc', fd);
c = mget(4, 'uc', fd);
c = mget(4, 'uc', fd);
c = mget(4, 'uc', fd);

// lecture de la table de 256 niveaux de gris
for i=0:255
	c = mget(4, 'uc', fd);
end

// lecture de l'image
IMAGE = zeros(H,L);
Lnone = ceil(L/4)*4-L;
for i=H:-1:1
	for j=1:L
		IMAGE(i,j) = mget(1, 'uc', fd);
	end
	for j=1:Lnone
		dummy = mget(1, 'uc', fd);
	end
end

mclose(fd);

endfunction
