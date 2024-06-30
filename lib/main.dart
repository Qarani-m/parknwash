import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/screens/login.dart';
import 'package:parknwash/src/features/auth/screens/onboarding.dart';
import 'package:parknwash/src/features/home/home_page.dart';
import 'package:parknwash/src/features/profile/profile_main.dart';
import 'package:parknwash/src/utils/app_bindings.dart';
import 'package:parknwash/src/utils/themes/theme.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();

    runApp( MyApp());
  });
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

      final box = GetStorage();


  @override
  Widget build(BuildContext context) {
    bool isOnboardingComplete = box.read('isOnboardingComplete') ?? false;

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
          initialRoute: isOnboardingComplete?"/login":'/onboarding',
          getPages: [
            GetPage(name: '/onboarding', page: () => Onboarding()),
            GetPage(name: '/home', page: () => HomePage()),
            GetPage(name: '/profile-main', page: () => const ProfilePage()),
            GetPage(name: '/login', page: () => Login()),
          ],
        );
      },
    );
  }
}
