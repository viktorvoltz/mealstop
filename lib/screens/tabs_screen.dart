import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widget/main_drawer.dart';
import 'favourites_screen.dart';
import 'categories_screen.dart';

class TabScreen extends StatefulWidget {

  final List<Meal> favouriteMeals;
  TabScreen(this.favouriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {


  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavouritesScreen(widget.favouriteMeals), 'title': 'Your Favourite',}];
    super.initState();
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return /*DefaultTabController(
      length: 2,
      child:*/ Scaffold(
        
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
          /*bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.category), text: 'Categories'),
              Tab(icon: Icon(Icons.star), text: 'Favourites',),
            ],
          ),*/
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'],/*TabBarView(children: <Widget>[
          CategoriesScreen(),
          FavouritesScreen(),
        ],),*/

        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.category), title:  Text('Categories')),
            BottomNavigationBarItem(icon: Icon(Icons.star), title:  Text('Favourites')),
          ],
        ),
    );
  }
}
