import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylibraryapp/features/data/datasource/mylibrary_auth.dart';
import 'package:mylibraryapp/features/presentation/home/home_view.dart';
import 'package:mylibraryapp/features/presentation/login/login_view.dart';
import 'package:mylibraryapp/locator.dart';

Future<void> main() async {
  locator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyLibraryApp());
}

class MyLibraryApp extends StatelessWidget {
  const MyLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'myLibrary',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Ubuntu',
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff16A085),
          onPrimary: Color(0xff1ABC9C),
          secondary: Color(0xff1687A0),
          onSecondary: Color(0xff1687A0),
          error: Color(0xffBC8F1A),
          onError: Color(0xffCCCCCC),
          background: Color(0xff313642),
          onBackground: Color(0xff3E4553),
          surface: Colors.black,
          onSurface: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Ubuntu',
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff16A085),
          onPrimary: Color(0xff1ABC9C),
          secondary: Color(0xff1687A0),
          onSecondary: Color(0xff1687A0),
          error: Color(0xffBC8F1A),
          onError: Color(0xffCCCCCC),
          background: Color(0xff313642),
          onBackground: Color(0xff3E4553),
          surface: Colors.black,
          onSurface: Colors.white,
        ),
      ),
      home: MyLibraryAuth().firebaseAuth.currentUser != null
          ? const HomeView()
          : const LoginView(),
    );
  }
}
