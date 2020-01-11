import 'package:flutter/material.dart';
import 'package:spoonacular_app/model/meal_model.dart';
import 'package:spoonacular_app/model/meal_plan_model.dart';
import 'package:spoonacular_app/model/recipe_model.dart';
import 'package:spoonacular_app/screens/recipe_screen.dart';
import 'package:spoonacular_app/services/api_services.dart';

class MealsScreen extends StatefulWidget {
  final MealPlan mealPlan;
  MealsScreen({this.mealPlan});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {

_buildTotalNutrientsCard() {
    return Container(
      height: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 5)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Nutrients',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calor: ${widget.mealPlan.calories.toString()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()}g',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} gr',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carb: ${widget.mealPlan.carbs.toString()} cal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildMealCard(Meal meal, int index) {

    String mealType = _mealType(index);

    return GestureDetector(
      
      onTap: () async {
        Recipe recipe =
            await ApiService.instance.fetchRecipe(meal.id.toString());
        Navigator.push(context,
        MaterialPageRoute(builder:  (_) => RecipeScreen(
          mealType: mealType,
          recipe: recipe,
        )));
      },
          child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            Container(
              height: 220,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  image: DecorationImage(
                    image: NetworkImage(meal.imgURL),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
                  ]),
            ),
            
            Container(
              margin: EdgeInsets.all(60),
              padding: EdgeInsets.all(10),
              color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  Text(

                    mealType,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                    ),
                  ),
                  Text(

                    meal.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]
),
    );
}

_mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Your Meal Plan')),

      body: ListView.builder(

          itemCount: 1 + widget.mealPlan.meals.length,
          itemBuilder: (BuildContext context, int index) {

            if (index == 0) {
              return _buildTotalNutrientsCard();
            }
    
            Meal meal = widget.mealPlan.meals[index - 1];
            return _buildMealCard(meal, index - 1);
          }),
    );
  }
 }