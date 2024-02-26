import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:fluttertest/Screens/cartScreen/cartScreen.dart';
import 'package:fluttertest/Screens/homeScreen/homeScreen.dart';
import 'package:fluttertest/Screens/packageScreen/packages_detail.dart';
import 'package:fluttertest/Screens/packageScreen/reviewPackage.dart';
import 'package:fluttertest/Screens/reserveScreen/reserveCharter.dart';
import 'package:fluttertest/Screens/reserveScreen/reserveDetail.dart';
import 'package:fluttertest/Screens/reserveScreen/reverve_step.dart';
import 'package:fluttertest/Screens/reserveScreen/revserveScreen.dart';
import 'package:fluttertest/Screens/userScreen/Editpersonal.dart';
import 'package:fluttertest/StratScreen.dart';
import 'package:fluttertest/assets/Nav/nav_screen.dart';
import 'package:fluttertest/assets/theme/theme.dart';
import 'package:fluttertest/dependency_injection.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  //function Friebase crashlytics
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  EquatableConfig.stringify = kDebugMode;

  DependencyInjection.init();

  // set lock screen
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await GetStorage.init().then((value) {
    var userID = GetStorage().read('userID');
    var userfirstName = GetStorage().read('userfristName');
    var userlastName = GetStorage().read('userlastName');
    var userEmail= GetStorage().read('userEmail');
    var userPhone = GetStorage().read('userPhone');
    
    if (userID == null) {
      var googleName = GetStorage().read('googleName');
      var googleEmail = GetStorage().read('googleEmail');
      var googleUID = GetStorage().read('googleUID');
      var googleImage = GetStorage().read('googleImage');

      print('google : {$googleUID, $googleName, $googleEmail, $googleImage}');
    }
    return print('{userData ==> $userID ==> $userfirstName ==> $userlastName ==> $userEmail ==> $userPhone}');
  });

  //get message from onesignal
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("a96f188a-07dd-4ed8-b6be-4811a18c203a");
  OneSignal.Notifications.requestPermission(true);
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: appTheme.lightTheme,
      // darkTheme: appTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      // theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
      home: startScreen(),
    );
  }
}
