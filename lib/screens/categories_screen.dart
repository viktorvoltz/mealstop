import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widget/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('meal')
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: GridView(
          
          children: DUMMY_CATEGORIES
              .map((catData) => CategoryItem(catData.id, catData.title, catData.color,))
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
