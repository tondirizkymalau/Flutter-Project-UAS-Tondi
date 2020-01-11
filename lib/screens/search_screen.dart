import 'package:flutter/material.dart';
import 'package:spoonacular_app/model/meal_plan_model.dart';
import 'package:spoonacular_app/services/api_services.dart';
import 'meals_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _diets = [
    'None',
    'Gluten Free',
    'Ketogenic',
    'Lacto-Vegetarian',
    'Ovo-Vegetarian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
    'Whole30',
  ];

  double _targetCalories = 2250;
  String _diet = 'None';
  void _searchMealPlan() async {
    MealPlan mealPlan = await ApiService.instance.generateMealPlan(
      targetCalories: _targetCalories.toInt(),
      diet: _diet,
    );
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => MealsScreen(mealPlan: mealPlan),
    ));
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiUfd2cU5xImjYGhIIHZcEQHg66yrv1wjgtonRjYSnrf5ad7MI&s'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                    'My Daily Meal Planner',
                    style: TextStyle(fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
                  ),

                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1.copyWith(fontSize: 25),
                      children: [
                        TextSpan(
                          text:  _targetCalories.truncate().toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                          text: 'cal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        ),
                      ]
                    ),
                  ),
                  
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Colors.lightBlue[100],
                      trackHeight: 6,
                    ),
                    child: Slider(
                      min: 0,
                      max: 4500,
                      value: _targetCalories,
                      onChanged: (value) => setState(() {
                        _targetCalories = value.round().toDouble();
                      }
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField(
                      items: _diets.map((String priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(
                            priority,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Diet',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _diet = value;
                        });
                      },
                      value: _diet,
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Search', style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    
                    onPressed: _searchMealPlan,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}