import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../Shared/Components/components.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  static const Components components = Components();

  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  Future<void> addCategory(context) async {
    if (formKey.currentState!.validate()) {
      try {
        await categories.add({
          'name': nameController.text,
        }
        );

        // components.showPopUp('Category is added successfully!',
        //     context, DialogType.success, 'Done');

        Navigator.of(context).pushReplacementNamed('/homepage');
      } catch (error) {
        components.showPopUp('Failed to add Category: $error,'
            ' please try again later!',
            context, DialogType.error, 'Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child:Column(
              children: [
                components.defaultFormField(
                    textInputType: TextInputType.text,
                    text: 'Category Name',
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
                      addCategory(context);
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
