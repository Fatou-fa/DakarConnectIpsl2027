// Dr Papa Samour DIOP – Enseignant du cours
// Ce fichier définit le composant IncidentCard.
// Son rôle est de présenter les informations d'un incident
// sous la forme d'une carte graphique dans l'application.

// Importation de la bibliothèque Material de Flutter.
// Elle fournit les composants nécessaires à la construction
// de l'interface graphique : Card, Text, Icon, Row, Column, etc.
import 'package:flutter/material.dart';

// Importation du modèle Incident.
// Cette classe définit les données que notre carte doit afficher.
import '../models/incident_model.dart';

// Déclaration du composant IncidentCard.
// StatelessWidget signifie que ce composant ne gère pas
// directement un état interne modifiable.
class IncidentCard extends StatelessWidget {
  // Objet contenant toutes les informations de l'incident à afficher.
  // Il s'agit notamment du titre, de la description, du lieu et de l'image.
  final Incident incident;

  // Fonction facultative exécutée lorsque l'utilisateur appuie sur la carte.
  // VoidCallback représente une fonction qui ne reçoit aucun paramètre
  // et ne retourne aucune valeur.
  // Le symbole ? signifie que cette fonction peut être absente (null).
  final VoidCallback? onTap;

  // Constructeur du composant IncidentCard.
  // required incident oblige le composant à recevoir un incident.
  // onTap reste facultatif.
  // super.key transmet la clé au constructeur de la classe parente.
  const IncidentCard({super.key, required this.incident, this.onTap});

  // Redéfinition de la méthode build.
  // Elle construit l'interface graphique de la carte.
  // BuildContext permet à Flutter de situer ce widget
  // dans l'arbre de widgets de l'application.
  @override
  Widget build(BuildContext context) {
    // Card représente le conteneur graphique de notre signalement.
    // Il permet de regrouper les informations dans une carte visuellement distincte.
    return Card(
      // Définition des marges extérieures de la carte.
      // horizontal : espace à gauche et à droite.
      // vertical : espace au-dessus et au-dessous.
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      // elevation définit l'ombre portée par la carte.
      // Une valeur de 4 donne un léger effet de profondeur.
      elevation: 4,

      // clipBehavior définit la manière dont les éléments
      // qui dépassent des limites de la carte sont découpés.
      // Clip.antiAlias permet d'obtenir un découpage plus lisse.
      clipBehavior: Clip.antiAlias,

      // InkWell rend son contenu interactif.
      // Il permet notamment de détecter un appui et d'afficher
      // un effet visuel de contact sur la carte.
      child: InkWell(
        // Fonction appelée lorsque l'utilisateur appuie sur la carte.
        // Si onTap vaut null, aucune action n'est exécutée.
        onTap: onTap,

        // Column organise les éléments verticalement.
        // Ici, l'image est placée au-dessus des informations textuelles.
        child: Column(
          // Les éléments sont alignés sur le côté gauche.
          crossAxisAlignment: CrossAxisAlignment.start,

          // Liste des widgets qui composent la carte.
          children: [
            // Condition : l'image est affichée uniquement
            // si l'adresse imageUrl n'est pas vide.
            // Cette écriture est une condition intégrée à une liste de widgets.
            if (incident.imageUrl.isNotEmpty)
              // Image.network charge une image à partir d'une adresse Internet.
              Image.network(
                incident.imageUrl,

                // Hauteur fixe de l'image : 200 pixels.
                height: 200,

                // L'image occupe toute la largeur disponible.
                width: double.infinity,

                // BoxFit.cover adapte l'image à l'espace disponible
                // en conservant ses proportions.
                // Une partie de l'image peut être coupée si nécessaire.
                fit: BoxFit.cover,

                // errorBuilder définit le widget à afficher
                // lorsque le chargement de l'image échoue.
                // Par exemple, si l'adresse est incorrecte
                // ou si la connexion Internet est indisponible.
                errorBuilder: (context, error, stackTrace) {
                  // SizedBox réserve une hauteur de 200 pixels
                  // pour conserver une présentation cohérente.
                  return const SizedBox(
                    height: 200,

                    // Center place le contenu au centre de l'espace réservé.
                    child: Center(
                      // Icône affichée pour signaler que l'image
                      // n'a pas pu être chargée.
                      child: Icon(Icons.broken_image_outlined),
                    ),
                  );
                },
              ),

            // Padding ajoute un espace intérieur autour des informations.
            // Cela évite que les textes soient collés aux bords de la carte.
            Padding(
              // Définition d'une marge intérieure de 12 pixels
              // sur les quatre côtés.
              padding: const EdgeInsets.all(12.0),

              // Deuxième Column : elle organise verticalement
              // le titre, la description et la localisation.
              child: Column(
                // Alignement des informations sur la gauche.
                crossAxisAlignment: CrossAxisAlignment.start,

                // Liste des informations textuelles de l'incident.
                children: [
                  // Text affiche le titre de l'incident.
                  Text(
                    incident.titre,

                    // TextStyle définit l'apparence du titre.
                    style: const TextStyle(
                      // Taille du texte : 20 pixels.
                      fontSize: 20,

                      // Le titre est affiché en gras.
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // SizedBox ajoute un espace vertical de 8 pixels
                  // entre le titre et la description.
                  const SizedBox(height: 8),

                  // Affichage de la description de l'incident.
                  Text(
                    incident.description,

                    // Limite l'affichage à deux lignes.
                    maxLines: 2,

                    // Si le texte dépasse deux lignes,
                    // les caractères restants sont remplacés par des points de suspension.
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Espace vertical de 8 pixels avant la localisation.
                  const SizedBox(height: 8),

                  // Row organise horizontalement les éléments.
                  // Elle permet de placer l'icône de localisation
                  // à côté du texte indiquant le lieu.
                  Row(
                    children: [
                      // Icône représentant une position géographique.
                      const Icon(
                        Icons.location_on,

                        // Taille de l'icône : 16 pixels.
                        size: 16,

                        // Couleur grise pour une information secondaire.
                        color: Colors.grey,
                      ),

                      // Espace horizontal de 4 pixels
                      // entre l'icône et le texte.
                      const SizedBox(width: 4),

                      // Expanded occupe l'espace horizontal restant.
                      // Cela permet au texte du lieu de s'adapter
                      // à la largeur disponible.
                      Expanded(
                        child: Text(
                          // Affichage du lieu enregistré dans l'objet Incident.
                          incident.lieu,

                          // Définition de la couleur du texte.
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
