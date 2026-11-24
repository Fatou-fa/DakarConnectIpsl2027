import 'package:cloud_firestore/cloud_firestore.dart';

class Incident {
  final String id, titre, description, lieu, imageUrl;
  final DateTime date;
  final String? userId;
  const Incident({
    required this.id,
    required this.titre,
    required this.description,
    required this.lieu,
    this.imageUrl = '',
    required this.date,
    this.userId,
  });
  factory Incident.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    final timestamp = d['createdAt'];
    return Incident(
      id: doc.id,
      titre: (d['titre'] ?? '').toString(),
      description: (d['description'] ?? '').toString(),
      lieu: (d['lieu'] ?? '').toString(),
      imageUrl: (d['imageUrl'] ?? '').toString(),
      date: timestamp is Timestamp ? timestamp.toDate() : DateTime.now(),
      userId: d['userId']?.toString(),
    );
  }
}
