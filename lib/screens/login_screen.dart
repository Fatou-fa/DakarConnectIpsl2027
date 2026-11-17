import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

// Dr Papa Samour DIOP – Enseignant du cours
// ConsumerStatefulWidget combine deux mécanismes :
// - la gestion d'un état local avec StatefulWidget ;
// - l'accès aux providers Riverpod avec Consumer.
// Ce choix permet de gérer les champs du formulaire et l'authentification.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  // createState() crée l'objet qui contient l'état et le comportement
  // de cette page pendant son cycle de vie.
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

// ConsumerState donne accès à la fois aux fonctionnalités de State
// et à l'objet ref pour interagir avec les providers Riverpod.
class _LoginScreenState extends ConsumerState<LoginScreen> {
  // GlobalKey permet d'identifier le formulaire et d'accéder à son état.
  // Il sera utilisé pour déclencher la validation de tous les champs.
  final formKey = GlobalKey<FormState>();

  // TextEditingController permet de récupérer et de contrôler
  // les valeurs saisies par l'utilisateur dans les champs du formulaire.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // dispose() est appelée lorsque le widget est définitivement supprimé.
  // Elle permet de libérer les ressources utilisées par les contrôleurs.
  @override
  void dispose() {
    // Libération du contrôleur associé au champ identifiant ou e-mail.
    emailController.dispose();

    // Libération du contrôleur associé au champ mot de passe.
    passwordController.dispose();

    // Appel de la méthode dispose() de la classe parente
    // pour terminer correctement le cycle de vie du widget.
    super.dispose();
  }

  // submit() regroupe les opérations exécutées lorsque l'utilisateur
  // appuie sur le bouton de connexion.
  void submit() {
    // validate() exécute les fonctions validator de tous les champs.
    // Si au moins un champ est invalide, la méthode retourne false.
    if (!formKey.currentState!.validate()) {
      // return interrompt immédiatement la méthode.
      // Aucune opération de connexion n'est exécutée si le formulaire
      // contient des informations invalides.
      return;
    }

    // Connexion simulée.
    // ref.read() permet d'accéder ponctuellement au notifier du provider.
    // L'appel à login() modifie l'état d'authentification en true.
    ref.read(authStateProvider.notifier).login();
  }

  // build() décrit l'interface graphique de la page de connexion.
  // Flutter appelle cette méthode pour construire ou reconstruire le widget.
  @override
  Widget build(BuildContext context) {
    // Scaffold fournit la structure générale de la page.
    return Scaffold(
      appBar: AppBar(
        // Titre affiché dans la barre supérieure.
        title: const Text('Connexion'),

        // centerTitle centre horizontalement le titre dans l'AppBar.
        centerTitle: true,
      ),

      // SingleChildScrollView permet de faire défiler le contenu
      // lorsque la hauteur disponible est insuffisante.
      // C'est particulièrement utile lorsque le clavier apparaît.
      body: SingleChildScrollView(
        // Ajoute un espacement intérieur de 24 pixels sur les quatre côtés.
        padding: const EdgeInsets.all(24),

        // Form regroupe les champs de saisie et permet leur validation.
        child: Form(
          // Associe le formulaire à la clé déclarée dans la classe.
          key: formKey,

          // Column organise les éléments verticalement.
          child: Column(
            // Chaque enfant occupe autant que possible
            // la largeur disponible dans la colonne.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ajoute un espace vertical de 30 pixels.
              const SizedBox(height: 30),

              // Icône illustrant l'espace de connexion utilisateur.
              const Icon(
                Icons.account_circle_outlined,
                size: 85,
                color: Colors.blue,
              ),

              // Espacement vertical de 20 pixels.
              const SizedBox(height: 20),

              // Message d'accueil affiché au-dessus du formulaire.
              const Text(
                'Bienvenue !',

                // Centre horizontalement le texte.
                textAlign: TextAlign.center,

                // Définit la taille et l'épaisseur de la police.
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Espacement vertical de 10 pixels.
              const SizedBox(height: 10),

              // Texte qui explique l'objectif de la page.
              const Text(
                'Connectez-vous pour accéder à votre espace.',

                // Centre le texte horizontalement.
                textAlign: TextAlign.center,
              ),

              // Espacement entre le texte d'accueil et le formulaire.
              const SizedBox(height: 35),

              // TextFormField permet de saisir une information
              // tout en bénéficiant du mécanisme de validation de Form.
              TextFormField(
                // Associe le champ au contrôleur de l'identifiant.
                controller: emailController,

                // Affiche un clavier adapté à la saisie d'une adresse e-mail.
                keyboardType: TextInputType.emailAddress,

                // InputDecoration définit la présentation visuelle du champ.
                decoration: const InputDecoration(
                  // Texte indicatif affiché comme libellé du champ.
                  labelText: 'Identifiant ou e-mail',

                  // Icône affichée à gauche du champ.
                  prefixIcon: Icon(Icons.person_outline),

                  // Ajoute une bordure rectangulaire au champ.
                  border: OutlineInputBorder(),
                ),

                // validator reçoit la valeur saisie et vérifie sa validité.
                validator: (value) {
                  // Vérifie si la valeur est nulle ou ne contient
                  // que des espaces après suppression des espaces périphériques.
                  if (value == null || value.trim().isEmpty) {
                    return 'Identifiant obligatoire';
                  }

                  // null signifie que la validation du champ est réussie.
                  return null;
                },
              ),

              // Espacement vertical de 20 pixels entre les deux champs.
              const SizedBox(height: 20),

              // Deuxième champ du formulaire : saisie du mot de passe.
              TextFormField(
                // Associe le champ au contrôleur du mot de passe.
                controller: passwordController,

                // Masque les caractères saisis pour protéger
                // visuellement le mot de passe.
                obscureText: true,

                // Définit la présentation du champ.
                decoration: const InputDecoration(
                  // Libellé du champ.
                  labelText: 'Mot de passe',

                  // Icône représentant un cadenas.
                  prefixIcon: Icon(Icons.lock_outline),

                  // Bordure du champ de saisie.
                  border: OutlineInputBorder(),
                ),

                // Fonction chargée de vérifier la validité du mot de passe.
                validator: (value) {
                  // Vérifie si aucune valeur n'a été saisie.
                  if (value == null || value.isEmpty) {
                    return 'Mot de passe obligatoire';
                  }

                  // Vérifie que le mot de passe contient au moins 6 caractères.
                  if (value.length < 6) {
                    return '6 caractères minimum';
                  }

                  // Retourne null lorsque les conditions de validation
                  // définies dans ce champ sont satisfaites.
                  return null;
                },
              ),

              // Espacement vertical de 30 pixels avant le bouton.
              const SizedBox(height: 30),

              // SizedBox impose une hauteur de 52 pixels au bouton.
              SizedBox(
                height: 52,

                // FilledButton.icon crée un bouton avec un fond,
                // une icône et un libellé.
                child: FilledButton.icon(
                  // Déclenche la méthode submit() lorsque l'utilisateur clique.
                  onPressed: submit,

                  // Icône symbolisant l'action de connexion.
                  icon: const Icon(Icons.login),

                  // Texte affiché sur le bouton.
                  label: const Text('Se connecter'),
                ),
              ),

              // Espacement vertical de 20 pixels.
              const SizedBox(height: 20),

              // Message informant l'utilisateur des limites
              // du mécanisme de connexion utilisé dans cette démonstration.
              const Text(
                'Mode démonstration : aucune vérification '
                'des identifiants auprès d’un serveur.',

                // Centre le message.
                textAlign: TextAlign.center,

                // Définit une couleur grise et une petite taille de police.
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
