// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';
import 'package:parknwash/src/features/auth/screens/forgot_password.dart';
import 'package:parknwash/src/features/auth/screens/login.dart';
import 'package:parknwash/src/features/auth/screens/onboarding.dart';
import 'package:parknwash/src/features/auth/screens/register.dart';
import 'package:parknwash/src/features/home/home_page.dart';
import 'package:parknwash/src/features/profile/notification.dart';
import 'package:parknwash/src/features/profile/profile_main.dart';
import 'package:parknwash/src/utils/app_bindings.dart';
import 'package:parknwash/src/utils/themes/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();

    runApp(MyApp());
  });
}

class AuthWrapper extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User?>) builder;

  const AuthWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: builder,
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBindings(),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: brightness == Brightness.light
              ? AppTheme.lightTheme()
              : AppTheme.darkTheme(),
          home: AuthWrapper(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User? user = snapshot.data;
                bool isOnboardingComplete =
                    box.read('isOnboardingComplete') ?? false;

                if (isOnboardingComplete) {
                  if (user != null) {
                    return HomePage();
                  } else {
                    return Login();
                  }
                } else {
                  return Onboarding();
                }
              }
              // While waiting for the authentication state, show a loading indicator
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            },
          ),
          getPages: [
            GetPage(name: '/onboarding', page: () => Onboarding()),
            GetPage(name: '/home', page: () => HomePage()),
            GetPage(name: '/profile-main', page: () => ProfilePage()),
            GetPage(name: '/login', page: () => Login()),
            GetPage(name: '/register', page: () => Register()),
            GetPage(name: '/forgot_password', page: () => ForgotPassword()),
            GetPage(name: '/notifications', page: () =>  Notifications()),
            GetPage(name: '/payments-notification', page: () =>  Notifications()),
          ],
        );
      },
    );
  }


}
