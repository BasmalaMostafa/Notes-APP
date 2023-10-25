import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title:const Text('My Notes'),
        actions: [IconButton(onPressed: () async{
          GoogleSignIn googleSignIn= GoogleSignIn();
          googleSignIn.disconnect();
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        }, icon: const Icon(Icons.exit_to_app))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 150),
           children: const [
             Card(
               child: Padding(
                 padding: EdgeInsets.all(10.0),
                 child: Column(
                   children: [
                     Image(image: AssetImage('assets/images/image_2.png'),height: 100,),
                     SizedBox(height: 5,),
                     Text('Home Notes',style: TextStyle(fontWeight: FontWeight.bold),)
                   ],
                 ),
               ),
             )
           ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/addCategory');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
