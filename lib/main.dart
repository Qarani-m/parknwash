import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';
import 'package:parknwash/src/features/auth/screens/forgot_password.dart';
import 'package:parknwash/src/features/auth/screens/login.dart';
import 'package:parknwash/src/features/auth/screens/onboarding.dart';
import 'package:parknwash/src/features/auth/screens/register.dart';
import 'package:parknwash/src/features/home/screen/booking_list.dart';
import 'package:parknwash/src/features/home/screen/home_page.dart';
import 'package:parknwash/src/features/home/screen/my_bookings.dart';
import 'package:parknwash/src/features/home/screen/navigation_screen.dart';
import 'package:parknwash/src/features/parking/screens/booking_finished.dart';
import 'package:parknwash/src/features/parking/screens/locations.dart';
import 'package:parknwash/src/features/parking/screens/parking_details.dart';
import 'package:parknwash/src/features/profile/screens/favourite_lots.dart';
import 'package:parknwash/src/features/profile/screens/notification.dart';
import 'package:parknwash/src/features/profile/screens/payment_history.dart';
import 'package:parknwash/src/features/profile/screens/profile_main.dart';
import 'package:parknwash/src/utils/app_bindings.dart';
import 'package:parknwash/src/utils/themes/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
       await dotenv.load(fileName: ".env"); 
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: "basic_chanell_group",
        channelKey: "basic_chanel",
        channelName: "park_n_wash",
        channelDescription: "parn_n_wash")
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "basic_chanell_group", channelGroupName: "park_n_wash")
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();


    runApp(const MyApp());
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _updateSystemUIOverlayStyle();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _updateSystemUIOverlayStyle();
    });
  }

  void _updateSystemUIOverlayStyle() {
    print(_brightness);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          _brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBindings(),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          // themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: _brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
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
            GetPage(name: '/notifications', page: () => Notifications()),
            GetPage(name: '/payments-notification', page: () => Notifications()),
            GetPage(name: '/payments-history', page: () => PaymentHistory()),
            GetPage(name: '/favourite-lots', page: () => FavouriteLots()),
            GetPage(name: '/locations', page: () => LocationsPage()),
            GetPage(name: "/details_page", page: () => ParkingDetails()),
            GetPage(name: "/details_page", page: () => ParkingDetails()),
            GetPage(name: "/booking_finished", page: () => BookingFinished()),
            GetPage(name: "/my_bookings", page: () => MyBookings()),
            GetPage(name: "/booking_list", page: () => BookingList()),
            GetPage(name: "/navigation_screen", page: () => NavigationScreen()),
          ],
        );
      },
    );
  }
}
