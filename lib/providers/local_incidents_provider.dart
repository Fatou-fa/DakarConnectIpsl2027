// Dr Papa Samour DIOP – Enseignant du cours
// Ce fichier gère les incidents enregistrés localement dans l'application.
// Il utilise Riverpod pour centraliser les données et permettre
// aux différents écrans de consulter ou de modifier la liste des incidents.

// Importation de Flutter Riverpod.
// Cette bibliothèque fournit les outils nécessaires à la gestion
// de l'état de l'application à travers les providers.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Importation du modèle Incident.
// Cette classe définit la structure des données d'un signalement.
import '../models/incident_model.dart';

// Déclaration de LocalIncidentsNotifier.
// Cette classe hérite de Notifier<List<Incident>>.
// Notifier permet de gérer un état et de définir les opérations
// qui peuvent modifier cet état.
// Ici, l'état est une liste d'objets Incident.
class LocalIncidentsNotifier extends Notifier<List<Incident>> {
  // Méthode appelée par Riverpod pour initialiser l'état du provider.
  // Elle retourne la liste initiale des incidents disponibles.
  // Cette méthode est également utilisée pour construire l'état
  // lorsque le provider est initialisé.
  @override
  List<Incident> build() {
    // Retourne une liste contenant trois incidents de démonstration.
    // Les données sont définies directement dans le code :
    // elles constituent donc des données initiales simulées.
    return [
      // Création du premier objet Incident.
      // Le constructeur reçoit les informations nécessaires
      // pour décrire un signalement.
      Incident(
        // Identifiant du premier incident.
        id: '1',

        // Titre qui résume le problème signalé.
        titre: 'Nid-de-poule sur la VDN',

        // Description qui apporte des précisions sur le problème.
        description: 'Chaussée dégradée près du carrefour.',

        // Localisation géographique du signalement.
        lieu: 'VDN, Dakar',

        // Adresse Internet de l'image associée à l'incident.
        imageUrl: 'https://picsum.photos/seed/dakar-route/900/500',

        // Date de création du signalement.
        // DateTime.now() récupère la date et l'heure actuelles.
        // subtract() soustrait une durée à cette date.
        // Ici, le signalement est considéré comme datant de deux jours.
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),

      // Création du deuxième objet Incident.
      Incident(
        // Identifiant du deuxième incident.
        id: '2',

        // Titre du signalement.
        titre: 'Lampadaire en panne',

        // Description du problème constaté.
        description: 'Éclairage public défaillant.',

        // Lieu où le problème a été signalé.
        lieu: 'Médina, Dakar',

        // Adresse Internet de l'image associée au signalement.
        imageUrl: 'https://picsum.photos/seed/dakar-eclairage/900/500',

        // Date du signalement calculée à partir de la date actuelle.
        // La durée soustraite est de douze heures.
        date: DateTime.now().subtract(const Duration(hours: 12)),
      ),

      // Création du troisième objet Incident.
      Incident(
        // Identifiant du troisième incident.
        id: '3',

        // Titre du signalement.
        titre: 'Dépôt sauvage d’ordures',

        // Description détaillée du problème.
        description: 'Accumulation de déchets sur la voie publique.',

        // Localisation du signalement.
        lieu: 'Parcelles Assainies, Dakar',

        // Adresse Internet de l'image associée à cet incident.
        imageUrl: 'https://picsum.photos/seed/dakar-dechets/900/500',

        // Date de création calculée à partir de la date actuelle.
        // Le signalement est considéré comme datant d'un jour.
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  // Méthode permettant d'ajouter un nouvel incident à la liste.
  // Les accolades dans la déclaration des paramètres indiquent
  // qu'il s'agit de paramètres nommés.
  void add({
    // Titre obligatoire du nouveau signalement.
    required String titre,

    // Description obligatoire du signalement.
    required String description,

    // Lieu obligatoire où le problème a été constaté.
    required String lieu,

    // Adresse de l'image facultative.
    // Si aucune valeur n'est fournie, une chaîne vide est utilisée.
    String imageUrl = '',
  }) {
    // Création d'un nouvel objet Incident à partir des informations reçues.
    final incident = Incident(
      // Génération d'un identifiant à partir de la date actuelle
      // exprimée en microsecondes depuis l'époque Unix.
      // toString() convertit cette valeur numérique en chaîne de caractères.
      id: DateTime.now().microsecondsSinceEpoch.toString(),

      // Affectation du titre reçu en paramètre.
      titre: titre,

      // Affectation de la description reçue en paramètre.
      description: description,

      // Affectation de la localisation reçue en paramètre.
      lieu: lieu,

      // Affectation de l'adresse de l'image.
      imageUrl: imageUrl,

      // Enregistrement de la date et de l'heure actuelles.
      date: DateTime.now(),
    );

    // Mise à jour de l'état du provider.
    // Une nouvelle liste est créée avec :
    // 1. Le nouvel incident placé au début.
    // 2. Tous les incidents déjà présents dans state.
    //
    // L'opérateur ... permet de reprendre les éléments
    // de l'ancienne liste et de les intégrer à la nouvelle.
    //
    // Cette organisation permet d'afficher le dernier signalement
    // ajouté avant les précédents.
    state = [incident, ...state];
  }
}

// Déclaration du provider accessible aux widgets de l'application.
// NotifierProvider relie la classe LocalIncidentsNotifier
// à l'état qu'elle gère, ici une liste d'objets Incident.
//
// LocalIncidentsNotifier.new permet à Riverpod de créer
// une nouvelle instance du gestionnaire d'état.
// Les écrans peuvent ensuite consulter ou modifier les incidents
// à travers ce provider.
final localIncidentsProvider =
    NotifierProvider<LocalIncidentsNotifier, List<Incident>>(
      LocalIncidentsNotifier.new,
    );
