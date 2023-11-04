import 'package:elmatbakh/recipe.dart';
import 'package:elmatbakh/recipeList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elmatbakh/recipeCard.dart'; // Import your RecipeCard widget

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> favorites = [];

  @override
  void initState() {
    loadFavorites();
    super.initState();
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList('favorites') ?? [];
    setState(() {});
  }

  void removeFromFavorites(String recipeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorites.remove(recipeId);
    await prefs.setStringList('favorites', favorites);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Meals'),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text('No favorite meals yet!'),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    RecipeCard(
                      rec: getRecipeById(favorites[index]),
                    ),
                    // Add a button or icon to remove from favorites
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.red),
                      onPressed: () {
                        removeFromFavorites(favorites[index]);
                      },
                    ),
                  ],
                );
              },
              itemCount: favorites.length,
            ),
    );
  }

  Recipe getRecipeById(String recipeId) {
    // Search for the recipe with the matching ID
    return recipesList.firstWhere(
      (recipe) => recipe.id == recipeId,
      // Return null if not found
    );
  }
}
