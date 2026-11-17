// Dr Papa Samour DIOP – Enseignant du cours
// Ce fichier définit l'écran de connexion de notre application.
// Il permet à l'utilisateur de saisir son identifiant ou son adresse e-mail
// ainsi que son mot de passe avant de déclencher une simulation de connexion.

// Importation de la bibliothèque Material de Flutter.
// Elle donne accès aux composants graphiques nécessaires à la construction
// de l'interface : Scaffold, AppBar, TextFormField, FilledButton, etc.
import 'package:flutter/material.dart';

// Déclaration du widget LoginScreen.
// StatefulWidget indique que cet écran possède un état susceptible
// d'évoluer pendant son utilisation, notamment lorsque l'utilisateur
// saisit des informations dans les champs du formulaire.
class LoginScreen extends StatefulWidget {
  // Constructeur de l'écran de connexion.
  // super.key transmet la clé au constructeur de la classe parente.
  const LoginScreen({super.key});

  // createState() permet de créer l'objet responsable de la gestion
  // de l'état de notre écran.
  // Cet objet contiendra les contrôleurs, les variables et la logique
  // nécessaires au fonctionnement du formulaire.
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Déclaration de la classe qui gère l'état de LoginScreen.
// Elle hérite de State<LoginScreen> et contient la logique interne
// de l'écran de connexion.
// Le symbole _ placé devant le nom de la classe indique qu'elle est privée
// au fichier dans lequel elle est déclarée.
class _LoginScreenState extends State<LoginScreen> {
  // Création d'une clé globale permettant d'identifier et de contrôler
  // le formulaire.
  // GlobalKey<FormState> donne accès à l'état du formulaire,
  // notamment à sa méthode validate() qui déclenche la validation
  // de l'ensemble des champs.
  final formKey = GlobalKey<FormState>();

  // Création d'un contrôleur pour le champ de saisie de l'identifiant
  // ou de l'adresse e-mail.
  // TextEditingController permet de récupérer, modifier ou surveiller
  // le texte saisi par l'utilisateur.
  final email = TextEditingController();

  // Création d'un deuxième contrôleur destiné au mot de passe.
  // Il permet notamment de récupérer le contenu saisi dans ce champ.
  final password = TextEditingController();

  // Redéfinition de la méthode dispose().
  // Cette méthode est appelée lorsque le widget est définitivement retiré
  // de l'arbre des widgets.
  // Elle permet de libérer les ressources utilisées par les contrôleurs.
  @override
  void dispose() {
    // Libération des ressources associées au contrôleur de l'e-mail.
    // Cette opération évite de conserver inutilement des ressources
    // lorsque l'écran de connexion n'est plus utilisé.
    email.dispose();

    // Libération des ressources associées au contrôleur du mot de passe.
    password.dispose();

    // Appel de la méthode dispose() de la classe parente.
    // Il est important de conserver cet appel pour permettre à Flutter
    // d'effectuer correctement son nettoyage interne.
    super.dispose();
  }

  // Redéfinition de la méthode build().
  // Elle construit l'interface graphique de l'écran de connexion.
  // BuildContext permet notamment d'accéder au contexte de l'application,
  // aux éléments de navigation et aux services disponibles dans l'arbre Flutter.
  @override
  Widget build(BuildContext context) {
    // Scaffold constitue la structure principale de notre écran.
    // Il fournit les différentes zones d'une interface Material Design,
    // notamment la barre supérieure et le corps de la page.
    return Scaffold(
      // AppBar représente la barre supérieure de l'écran.
      // Elle permet d'afficher le titre de la page.
      appBar: AppBar(
        // Affichage du titre de l'écran.
        // const indique que ce widget Text est constant.
        title: const Text('Connexion'),

        // centerTitle: true permet de centrer horizontalement
        // le titre dans la barre supérieure.
        centerTitle: true,
      ),

      // body représente la zone principale de l'écran.
      // SingleChildScrollView permet de faire défiler verticalement
      // le contenu lorsque celui-ci dépasse l'espace disponible.
      // Cela est particulièrement utile lorsque le clavier du téléphone
      // apparaît et réduit la hauteur disponible.
      body: SingleChildScrollView(
        // Ajoute une marge intérieure de 24 pixels sur les quatre côtés.
        // Cette propriété permet d'éviter que le formulaire soit collé
        // aux bords de l'écran.
        padding: const EdgeInsets.all(24),

        // Form regroupe les champs de saisie qui appartiennent
        // au même formulaire.
        // Il permet notamment de centraliser la validation des champs
        // grâce à la clé formKey.
        child: Form(
          // Associe la clé globale au formulaire.
          // Grâce à cette association, nous pouvons accéder à son état
          // depuis le code et appeler validate() pour contrôler les champs.
          key: formKey,

          // Column organise les éléments graphiques verticalement.
          child: Column(
            // CrossAxisAlignment.stretch étire les enfants horizontalement
            // pour qu'ils occupent toute la largeur disponible.
            // Pour une Column, l'axe secondaire est l'axe horizontal.
            crossAxisAlignment: CrossAxisAlignment.stretch,

            // Liste des widgets qui composent le formulaire de connexion.
            children: [
              // Ajoute un espace vertical de 30 pixels en haut du formulaire.
              const SizedBox(height: 30),

              // Affiche une icône représentant un compte utilisateur.
              const Icon(
                // Icône prédéfinie dans la bibliothèque Material.
                Icons.account_circle_outlined,

                // Définit la taille de l'icône à 85 pixels.
                size: 85,

                // Applique la couleur bleue à l'icône.
                color: Colors.blue,
              ),

              // Ajoute un espace vertical de 20 pixels après l'icône.
              const SizedBox(height: 20),

              // Affiche le message de bienvenue.
              const Text(
                'Bienvenue !',

                // Centre horizontalement le texte dans son espace.
                textAlign: TextAlign.center,

                // Définit la présentation du texte.
                style: TextStyle(
                  // Taille du texte : 24 pixels.
                  fontSize: 24,

                  // Affiche le message en caractères gras.
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Ajoute un espace vertical de 10 pixels.
              const SizedBox(height: 10),

              // Affiche une courte instruction destinée à l'utilisateur.
              const Text(
                'Connectez-vous pour accéder à votre espace.',

                // Centre le texte horizontalement.
                textAlign: TextAlign.center,
              ),

              // Ajoute un espace vertical de 35 pixels
              // avant le premier champ de saisie.
              const SizedBox(height: 35),

              // TextFormField crée un champ de saisie intégré
              // au système de validation du formulaire.
              // Contrairement à TextField, il possède directement
              // une propriété validator.
              TextFormField(
                // Associe le champ au contrôleur email.
                // Cela permet de récupérer le texte saisi
                // à travers email.text.
                controller: email,

                // Indique au clavier du téléphone qu'il s'agit
                // d'une saisie de type adresse e-mail.
                // Flutter peut ainsi proposer un clavier adapté
                // avec des caractères comme @.
                keyboardType: TextInputType.emailAddress,

                // InputDecoration permet de personnaliser
                // l'apparence du champ de saisie.
                decoration: const InputDecoration(
                  // Texte indicatif affiché comme libellé du champ.
                  labelText: 'Identifiant ou e-mail',

                  // Affiche une icône de personne à gauche du champ.
                  prefixIcon: Icon(Icons.person_outline),

                  // OutlineInputBorder dessine une bordure
                  // rectangulaire autour du champ de saisie.
                  border: OutlineInputBorder(),
                ),

                // validator définit les règles de validation
                // appliquées au contenu du champ.
                // La fonction reçoit la valeur saisie sous forme
                // d'une chaîne nullable.
                // Elle retourne un message d'erreur si la saisie
                // ne respecte pas les règles, sinon elle retourne null.
                validator: (v) {
                  // Première vérification :
                  // on contrôle si la valeur est null ou vide
                  // après suppression des espaces au début et à la fin.
                  if (v == null || v.trim().isEmpty) {
                    // Retourne un message d'erreur si l'utilisateur
                    // n'a pas renseigné son identifiant ou son e-mail.
                    return 'Identifiant obligatoire';
                  }

                  // Deuxième vérification :
                  // on recherche la présence du caractère @ dans la saisie.
                  // Cette condition constitue ici une vérification simple
                  // pour contrôler le format attendu d'une adresse e-mail.
                  if (!v.contains('@')) {
                    // Affiche un message d'erreur si le caractère @
                    // n'est pas présent dans la valeur saisie.
                    return 'Email invalide';
                  }

                  // Si aucune des conditions précédentes n'est vérifiée,
                  // le champ est considéré comme valide.
                  // Retourner null signifie qu'aucune erreur n'est détectée.
                  return null;
                },
              ),

              // Ajoute un espace vertical de 20 pixels
              // entre le champ e-mail et le champ mot de passe.
              const SizedBox(height: 20),

              // Deuxième champ de saisie du formulaire.
              // Il permet à l'utilisateur de renseigner son mot de passe.
              TextFormField(
                // Associe ce champ au contrôleur password.
                // Le texte saisi pourra être récupéré avec password.text.
                controller: password,

                // obscureText: true masque les caractères saisis.
                // Cette propriété permet de protéger visuellement
                // le mot de passe contre une lecture directe à l'écran.
                obscureText: true,

                // Personnalisation de l'apparence du champ.
                decoration: const InputDecoration(
                  // Libellé affiché pour identifier le champ.
                  labelText: 'Mot de passe',

                  // Icône de cadenas placée à gauche du champ.
                  prefixIcon: Icon(Icons.lock_outline),

                  // Ajoute une bordure rectangulaire au champ.
                  border: OutlineInputBorder(),
                ),

                // Fonction de validation du mot de passe.
                // Elle reçoit la valeur saisie et vérifie
                // qu'elle respecte les conditions définies.
                validator: (v) {
                  // Première vérification :
                  // le mot de passe ne doit être ni null ni vide.
                  if (v == null || v.isEmpty) {
                    // Retourne un message lorsque le champ est vide.
                    return 'Mot de passe obligatoire';
                  }

                  // Deuxième vérification :
                  // on contrôle la longueur du mot de passe.
                  // length retourne le nombre de caractères de la chaîne.
                  // Ici, le mot de passe doit contenir au minimum 6 caractères.
                  if (v.length < 6) {
                    // Retourne un message si la longueur minimale
                    // n'est pas respectée.
                    return '6 caractères minimum';
                  }

                  // Si toutes les vérifications sont satisfaites,
                  // le champ est considéré comme valide.
                  return null;
                },
              ),

              // Ajoute un espace vertical de 30 pixels
              // avant le bouton de connexion.
              const SizedBox(height: 30),

              // SizedBox permet de définir les dimensions
              // de l'espace réservé au bouton.
              SizedBox(
                // Fixe la hauteur du bouton à 52 pixels.
                height: 52,

                // FilledButton.icon crée un bouton rempli
                // contenant une icône et un texte.
                child: FilledButton.icon(
                  // onPressed définit l'action exécutée
                  // lorsque l'utilisateur appuie sur le bouton.
                  // La fonction anonyme permet d'écrire directement
                  // les instructions à exécuter lors du clic.
                  onPressed: () {
                    // Déclenche la validation de tous les champs
                    // associés au formulaire identifié par formKey.
                    // validate() exécute les fonctions validator
                    // de chaque TextFormField.
                    // Le point d'exclamation après currentState indique
                    // à Dart que nous considérons cette valeur comme non nulle.
                    if (formKey.currentState!.validate()) {
                      // Si tous les champs sont valides,
                      // nous affichons un message temporaire à l'utilisateur.
                      // ScaffoldMessenger permet d'accéder au gestionnaire
                      // des messages temporaires de l'application.
                      ScaffoldMessenger.of(context).showSnackBar(
                        // SnackBar affiche une notification temporaire
                        // généralement située en bas de l'écran.
                        const SnackBar(
                          // Contenu textuel du message affiché.
                          // Ce message indique que la connexion est simulée.
                          content: Text('Connexion simulée'),
                        ),
                      );
                    }
                  },

                  // Icône affichée à gauche du texte du bouton.
                  // Icons.login représente une action de connexion.
                  icon: const Icon(Icons.login),

                  // Texte affiché sur le bouton.
                  label: const Text('Se connecter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

