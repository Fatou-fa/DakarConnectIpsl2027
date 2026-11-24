import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/incident_model.dart';
import '../repositories/incident_repository_firebase.dart';

final incidentRepositoryFirebaseProvider = Provider<IncidentRepositoryFirebase>(
  (_) => IncidentRepositoryFirebase(
    FirebaseFirestore.instance,
    FirebaseStorage.instance,
    FirebaseAuth.instance,
  ),
);

// AsyncValue distingue les états chargement, données et erreur.
final incidentsFirebaseProvider = StreamProvider<List<Incident>>(
  (ref) => ref.watch(incidentRepositoryFirebaseProvider).watchIncidents(),
);
