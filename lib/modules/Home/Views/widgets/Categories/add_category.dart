import 'package:flutter/material.dart';

import '../../../../../Shared/Components/components.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  static const Components components = Components();

  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                  width: 100,
                  child: RawMaterialButton(
                    onPressed: () {

                    },
                    fillColor: Colors.orange,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Add',
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
