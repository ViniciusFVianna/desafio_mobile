import 'package:desafio_mobile/app/data/models/user_model.dart';
import 'package:desafio_mobile/utilities/constant_string.dart';
import 'package:desafio_mobile/utilities/prefs.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

 final user = await UserModel.get();
 final prefsUser = await Prefs.getString(ConstantString.authPrefs);

  runApp(
    GetMaterialApp(
      title: ConstantString.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: user.uId != null
      && prefsUser.isNotEmpty
      ? Routes.home
      : AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const  AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
        primaryColorDark: Colors.teal[800],
        primaryColorLight: Colors.teal[400],
        primaryColor: Colors.teal,
      ),
    ),
  );
}
