/***********************************************************
* This Flutter application is a mobile slam book application that allows users to 
* add friends and fill out a slam book form. The user can view the details of the
* friends and edit them. The application uses Firebase Firestore to store the data.
*
* The application also uses the provider package to manage the state of the application
* and a Google Fonts package to style the text and the theme of the application.
*
* @author bernardjezua
* @created_date 2023-07-17 23:36
* DO NOT COPY OR USE THE CODE FOR OTHER PURPOSES.
***********************************************************/

import 'package:google_fonts/google_fonts.dart' as gf;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/friends_provider.dart';
import 'firebase_options.dart';
import 'screens/friends_page.dart';
import 'screens/slambook_page.dart';
import 'screens/details_page.dart';
import 'screens/edit_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => FriendListProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Light blue colored theme
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
        textTheme: gf.GoogleFonts.lexendTextTheme(), // Imported font
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          titleTextStyle: gf.GoogleFonts.lexend(
            textStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        // Changes the border themes of input fields
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const FriendsPage(),
        "/slambook": (context) => const SlamBookForm(),
        "/details": (context) => const FriendSummary(),
        "/edit": (context) => const EditFriend(),
      },
    );
  }
}