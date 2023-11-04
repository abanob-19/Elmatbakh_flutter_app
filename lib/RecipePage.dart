import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Extract the necessary properties from the arguments
    final String title = routeArgs['title'];
    final String imageURL = routeArgs['imageURL'];
    final String difficulty = routeArgs['difficulty'];
    final bool isVegan = routeArgs['isVegan'];
    final bool isVegetarian = routeArgs['isVegetarian'];
    final String preparationMethod = routeArgs['preparationMethod'];
    final List<String> ingredients =
        List<String>.from(routeArgs['ingredients']);
    IconData getDifficultyIcon(String difficulty) {
      switch (difficulty) {
        case 'Easy':
          return Icons
              .sentiment_very_satisfied; // Smiley face for easy difficulty
        case 'Medium':
          return Icons.sentiment_neutral; // Neutral face for medium difficulty
        case 'Hard':
          return Icons
              .sentiment_very_dissatisfied; // Sad face for hard difficulty
        default:
          return Icons.sentiment_very_satisfied; // Default icon
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          Image.network(
            imageURL,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            leading: Icon(getDifficultyIcon(difficulty)),
            title: Text('Difficulty: $difficulty'),
          ),
          ListTile(
            leading: Icon(isVegan ? Icons.eco : Icons.fastfood),
            title: Text(isVegan ? 'Vegan' : 'Non-Vegan'),
          ),
          ListTile(
            leading:
                Icon(isVegetarian ? Icons.emoji_food_beverage : Icons.fastfood),
            title: Text(isVegetarian ? 'Vegetarian' : 'Non-Vegetarian'),
          ),
          ExpansionTile(
            title: Text('Ingredients'),
            children: [
              for (var ingredient in ingredients)
                ListTile(
                  title: Text(ingredient),
                ),
            ],
          ),
          ExpansionTile(
            title: Text('Preparation Method'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  preparationMethod,
                  style: TextStyle(fontSize: 16),
                  softWrap: true, // Allow text to wrap to the next line
                  maxLines: null, // Set to null to allow unlimited lines
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
