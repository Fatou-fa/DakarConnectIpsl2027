// Dr Papa Samour DIOP – Enseignant du cours
// Cette classe représente un incident dans notre application Flutter.
// Elle définit la structure des informations que nous devons conserver
// pour décrire un incident signalé par un utilisateur.

class Incident {
  // Identifiant unique de l'incident.
  // Il permet de distinguer chaque incident des autres incidents
  // et de retrouver précisément un incident dans la base de données.
  final String id;

  // Titre de l'incident.
  // Il permet de présenter brièvement la nature du problème signalé.
  // Exemple : "Accident de circulation".
  final String titre;

  // Description détaillée de l'incident.
  // Cette propriété permet à l'utilisateur de fournir davantage
  // d'informations sur les circonstances de l'incident.
  final String description;

  // Lieu où l'incident s'est produit.
  // Cette information permet de localiser géographiquement
  // l'événement signalé.
  final String lieu;

  // Adresse ou chemin de l'image associée à l'incident.
  // Cette image peut permettre d'illustrer visuellement
  // le problème signalé par l'utilisateur.
  final String imageUrl;

  // Date et heure auxquelles l'incident a été enregistré.
  // Le type DateTime permet de manipuler les dates et les heures
  // dans Dart : affichage, comparaison et tri chronologique.
  final DateTime date;

  // Identifiant de l'utilisateur ayant signalé l'incident.
  // Le symbole ? indique que cette propriété est nullable :
  // elle peut contenir un identifiant (String) ou la valeur null.
  // Cela permet notamment de gérer les incidents sans utilisateur associé.
  final String? userId;

  // Constructeur de la classe Incident.
  // Il permet de créer un nouvel objet Incident en fournissant
  // les informations nécessaires à son initialisation.
  //
  // Le mot-clé const autorise la création d'instances constantes
  // lorsque toutes les valeurs fournies sont elles-mêmes constantes.
  const Incident({
    // required signifie que l'appelant doit obligatoirement fournir
    // une valeur pour cette propriété lors de la création de l'objet.
    required this.id,

    // Le titre est également obligatoire.
    required this.titre,

    // La description doit être renseignée à la création.
    required this.description,

    // Le lieu de l'incident est une information obligatoire.
    required this.lieu,

    // L'image est facultative.
    // Si aucune valeur n'est fournie, une chaîne vide ('') est utilisée
    // automatiquement comme valeur par défaut.
    this.imageUrl = '',

    // La date de l'incident doit obligatoirement être fournie.
    required this.date,

    // L'identifiant de l'utilisateur est facultatif.
    // En l'absence de valeur, Dart lui attribue automatiquement null.
    this.userId,
  });
}
