import cv2
import numpy as np

# Charger l'image en niveaux de gris
img = cv2.imread(r"C:\Users\Shaghayegh\Downloads\fichiers_TP2\desert.bmp", cv2.IMREAD_GRAYSCALE)

# Calculer l'histogramme
hist = cv2.calcHist([img], [0], None, [256], [0, 256])

# Calculer l'histogramme cumulé
cum_hist = np.cumsum(hist)

# Normaliser l'histogramme cumulé entre 0 et 255
cum_hist_norm = cum_hist * 255 / cum_hist.max()
cum_hist_norm = cum_hist_norm.astype('uint8')

# Créer une image vide et dessiner l'histogramme cumulé
h, w = img.shape[:2]
cum_hist_img = np.zeros((h, w), dtype='uint8')
for i in range(256):
    cv2.line(cum_hist_img, (i, h), (i, h - cum_hist_norm[i]), 255)

# Ajouter des axes et des chiffres à l'histogramme cumulé
cv2.line(cum_hist_img, (0, h), (256, h), 255)
cv2.line(cum_hist_img, (0, h), (0, 0), 255)
for i in range(0, 257, 64):
    cv2.putText(cum_hist_img, str(i), (i, h + 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 255)

# Afficher l'image et l'histogramme cumulé
cv2.imshow('Image', img)
cv2.imshow('Histogramme cumulé', cum_hist_img)
cv2.waitKey(0)
cv2.destroyAllWindows()
