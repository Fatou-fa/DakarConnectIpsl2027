import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dr Papa Samour DIOP – Enseignant du cours
// AuthStateNotifier est une classe de gestion d'état basée sur Riverpod.
// Elle permet de gérer l'état de connexion de l'utilisateur.
// Le type bool indique que cet état peut prendre deux valeurs :
// true (connecté) ou false (non connecté).
class AuthStateNotifier extends Notifier<bool> {
  // build() initialise l'état du provider.
  // Cette méthode est exécutée lors de la première création du notifier.
  @override
  bool build() {
    // false signifie qu'aucun utilisateur n'est considéré comme connecté
    // au démarrage de l'application.
    return false;
  }

  // Simule une connexion réussie.
  // Cette méthode modifie l'état de connexion en lui attribuant true.
  void login() {
    // state représente la valeur actuelle gérée par Riverpod.
    // En passant à true, l'application considère l'utilisateur connecté.
    state = true;
  }

  // Déconnecte l'utilisateur.
  // Cette méthode permet de réinitialiser l'état de connexion.
  void logout() {
    // En affectant false à state, l'application considère
    // que l'utilisateur n'est plus connecté.
    state = false;
  }
}

// NotifierProvider établit le lien entre le notifier et son état.
// AuthStateNotifier.new permet à Riverpod de créer une instance du notifier.
// Le type bool précise que le provider expose un état de type bool.
final authStateProvider = NotifierProvider<AuthStateNotifier, bool>(
  AuthStateNotifier.new,
);
