
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Shared/Components/components.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/image_2.png'),height: 100,),
            const SizedBox(height: 5,),
            Text(categoryName,style: const TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
