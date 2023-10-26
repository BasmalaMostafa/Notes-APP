import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_project/modules/Home/Views/widgets/category_item.dart';

import '../../../Shared/Components/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<QueryDocumentSnapshot> data = [];

  bool isLoading =true;

  Future getData() async{
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance
      .collection('categories')
      .where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  data.addAll(querySnapshot.docs);

  isLoading =false;

  setState(() {
  });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

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
      body: isLoading? const Center(child: CircularProgressIndicator(),)
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 150),
           itemBuilder: (BuildContext context, int index) =>
               GestureDetector(
                 onLongPress: (){
                   //assssssssssssssssssssssssssssssssskkkkkkkkkkkk
                   const Components().showPopUp('Are you sure, you want to delete this folder?',
                       context, DialogType.warning, 'Delete!',deleteProcess: true,function: () async{
                         await FirebaseFirestore.instance.collection('categories').doc(data[index].id).delete();
                         // setState(() {
                         //
                         // });
                         Navigator.of(context).pushReplacementNamed('/homepage');
                       });

                   //Navigator.of(context).pushReplacementNamed('/homepage');
                 },
                   child: CategoryItem(categoryName: data[index]['name'],)),
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
