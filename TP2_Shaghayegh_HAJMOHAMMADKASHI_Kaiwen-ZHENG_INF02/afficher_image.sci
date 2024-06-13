// afficher_image : afficher une image en niveau de gris
// syntaxe : num_f = afficher_image(image)
// avec image = matrice d'entiers entre 0 et 255

function b = is_int8(x)
   if (min(x) >= 0 & max(x) <= 255) & (find(x - floor(x) ~= 0) == []) then
      b = %t
   else
      b = %f
   end
endfunction

function b = is_in_boundaries(x)
   if (min(x) >= 0 & max(x) <= 255) then
      b = %t
   else
      b = %f
   end
endfunction

function f = afficher_image(image)

nargin = argn(2);
if nargin<1 then
 error("syntaxe : num_f = afficher_image_gris(image)")
end

if ~is_in_boundaries(image) then
   error("valeur non autorisée")
end

// dimensions de l'image
H = size(image,1);
L = size(image,2);
//if H>1000 | L>1000 then
//  error('definition superieur au max 1000x1000');
//end
//
// création d'une figure
f = figure();

f.color_map = linspace(0,1,256)'*[1 1 1];
if nargin==3, f.figure_name = titre; end
a = gca();
a.tight_limits = "on";
a.data_bounds = [0.5 0.5 ; L+0.5 H+0.5];
a.margins = [0 0 0 0];
a.isoview="on"
Matplot(image);

// ajustement de la taille de fenetre
OS = getos();
if OS=="Linux" then
    f.figure_size = f.figure_size+[2,2];
elseif OS=="Windows" then
    f.figure_size = f.figure_size+[4,4];
end
endfunction
