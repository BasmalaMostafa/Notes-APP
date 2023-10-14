import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title:const Text('My Notes'),
        actions: [IconButton(onPressed: () async{
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        }, icon: const Icon(Icons.exit_to_app))],
      ),
    );
  }
}
