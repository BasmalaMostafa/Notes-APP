import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/modules/Notes/views/note_screen.dart';

import '../../../../../Shared/Components/components.dart';

class EditNote extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final String noteId;
  final String oldContent;

  EditNote({super.key, required this.categoryId, required this.categoryName, required this.noteId, required this.oldContent});

  static const Components components = Components();

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> editNote(context) async {
    //loading here
    CollectionReference notes = FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).collection('notes');

    if (formKey.currentState!.validate()) {
      try {
        await notes.doc(widget.noteId).update({
          'note': contentController.text,
        }
        );

        // components.showPopUp('Category is added successfully!',
        //     context, DialogType.success, 'Done');

        Navigator.of(context).push(MaterialPageRoute(builder:
            (context)=> NoteScreen(categoryName: widget.categoryName, categoryId: widget.categoryId)));
      } catch (error) {
        EditNote.components.showPopUp('Failed to edit Note: $error,'
            ' please try again later!',
            context, DialogType.error, 'Error');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contentController.text = widget.oldContent;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child:Column(
              children: [
                EditNote.components.defaultFormField(
                    maxLines: 15,
                    textInputType: TextInputType.text,
                    text: 'New Note',
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
                      editNote(context);
                    },
                    fillColor: Colors.orange,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Edit'.toUpperCase(),
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
