// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'login_screen.dart';
//
//
// class HomeLayout extends StatelessWidget {
//   const HomeLayout({super.key});
//
//   Future<FirebaseApp> initializeFirebase() async{
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//        future: initializeFirebase(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if(snapshot.connectionState == ConnectionState.done){
//             return LoginScreen();
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
