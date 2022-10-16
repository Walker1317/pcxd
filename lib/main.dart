import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pcxd_app/scripts/route_generator.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    /*options: const FirebaseOptions(
      apiKey: "AIzaSyDARi7NZQrPJQy3fKOUD31qjzTV-QCyJng",
      authDomain: "pcxd-20d74.firebaseapp.com",
      projectId: "pcxd-20d74",
      storageBucket: "pcxd-20d74.appspot.com",
      messagingSenderId: "861019947886",
      appId: "1:861019947886:web:fdf3f7061a3af8516fb77f",
      measurementId: "G-0381XXNZ4N"
    ),*/
  );
  //await HiveConfig.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key key }) : super(key: key);
 //0054ff
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 24, 0, 46),
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 0, 46),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: GoogleFonts.abel(
            fontSize: 20
          ),
        ),
        dialogBackgroundColor: const Color.fromARGB(255, 24, 0, 46),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromARGB(255, 127, 30, 255),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(255, 24, 0, 46),
          onSecondary: const Color.fromARGB(255, 24, 0, 46),
          error: Colors.redAccent[700],
          onError: Colors.redAccent[700],
          background: const Color.fromARGB(255, 24, 0, 46),
          onBackground: const Color.fromARGB(255, 24, 0, 46),
          surface: const Color.fromARGB(255, 66, 53, 109),
          onSurface: const Color.fromARGB(255, 66, 53, 109),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 85, 255),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          )
        ),
        primaryIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 85, 255),
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.abel(color: Colors.white),
          bodyText1: GoogleFonts.abel(color: Colors.white),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titleTextStyle: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          contentTextStyle: GoogleFonts.abel(color: Colors.white, fontSize: 16),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.abel(color: Colors.white),
          hintStyle: GoogleFonts.abel(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 127, 30, 255),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent[700]
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent[700]
            ),
          ),
        ),
        dividerColor: const Color.fromARGB(255, 207, 170, 255),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
      ),
    );
  }
}