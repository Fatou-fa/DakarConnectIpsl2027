import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/local_incidents_provider.dart';
import '../widgets/incident_card.dart';

// Dr Papa Samour DIOP – Enseignant du cours
// ConsumerWidget permet à cet écran d'accéder aux providers Riverpod
// grâce à l'objet WidgetRef, sans avoir besoin d'un StatefulWidget.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() observe le provider des signalements locaux.
    // Lorsque la liste change, Flutter reconstruit automatiquement cet écran.
    final incidents = ref.watch(localIncidentsProvider);

    // Scaffold fournit la structure générale de la page :
    // barre supérieure, contenu principal et bouton d'action flottant.
    return Scaffold(
      appBar: AppBar(
        // Titre affiché dans la barre supérieure de l'application.
        title: const Text('Signalements récents'),

        // actions permet de placer des boutons à droite de l'AppBar.
        actions: [
          IconButton(
            // context.go() utilise GoRouter pour naviguer vers la route /login.
            onPressed: () => context.go('/login'),

            // tooltip affiche une indication lorsque l'utilisateur
            // maintient ou survole le bouton.
            tooltip: 'Mon profil',

            // Icône représentant l'accès au profil de l'utilisateur.
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),

      // Le contenu de la page dépend de la présence de signalements.
      body: incidents.isEmpty
          ? const Center(
              // Si la liste est vide, un message est affiché au centre de l'écran.
              child: Text('Aucun signalement disponible'),
            )
          // Si la liste contient des éléments, ListView.builder
          // construit progressivement les cartes de signalement.
          : ListView.builder(
              // Nombre total de signalements à afficher.
              itemCount: incidents.length,

              // Cette fonction est appelée pour construire chaque élément
              // de la liste à partir de son index.
              itemBuilder: (context, index) {
                // Récupération du signalement correspondant à la position actuelle.
                final incident = incidents[index];

                // IncidentCard présente les informations d'un signalement.
                // Chaque carte reçoit ici l'objet Incident correspondant.
                return IncidentCard(incident: incident);
              },
            ),

      // FloatingActionButton.extended affiche un bouton flottant
      // avec une icône et un texte.
      floatingActionButton: FloatingActionButton.extended(
        // Au clic, l'utilisateur est redirigé vers la page de création
        // d'un nouveau signalement.
        onPressed: () => context.go('/report'),

        // Indication associée au bouton d'action.
        tooltip: 'Créer un signalement',

        // Icône + pour indiquer l'ajout d'un nouveau signalement.
        icon: const Icon(Icons.add),

        // Texte affiché à côté de l'icône.
        label: const Text('Signaler'),
      ),
    );
  }
}
