import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/Authentication/Views/signup_screen.dart';

import 'modules/Authentication/Views/home_layout.dart';
import 'modules/Authentication/manager/authentication_cubit.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (BuildContext context) => AuthenticationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          '/login': (context)  => const HomePage(),
          '/signup' : (context) => SignUpScreen(),
        },
      ),
    );
  }
}









