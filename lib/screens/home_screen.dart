import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/incidents_firebase_provider.dart';
import '../repositories/auth_repository.dart';
import '../widgets/incident_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incidents = ref.watch(incidentsFirebaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signalements — Firestore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
          ),
        ],
      ),
      body: incidents.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur Firestore : $e')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('Aucun signalement'))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) => IncidentCard(incident: items[i]),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/report'),
        icon: const Icon(Icons.add),
        label: const Text('Signaler'),
      ),
    );
  }
}
