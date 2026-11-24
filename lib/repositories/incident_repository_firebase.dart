import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/incident_model.dart';

// Un repository isole le SDK Firebase de la présentation.
class IncidentRepositoryFirebase {
  IncidentRepositoryFirebase(this._db, this._storage, this._auth);
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  Future<void> deleteIncident(String incidentId) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('Connexion obligatoire.');
    // Les règles Firestore vérifient également la propriété du document.
    final document = _db.collection('incidents').doc(incidentId);
    final snapshot = await document.get();
    if (!snapshot.exists || snapshot.data()?['userId'] != user.uid) {
      throw StateError('Signalement introuvable ou accès refusé.');
    }
    await document.delete();
    // La suppression du fichier Storage relève ici d'un nettoyage séparé.
  }

  Stream<List<Incident>> watchIncidents() => _db
      .collection('incidents')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(Incident.fromFirestore).toList());

  Future<void> addIncident({
    required String titre,
    required String description,
    required String lieu,
    XFile? image,
    double? latitude,
    double? longitude,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('Connexion obligatoire.');
    final reference = _db.collection('incidents').doc();
    String imageUrl = '';
    Reference? uploaded;
    if (image != null) {
      final bytes = await image.readAsBytes();
      if (bytes.isEmpty || bytes.length > 5 * 1024 * 1024) {
        throw StateError('Photo vide ou supérieure à 5 Mo.');
      }
      final ext = image.name.toLowerCase().split('.').last;
      const valid = {
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
        'webp': 'image/webp',
      };
      final mime = valid[ext];
      if (mime == null) throw StateError('Format JPG, PNG ou WEBP requis.');
      // Même code pour Android, iOS et Web : putData, pas putFile.
      uploaded = _storage.ref('incidents/${user.uid}/${reference.id}.$ext');
      await uploaded.putData(bytes, SettableMetadata(contentType: mime));
      imageUrl = await uploaded.getDownloadURL();
    }
    try {
      await reference.set({
        'titre': titre.trim(),
        'description': description.trim(),
        'lieu': lieu.trim(),
        'imageUrl': imageUrl,
        'userId': user.uid,
        'statut': 'Nouveau',
        'createdAt': FieldValue.serverTimestamp(),
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
      });
    } catch (_) {
      // Une erreur d'écriture ne doit pas laisser une photo orpheline.
      if (uploaded != null) {
        try {
          await uploaded.delete();
        } catch (_) {
          /* journaliser en production */
        }
      }
      rethrow;
    }
  }
}
