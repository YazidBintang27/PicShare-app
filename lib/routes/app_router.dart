import 'package:go_router/go_router.dart';
import 'package:picshare_app/presentation/pages/detail_picture.dart';
import 'package:picshare_app/presentation/pages/login.dart';
import 'package:picshare_app/presentation/pages/main.dart';
import 'package:picshare_app/presentation/pages/maps.dart';
import 'package:picshare_app/presentation/pages/maps_add_location.dart';
import 'package:picshare_app/presentation/pages/maps_detail.dart';
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
    GoRoute(path: '/maps', builder: (context, state) => const Maps()),
    GoRoute(
        path: '/maps/detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MapsDetail(id: id);
        }),
    GoRoute(
        path: '/maps/add', builder: (context, state) => const MapsAddLocation())
  ]);
}
