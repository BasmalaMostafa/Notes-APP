import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../Shared/Components/components.dart';

class EditCategory extends StatefulWidget {
  EditCategory({super.key, required this.categoryId, required this.oldName});

  final String categoryId;

  final String oldName;

  static const Components components = Components();

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  Future<void> editCategory(context) async {
    //loading here
    if (formKey.currentState!.validate()) {
      try {
        await categories.doc(widget.categoryId).update({       ///replace set instead update ,what is the benefit?
          'name': nameController.text
        });

        // components.showPopUp('Category is added successfully!',
        //     context, DialogType.success, 'Done');

        Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (route) => false);
      } catch (error) {
        EditCategory.components.showPopUp('Failed to edit Folder name: $error,'
            ' please try again later!',
            context, DialogType.error, 'Error');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.oldName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Folder'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child:Column(
              children: [
                EditCategory.components.defaultFormField(
                    textInputType: TextInputType.text,
                    text: 'New Folder Name',
                    prefixIcon: Icons.folder_copy_sharp,
                    controller: nameController,
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
                      editCategory(context);
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
