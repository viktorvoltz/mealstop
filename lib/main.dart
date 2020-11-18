import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_detail.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS; 

  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree){
          return false;
        }
        if (_filters['lactose'] && !element.isLactoseFree){
          return false;
        }
        if (_filters['vegan'] && !element.isVegan){
          return false;
        }
        if (_filters['vegetarian'] && !element.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId){
    final existingIndex =  _favouriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String id){
    return _favouriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mealstop',
      theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.blue,
          canvasColor: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Roboto',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(fontSize: 22, fontFamily: 'Roboto', fontWeight: FontWeight.bold),
              )),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
        // print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('meals'),
      ),
      body: Center(
        child: Text('hello world'),
      ),
    );
  }
}
