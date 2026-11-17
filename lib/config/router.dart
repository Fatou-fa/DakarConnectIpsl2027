import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/report_screen.dart';

// Dr Papa Samour DIOP – Enseignant du cours
// Provider permet de mettre à disposition une instance de GoRouter
// dans l'application grâce au système de gestion d'état Riverpod.
final routerProvider = Provider<GoRouter>((ref) {
  // Création du routeur principal de l'application.
  // GoRouter centralise la définition des chemins et la navigation.
  final router = GoRouter(
    // Définit la première page affichée lorsque l'application démarre.
    // Ici, l'utilisateur arrive initialement sur la page de connexion.
    initialLocation: '/login',

    // redirect permet de contrôler les déplacements entre les pages.
    // Cette fonction est exécutée lorsque GoRouter doit déterminer
    // si la navigation demandée est autorisée ou doit être redirigée.
    redirect: (context, state) {
      // ref.read() récupère ponctuellement l'état actuel de connexion.
      // Contrairement à ref.watch(), il ne met pas directement en place
      // une surveillance de cet état dans cette instruction.
      final connected = ref.read(authStateProvider);

      // Vérifie si la page demandée correspond à la page de connexion.
      // matchedLocation représente le chemin reconnu par GoRouter.
      final isLoginPage = state.matchedLocation == '/login';

      // Un utilisateur non connecté doit se connecter.
      // Si l'utilisateur n'est pas connecté et demande une autre page,
      // il est automatiquement redirigé vers la page de connexion.
      if (!connected && !isLoginPage) {
        return '/login';
      }

      // Un utilisateur connecté ne doit plus rester
      // sur la page de connexion.
      // Il est alors redirigé vers la page d'accueil.
      if (connected && isLoginPage) {
        return '/home';
      }

      // null signifie qu'aucune redirection supplémentaire n'est nécessaire.
      // La navigation vers la page demandée peut donc continuer.
      return null;
    },

    // routes regroupe les différentes pages accessibles dans l'application.
    // Chaque GoRoute associe un chemin à un widget d'écran.
    routes: [
      // Route de connexion : /login
      GoRoute(
        path: '/login',

        // builder construit le widget correspondant à cette route.
        // const permet de créer le widget avec un constructeur constant.
        builder: (context, state) => const LoginScreen(),
      ),

      // Route de la page d'accueil : /home
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

      // Route de création d'un signalement : /report
      GoRoute(path: '/report', builder: (context, state) => ReportScreen()),
    ],
  );

  // ref.listen() permet d'écouter les changements de l'état de connexion.
  // Contrairement à ref.watch(), cette méthode exécute un callback
  // lorsqu'une nouvelle valeur est émise par le provider.
  ref.listen<bool>(authStateProvider, (previous, next) {
    // router.refresh() demande à GoRouter de réévaluer ses redirections.
    // Ainsi, après une connexion ou une déconnexion, les règles définies
    // dans redirect sont réexaminées.
    router.refresh();
  });

  // ref.onDispose() enregistre une opération à exécuter
  // lorsque le provider est détruit ou libéré.
  // Cela permet d'éviter de conserver inutilement les ressources du routeur.
  ref.onDispose(() {
    router.dispose();
  });

  // Retourne l'instance du routeur afin qu'elle soit utilisée
  // par le reste de l'application.
  return router;
});
