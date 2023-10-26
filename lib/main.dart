import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/Authentication/Views/login_screen.dart';
import 'package:my_project/modules/Authentication/Views/signup_screen.dart';

import 'modules/Authentication/Views/home_layout.dart';
import 'modules/Categories/add_category.dart';
import 'modules/Home/Views/home_screen.dart';
import 'modules/Authentication/manager/authentication_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (BuildContext context) => AuthenticationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primaryColor: Colors.orange,
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[100],
            titleTextStyle: const TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            iconTheme: const IconThemeData(
              color: Colors.orange,
              size: 27
            )
          )
        ),
        home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ?const HomePage():LoginScreen(),
        routes: {
          '/login': (context)  => LoginScreen(),
          '/signup' : (context) => SignUpScreen(),
          '/homepage' : (context) => const HomePage(),
          '/addCategory' : (context) => AddCategory(),
        },
      ),
    );
  }
}









