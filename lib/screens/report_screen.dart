// Dr Papa Samour DIOP – Enseignant du cours
// Ce fichier définit l'écran de création d'un nouveau signalement.
// Il permet à l'utilisateur de renseigner les informations d'un incident,
// de sélectionner une image depuis la galerie ou la caméra,
// puis d'enregistrer le signalement localement.

// Importation de dart:io.
// Cette bibliothèque permet notamment de manipuler les fichiers locaux.
// Elle est utilisée ici pour afficher l'image sélectionnée avec File.
import 'dart:io';

// Importation de la bibliothèque Material de Flutter.
// Elle fournit les composants graphiques utilisés dans l'interface.
import 'package:flutter/material.dart';

// Importation de Flutter Riverpod.
// Cette bibliothèque permet d'accéder aux données et de gérer leur état.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Importation de GoRouter.
// Cette bibliothèque permet de naviguer entre les différents écrans.
import 'package:go_router/go_router.dart';

// Importation du plugin image_picker.
// Il permet de sélectionner une image depuis la galerie
// ou de prendre une nouvelle photo avec la caméra.
import 'package:image_picker/image_picker.dart';

// Importation du provider qui gère les incidents enregistrés localement.
import '../providers/local_incidents_provider.dart';

// Déclaration de ReportScreen comme ConsumerStatefulWidget.
// ConsumerStatefulWidget combine la gestion d'un état local
// avec la possibilité d'utiliser les providers Riverpod.
// Il convient ici car l'écran gère des données susceptibles de changer,
// comme les champs du formulaire et l'image sélectionnée.
class ReportScreen extends ConsumerStatefulWidget {
  // Constructeur de ReportScreen.
  // super.key transmet la clé éventuelle au constructeur parent.
  const ReportScreen({super.key});

  // Création de l'objet State associé à ce widget.
  // Cet objet contient les variables et les méthodes
  // qui permettent de gérer le comportement de l'écran.
  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

// Classe qui contient l'état et la logique de l'écran ReportScreen.
// ConsumerState donne accès à ref pour interagir avec Riverpod,
// ainsi qu'à setState pour actualiser l'interface.
class _ReportScreenState extends ConsumerState<ReportScreen> {
  // Gestion du formulaire.
  // GlobalKey permet d'identifier le formulaire
  // et d'accéder à ses fonctionnalités, notamment la validation.
  final formKey = GlobalKey<FormState>();

  // Contrôleurs des champs de saisie.
  // Ils permettent de récupérer et de manipuler les textes saisis.
  final titre = TextEditingController();
  final description = TextEditingController();
  final lieu = TextEditingController();

  // Création de l'objet ImagePicker.
  // Il sera utilisé pour demander au système
  // de sélectionner une image ou de prendre une photo.
  final ImagePicker imagePicker = ImagePicker();

  // Stockage de l'image sélectionnée.
  // XFile représente un fichier obtenu à partir du plugin image_picker.
  // Le symbole ? indique que cette variable peut ne contenir aucune image.
  XFile? selectedImage;

  // Indique si une opération de sélection d'image est en cours.
  // Cette variable permet notamment d'éviter plusieurs sélections simultanées.
  bool isPickingImage = false;

  // Méthode appelée lorsque le widget est retiré définitivement de l'arbre.
  // Elle permet de libérer les ressources utilisées par les contrôleurs.
  @override
  void dispose() {
    // Libération des ressources du contrôleur du titre.
    titre.dispose();

    // Libération des ressources du contrôleur de la description.
    description.dispose();

    // Libération des ressources du contrôleur du lieu.
    lieu.dispose();

    // Appel de la méthode dispose de la classe parente.
    super.dispose();
  }

  // Retour vers la page d'accueil.
  void goBack() {
    // context.go() demande à GoRouter de naviguer
    // vers la route correspondant à l'écran d'accueil.
    context.go('/home');
  }

  // Méthode asynchrone permettant de sélectionner une image.
  // Le paramètre source précise l'origine de l'image :
  // ImageSource.gallery pour la galerie ou ImageSource.camera pour la caméra.
  // Future<void> indique que cette méthode réalise une opération asynchrone
  // sans retourner de valeur exploitable.
  Future<void> pickImage(ImageSource source) async {
    // Si une sélection est déjà en cours, on quitte immédiatement la méthode.
    // Cela évite de lancer plusieurs opérations simultanément.
    if (isPickingImage) return;

    // setState signale à Flutter qu'une variable de l'état change.
    // L'interface sera reconstruite pour refléter ce changement.
    setState(() {
      isPickingImage = true;
    });

    // try permet d'exécuter une opération susceptible de provoquer une erreur.
    // Les éventuelles exceptions seront traitées dans le bloc catch.
    try {
      // Demande au plugin image_picker de récupérer une image.
      // await attend la fin de l'opération avant de poursuivre l'exécution.
      final XFile? image = await imagePicker.pickImage(
        // Détermine la source de l'image : galerie ou caméra.
        source: source,

        // Réduit la qualité de l'image à 80 %.
        // Cela permet de limiter la taille du fichier obtenu.
        imageQuality: 80,

        // Définit la largeur maximale souhaitée de l'image.
        maxWidth: 1600,

        // Définit la hauteur maximale souhaitée de l'image.
        maxHeight: 1600,
      );

      // Vérifie que le widget est toujours présent dans l'arbre Flutter.
      // Cette vérification est importante après une opération asynchrone
      // avant d'utiliser le contexte ou de modifier l'état.
      if (!mounted) return;

      // Vérifie qu'une image a effectivement été sélectionnée.
      // Si l'utilisateur annule l'opération, image reste null.
      if (image != null) {
        // Mise à jour de l'image sélectionnée.
        // setState demande à Flutter de reconstruire l'interface
        // afin d'afficher l'aperçu de la nouvelle image.
        setState(() {
          selectedImage = image;
        });
      }

      // catch intercepte les erreurs qui peuvent survenir
      // pendant la sélection ou le chargement de l'image.
    } catch (e, stackTrace) {
      // Affiche le message d'erreur dans la console de développement.
      debugPrint('Erreur image_picker : $e');

      // Affiche également la trace technique de l'erreur.
      // Elle aide à identifier l'origine du problème.
      debugPrintStack(stackTrace: stackTrace);

      // Vérifie que l'écran existe toujours avant d'afficher un message.
      if (!mounted) return;

      // Récupération du gestionnaire de messages de l'application.
      // Il permet d'afficher une notification temporaire à l'utilisateur.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // Message présenté à l'utilisateur en cas d'échec.
          content: Text(
            'Impossible d’ouvrir les images. '
            'Vérifiez l’installation du plugin : $e',
          ),

          // Durée d'affichage de la notification : cinq secondes.
          duration: const Duration(seconds: 5),
        ),
      );

      // finally est exécuté après try et catch,
      // que l'opération ait réussi ou qu'une erreur soit survenue.
    } finally {
      // Vérifie que le widget existe toujours avant de modifier son état.
      if (mounted) {
        // Termine l'indication de chargement.
        // L'interface peut alors réactiver le bouton de sélection.
        setState(() {
          isPickingImage = false;
        });
      }
    }
  }

  // Méthode qui affiche les différentes possibilités
  // de sélection d'une image dans une fenêtre inférieure.
  void showImageOptions() {
    // showModalBottomSheet affiche un panneau qui apparaît
    // depuis le bas de l'écran.
    showModalBottomSheet(
      context: context,

      // builder construit le contenu du panneau.
      // bottomSheetContext représente le contexte propre à ce panneau.
      builder: (bottomSheetContext) {
        // SafeArea évite que le contenu soit masqué
        // par les zones système de l'appareil.
        return SafeArea(
          // Wrap organise les éléments et permet leur retour à la ligne
          // si l'espace disponible est insuffisant.
          child: Wrap(
            children: [
              // Première option : sélectionner une image dans la galerie.
              ListTile(
                // Icône représentant la galerie de photos.
                leading: const Icon(Icons.photo_library_outlined),

                // Texte descriptif de l'option.
                title: const Text('Choisir depuis la galerie'),

                // Action exécutée lorsque l'utilisateur sélectionne cette option.
                onTap: () {
                  // Ferme le panneau de sélection.
                  Navigator.pop(bottomSheetContext);

                  // Lance la sélection d'une image depuis la galerie.
                  pickImage(ImageSource.gallery);
                },
              ),

              // Deuxième option : prendre une nouvelle photo.
              ListTile(
                // Icône représentant la caméra.
                leading: const Icon(Icons.camera_alt_outlined),

                // Texte descriptif de l'option.
                title: const Text('Prendre une photo'),

                // Action exécutée lorsque l'utilisateur sélectionne cette option.
                onTap: () {
                  // Ferme le panneau de sélection.
                  Navigator.pop(bottomSheetContext);

                  // Lance la caméra de l'appareil.
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Méthode permettant de supprimer l'image actuellement sélectionnée.
  void removeImage() {
    // Remplace la référence de l'image sélectionnée par null.
    // setState déclenche la reconstruction de l'interface :
    // l'aperçu de l'image disparaît alors de l'écran.
    setState(() {
      selectedImage = null;
    });
  }

  // Méthode chargée de valider le formulaire
  // et d'enregistrer localement les informations du signalement.
  void submit() {
    // Déclenche la validation de tous les champs du formulaire.
    // Si au moins un champ est invalide, la méthode s'arrête immédiatement.
    if (!formKey.currentState!.validate()) return;

    // Enregistrement local avec Riverpod.
    // ref.read() permet d'accéder au provider sans établir
    // une surveillance de ses changements dans cette méthode.
    // notifier donne accès à l'objet chargé de modifier son état.
    // add() ajoute un nouvel incident à partir des informations saisies.
    ref
        .read(localIncidentsProvider.notifier)
        .add(
          // trim() supprime les espaces inutiles au début et à la fin du titre.
          titre: titre.text.trim(),

          // Récupération de la description sans espaces périphériques.
          description: description.text.trim(),

          // Récupération du lieu sans espaces périphériques.
          lieu: lieu.text.trim(),
        );

    // Retour vers la page d'accueil après l'enregistrement.
    context.go('/home');
  }

  // Construction de l'interface graphique de l'écran.
  // WidgetRef ref permet également d'interagir avec les providers Riverpod.
  @override
  Widget build(BuildContext context) {
    // Scaffold définit la structure générale de la page.
    return Scaffold(
      // AppBar représente la barre supérieure de l'écran.
      appBar: AppBar(
        // Bouton de retour avec une icône discrète et visible.
        // Padding ajoute un espace à gauche du bouton.
        leading: Padding(
          // Définition d'une marge intérieure de 8 pixels à gauche.
          padding: const EdgeInsets.only(left: 8),

          // IconButton crée un bouton contenant une icône.
          child: IconButton(
            // Au clic, exécute la méthode goBack().
            onPressed: goBack,

            // Texte d'aide associé au bouton.
            tooltip: 'Retour à l’accueil',

            // Icône représentant le retour en arrière.
            icon: const Icon(Icons.arrow_back_rounded, size: 26),

            // Personnalisation de l'apparence du bouton.
            style: IconButton.styleFrom(
              // Couleur de fond récupérée à partir du thème actif.
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,

              // Forme circulaire du bouton.
              shape: const CircleBorder(),

              // Couleur de l'icône adaptée à la couleur de surface du thème.
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),

        // Titre affiché dans la barre supérieure.
        title: const Text('Nouveau signalement'),
      ),

      // SingleChildScrollView permet de faire défiler le contenu
      // lorsque sa hauteur dépasse l'espace disponible à l'écran.
      body: SingleChildScrollView(
        // Padding définit les marges intérieures du contenu.
        child: Padding(
          padding: const EdgeInsets.all(20),

          // Form regroupe les champs de saisie
          // et permet de gérer leur validation.
          child: Form(
            // Association de la clé au formulaire.
            // Elle permet d'appeler validate() lors de la soumission.
            key: formKey,

            // Column organise verticalement tous les éléments du formulaire.
            child: Column(
              // Les champs et les boutons occupent la largeur disponible.
              crossAxisAlignment: CrossAxisAlignment.stretch,

              // Liste des widgets constituant le formulaire.
              children: [
                // Champ de saisie du titre du signalement.
                TextFormField(
                  // Association du contrôleur au champ.
                  // Il permet de récupérer le texte saisi.
                  controller: titre,

                  // Configuration de l'apparence du champ.
                  decoration: const InputDecoration(
                    // Libellé affiché au-dessus ou dans le champ.
                    labelText: 'Titre du signalement',

                    // Exemple indicatif affiché lorsque le champ est vide.
                    hintText: 'Ex : Nid de poule dangereux',

                    // Bordure rectangulaire autour du champ.
                    border: OutlineInputBorder(),
                  ),

                  // validator vérifie la validité du contenu saisi.
                  // Il retourne un message si la saisie est incorrecte,
                  // ou null si la valeur est acceptée.
                  validator: (value) {
                    // Vérifie que la valeur existe et qu'elle
                    // ne contient pas uniquement des espaces.
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer un titre.';
                    }

                    // null signifie que la validation du champ est réussie.
                    return null;
                  },
                ),

                // Espace vertical de 20 pixels entre les champs.
                const SizedBox(height: 20),

                // Champ de saisie de la description détaillée.
                TextFormField(
                  // Association du contrôleur de description.
                  controller: description,

                  // Le champ peut afficher jusqu'à quatre lignes.
                  maxLines: 4,

                  // Configuration de l'apparence du champ.
                  decoration: const InputDecoration(
                    // Libellé du champ.
                    labelText: 'Description détaillée',

                    // Texte indicatif destiné à guider l'utilisateur.
                    hintText: 'Donnez plus de détails sur le problème...',

                    // Définition de la bordure.
                    border: OutlineInputBorder(),

                    // Aligne le libellé avec le début du texte multiligne.
                    alignLabelWithHint: true,
                  ),

                  // Vérification de la description saisie.
                  validator: (value) {
                    // Une description vide ou composée uniquement d'espaces
                    // est considérée comme invalide.
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer une description.';
                    }

                    // La valeur est acceptée si aucune erreur n'est détectée.
                    return null;
                  },
                ),

                // Espace vertical de 20 pixels.
                const SizedBox(height: 20),

                // Champ de saisie du lieu de l'incident.
                TextFormField(
                  // Association du contrôleur du lieu.
                  controller: lieu,

                  // Configuration de l'apparence du champ.
                  decoration: const InputDecoration(
                    // Libellé du champ.
                    labelText: 'Lieu du signalement',

                    // Exemple de localisation.
                    hintText: 'Ex : VDN, Dakar',

                    // Bordure du champ.
                    border: OutlineInputBorder(),
                  ),

                  // Validation de la localisation.
                  validator: (value) {
                    // Vérifie que l'utilisateur a renseigné un lieu.
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer un lieu.';
                    }

                    // La validation réussit si le champ est renseigné.
                    return null;
                  },
                ),

                // Espace vertical avant le bouton d'ajout d'image.
                const SizedBox(height: 20),

                // Bouton permettant de choisir une image.
                // OutlinedButton.icon associe une icône et un texte
                // dans un bouton avec une bordure.
                OutlinedButton.icon(
                  // Si une sélection est en cours, le bouton est désactivé.
                  // Sinon, il affiche les options de sélection d'image.
                  onPressed: isPickingImage ? null : showImageOptions,

                  // L'icône change selon l'état de la sélection.
                  // Un indicateur de chargement est affiché pendant l'opération.
                  icon: isPickingImage
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          // CircularProgressIndicator indique qu'une opération est en cours.
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      // Icône affichée lorsque le bouton est disponible.
                      : const Icon(Icons.camera_alt_outlined),

                  // Le texte du bouton dépend également de l'état de sélection.
                  label: Text(
                    isPickingImage
                        ? 'Ouverture en cours...'
                        : 'Ajouter une photo',
                  ),

                  // Personnalisation de l'apparence du bouton.
                  style: OutlinedButton.styleFrom(
                    // Hauteur minimale de 50 pixels.
                    minimumSize: const Size.fromHeight(50),

                    // Alignement du contenu sur la gauche.
                    alignment: Alignment.centerLeft,

                    // Espacement intérieur horizontal de 16 pixels.
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                // Affichage conditionnel de l'aperçu de l'image.
                // Cette partie est construite uniquement
                // lorsqu'une image a été sélectionnée.
                // L'opérateur ... permet d'insérer plusieurs widgets
                // dans la liste children.
                if (selectedImage != null) ...[
                  // Espace vertical avant l'aperçu.
                  const SizedBox(height: 16),

                  // ClipRRect applique des coins arrondis au contenu.
                  ClipRRect(
                    // Rayon de courbure de 12 pixels.
                    borderRadius: BorderRadius.circular(12),

                    // Stack permet de superposer plusieurs widgets.
                    // Ici, le bouton de suppression est placé sur l'image.
                    child: Stack(
                      children: [
                        // Image.file affiche une image enregistrée localement.
                        // File récupère le fichier à partir du chemin fourni
                        // par le plugin image_picker.
                        Image.file(
                          File(selectedImage!.path),

                          // L'image occupe toute la largeur disponible.
                          width: double.infinity,

                          // Hauteur de l'aperçu : 200 pixels.
                          height: 200,

                          // L'image est adaptée à l'espace disponible.
                          // Une partie peut être coupée pour remplir le cadre.
                          fit: BoxFit.cover,
                        ),

                        // Positioned permet de placer un widget
                        // à un emplacement précis dans un Stack.
                        // Ici, il positionne le bouton en haut à droite.
                        Positioned(
                          top: 10,
                          right: 10,

                          // Bouton permettant de supprimer l'image sélectionnée.
                          child: IconButton(
                            // Exécute la méthode removeImage() au clic.
                            onPressed: removeImage,

                            // Icône de suppression.
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),

                            // Texte d'aide du bouton.
                            tooltip: 'Supprimer la photo',

                            // Personnalisation de l'arrière-plan du bouton.
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Espace vertical avant le bouton d'enregistrement.
                const SizedBox(height: 30),

                // Bouton principal permettant de soumettre le formulaire.
                // FilledButton.icon affiche un bouton rempli
                // contenant une icône et un libellé.
                FilledButton.icon(
                  // Appelle la méthode submit() lorsque l'utilisateur appuie.
                  onPressed: submit,

                  // Icône représentant l'envoi du signalement.
                  icon: const Icon(Icons.send),

                  // Texte affiché sur le bouton.
                  label: const Text('Ajouter localement'),

                  // Personnalisation du bouton.
                  style: FilledButton.styleFrom(
                    // Hauteur minimale de 50 pixels.
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
