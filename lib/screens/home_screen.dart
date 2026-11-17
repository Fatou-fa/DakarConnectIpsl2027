import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/local_incidents_provider.dart';
import '../widgets/incident_card.dart';

// Dr Papa Samour DIOP – Enseignant du cours
// ConsumerWidget permet à cet écran d'accéder aux providers Riverpod.
// Il est utilisé ici pour récupérer et observer la liste des signalements.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() observe les données exposées par localIncidentsProvider.
    // Lorsque la liste des signalements change, Flutter reconstruit
    // automatiquement cet écran pour actualiser les informations affichées.
    final incidents = ref.watch(localIncidentsProvider);

    // Scaffold définit la structure générale de la page.
    // Il permet notamment d'organiser la barre supérieure,
    // le contenu principal et le bouton d'action flottant.
    return Scaffold(
      // AppBar représente la barre supérieure de l'application.
      appBar: AppBar(
        // Titre affiché dans la barre supérieure.
        title: const Text('Signalements récents'),

        // actions permet de placer des boutons à droite de l'AppBar.
        actions: [
          // IconButton crée un bouton composé d'une icône.
          IconButton(
            // context.go() utilise GoRouter pour naviguer vers la route /login.
            onPressed: () => context.go('/login'),

            // Texte indicatif associé au bouton.
            tooltip: 'Mon profil',

            // Icône représentant l'accès au profil utilisateur.
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),

      // body représente la zone principale de l'écran.
      // L'affichage dépend du nombre de signalements disponibles.
      body: incidents.isEmpty
          // Si la liste est vide, un message est affiché au centre de la page.
          ? const Center(child: Text('Aucun signalement disponible'))
          // Si la liste contient des signalements, ListView.builder
          // construit progressivement les éléments à afficher.
          : ListView.builder(
              // itemCount définit le nombre total d'éléments de la liste.
              itemCount: incidents.length,

              // itemBuilder construit chaque élément à partir de son index.
              // L'index représente la position de l'élément dans la liste.
              itemBuilder: (context, index) {
                // Récupération du signalement correspondant à la position actuelle.
                final incident = incidents[index];

                // IncidentCard est un widget réutilisable chargé de présenter
                // les informations d'un signalement.
                // L'objet incident est transmis au widget à travers son paramètre.
                return IncidentCard(incident: incident);
              },
            ),

      // FloatingActionButton.extended crée un bouton flottant
      // comportant une icône et un texte.
      floatingActionButton: FloatingActionButton.extended(
        // Au clic, l'utilisateur est redirigé vers la page de création
        // d'un nouveau signalement.
        onPressed: () => context.go('/report'),

        // Indication associée au bouton.
        tooltip: 'Créer un signalement',

        // Icône représentant l'ajout d'un nouvel élément.
        icon: const Icon(Icons.add),

        // Libellé affiché à côté de l'icône.
        label: const Text('Signaler'),
      ),
    );
  }
}
