import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/modules/Notes/views/note_screen.dart';

import '../../../../../Shared/Components/components.dart';

class AddNote extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  AddNote({super.key, required this.categoryId, required this.categoryName});

  static const Components components = Components();

  final TextEditingController contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> addNote(context) async {
    //loading here
    CollectionReference notes = FirebaseFirestore.instance.collection('categories').doc(categoryId).collection('notes');

    if (formKey.currentState!.validate()) {
      try {
        await notes.add({
          'note': contentController.text,
        }
        );

        // components.showPopUp('Category is added successfully!',
        //     context, DialogType.success, 'Done');

        Navigator.of(context).push(MaterialPageRoute(builder:
            (context)=> NoteScreen(categoryName: categoryName, categoryId: categoryId)));
      } catch (error) {
        components.showPopUp('Failed to add Note: $error,'
            ' please try again later!',
            context, DialogType.error, 'Error');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child:Column(
              children: [
                components.defaultFormField(
                  maxLines: 15,
                    textInputType: TextInputType.text,
                    text: 'Enter your Note',
                    prefixIcon: Icons.note_alt_outlined,
                    controller: contentController,
                    validator:  (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field is required';
                      }
                    }
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 150,
                  child: RawMaterialButton(
                    onPressed: () {
                      addNote(context);
                    },
                    fillColor: Colors.orange,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Add'.toUpperCase(),
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
