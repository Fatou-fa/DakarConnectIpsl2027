import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/incidents_firebase_provider.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});
  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final formKey = GlobalKey<FormState>();
  final titre = TextEditingController();
  final description = TextEditingController();
  final lieu = TextEditingController();
  XFile? photo;
  bool busy = false;
  @override
  void dispose() {
    titre.dispose();
    description.dispose();
    lieu.dispose();
    super.dispose();
  }

  Future<void> choosePhoto() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (result != null && mounted) setState(() => photo = result);
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => busy = true);
    try {
      await ref
          .read(incidentRepositoryFirebaseProvider)
          .addIncident(
            titre: titre.text,
            description: description.text,
            lieu: lieu.text,
            image: photo,
          );
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Envoi impossible : $e')));
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Nouveau signalement')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titre,
              decoration: const InputDecoration(labelText: 'Titre'),
              validator: (v) =>
                  (v?.trim().isNotEmpty ?? false) ? null : 'Titre requis',
            ),
            TextFormField(
              controller: description,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) => (v?.trim().isNotEmpty ?? false)
                  ? null
                  : 'Description requise',
            ),
            TextFormField(
              controller: lieu,
              decoration: const InputDecoration(labelText: 'Lieu'),
              validator: (v) =>
                  (v?.trim().isNotEmpty ?? false) ? null : 'Lieu requis',
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: choosePhoto,
              icon: const Icon(Icons.photo),
              label: Text(
                photo == null ? 'Choisir une photo' : 'Photo sélectionnée',
              ),
            ),
            const SizedBox(height: 16),
            if (busy)
              const CircularProgressIndicator()
            else
              FilledButton(onPressed: submit, child: const Text('Envoyer')),
          ],
        ),
      ),
    ),
  );
}
