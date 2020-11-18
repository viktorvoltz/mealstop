import 'package:flutter/material.dart';
import '../widget/meal_item.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals); 

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
     
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData){
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(routeArgs){
    setState(() {
      displayedMeals.removeWhere((element) => element.id == routeArgs);
      print('mealId $routeArgs');
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
