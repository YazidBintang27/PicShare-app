import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/presentation/styles/theme/app_theme.dart';
import 'package:picshare_app/providers/add_picture/add_picture_provider.dart';
import 'package:picshare_app/providers/detail/detail_provider.dart';
import 'package:picshare_app/providers/home/home_provider.dart';
import 'package:picshare_app/providers/login/login_provider.dart';
import 'package:picshare_app/providers/main/index_nav_provider.dart';
import 'package:picshare_app/providers/profile/profile_provider.dart';
import 'package:picshare_app/providers/register/register_provider.dart';
import 'package:picshare_app/providers/splash/splash_provider.dart';
import 'package:picshare_app/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final sharedPreferencesService = SharedPreferencesService(sharedPreferences);
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => ApiService()),
      Provider(create: (context) => sharedPreferencesService),
      ChangeNotifierProvider(create: (context) => IndexNavProvider()),
      ChangeNotifierProvider(create: (context) => AddPictureProvider(context.read<ApiService>(), sharedPreferencesService)),
      ChangeNotifierProvider(
          create: (context) => RegisterProvider(context.read<ApiService>())),
      ChangeNotifierProvider(
          create: (context) => LoginProvider(
              context.read<ApiService>(), sharedPreferencesService)),
      ChangeNotifierProvider(
          create: (context) => SplashProvider(sharedPreferencesService)),
      ChangeNotifierProvider(
          create: (context) => ProfileProvider(sharedPreferencesService)),
      ChangeNotifierProvider(
          create: (context) => HomeProvider(
              context.read<ApiService>(), sharedPreferencesService)),
      ChangeNotifierProvider(
          create: (context) => DetailProvider(
              context.read<ApiService>(), sharedPreferencesService))
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
