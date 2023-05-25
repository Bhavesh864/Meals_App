import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _selectedMeal;

  @override
  void initState() {
    // initState cant be used because it loads way earlier and that time context is not avilable....
    super.initState();
  }

  @override
  //It runs every time when the state of widget changes
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _categoryTitle = routeArgs['title'];
    final _categoryId = routeArgs['id'];
    _selectedMeal = widget.availableMeals.where((meal) {
      return meal.categories.contains(_categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     _selectedMeal.removeWhere((meal) => mealId == meal.id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: _selectedMeal[index].id,
            title: _selectedMeal[index].title,
            imageUrl: _selectedMeal[index].imageUrl,
            duration: _selectedMeal[index].duration,
            complexity: _selectedMeal[index].complexity,
            affordability: _selectedMeal[index].affordability,
          );
          // removeItem: _removeMeal);
        },
        itemCount: _selectedMeal.length,
      ),
    );
  }
}
