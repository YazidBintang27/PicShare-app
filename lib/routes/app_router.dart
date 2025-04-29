import 'package:go_router/go_router.dart';
import 'package:picshare_app/presentation/pages/detail_picture.dart';
import 'package:picshare_app/presentation/pages/login.dart';
import 'package:picshare_app/presentation/pages/main.dart';
import 'package:picshare_app/presentation/pages/onboarding.dart';
import 'package:picshare_app/presentation/pages/register.dart';
import 'package:picshare_app/presentation/pages/splash.dart';

class AppRouter {
  static final GoRouter router = GoRouter(initialLocation: '/splash', routes: [
    GoRoute(path: '/splash', builder: (context, state) => const Splash()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnBoarding(),
    ),
    GoRoute(path: '/register', builder: (context, state) => const Register()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/main', builder: (context, state) => const Main()),
    GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailPicture(id: id);
        }),
  ]);
}
