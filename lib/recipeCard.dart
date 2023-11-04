import 'package:elmatbakh/RecipePage.dart';
import 'package:elmatbakh/recipe.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeCard extends StatefulWidget {
  Recipe rec;
  RecipeCard({required this.rec});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isFavourite = false;
  void goToSpecificRecipe() {}
  void initState() {
    super.initState();
    loadFavoriteStatus();
  }

  Future<void> loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      isFavourite = favorites.contains(widget.rec.id);
    });
  }

  IconData getDifficultyIcon(int difficulty) {
    switch (difficulty) {
      case 1:
        return Icons
            .sentiment_very_satisfied; // Smiley face for easy difficulty
      case 2:
        return Icons.sentiment_neutral; // Neutral face for medium difficulty
      case 3:
        return Icons
            .sentiment_very_dissatisfied; // Sad face for hard difficulty
      default:
        return Icons.sentiment_very_satisfied; // Default icon
    }
  }

  IconData getVeganIcon(bool isVegan) {
    return isVegan
        ? Icons.eco
        : Icons.fastfood; // Example icons for vegan and non-vegan
  }

  IconData getVegetarianIcon(bool isVegetarian) {
    return isVegetarian
        ? Icons.emoji_food_beverage
        : Icons.fastfood; // Example icons for vegetarian and non-vegetarian
  }

  String getDifficulty(int diff) {
    if (diff == 1) {
      return 'Easy';
    } else if (diff == 2) {
      return 'Medium';
    } else
      return 'Hard';
  }

  Future<void> toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (favorites.contains(widget.rec.id)) {
      // Recipe is already a favorite, so remove it from favorites
      favorites.remove(widget.rec.id);
      setState(() {
        isFavourite = false;
      });
    } else {
      // Recipe is not a favorite, so add it to favorites
      favorites.add(widget.rec.id);
      setState(() {
        isFavourite = true;
      });
    }

    await prefs.setStringList('favorites', favorites);
  }

  Future<bool> isFavorite(String recipeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    return favorites.contains(recipeId);
  }

  void navigateToRecipePage(BuildContext context) {
    print('Navigating to recipe page');

    Navigator.of(context).pushNamed(
      '/recipeRoute',
      arguments: {
        'title': widget.rec.title,
        'imageURL': widget.rec.imageURL,
        'difficulty': getDifficulty(widget.rec.difficulty),
        'isVegan': widget.rec.isVegan,
        'isVegetarian': widget.rec.isVegeterian,
        'preparationMethod': widget.rec.steps,
        'ingredients': widget.rec.ingredients,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Recipe card tapped');
        navigateToRecipePage(context); // Call the navigation function
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            // child 1 of column is image + title
            Stack(
              children: [
                // child 1 of stack is the recipe image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    widget.rec.imageURL,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // child 2 of stack is the recipe title
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      color: Colors.black38,
                      child: Center(
                          //color: Colors.black38,
                          child: Text(
                        widget.rec.title,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  bottom: 0,
                )
              ],
            ),
            // child 2 of colum is the white row
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(getDifficultyIcon(widget.rec.difficulty)),
                  Icon(getVeganIcon(widget.rec.isVegan)),
                  Icon(getVegetarianIcon(widget.rec.isVegeterian)),
                  IconButton(
                    icon: FutureBuilder<bool>(
                      future: isFavorite(widget.rec.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Icon(
                            Icons.favorite,
                            color:
                                Colors.red, // Placeholder color while waiting
                          );
                        } else if (snapshot.hasError) {
                          return Icon(
                            Icons.favorite,
                            color: Colors
                                .grey, // Placeholder color in case of an error
                          );
                        } else {
                          final isFavorite = snapshot.data ??
                              false; // Use a default value of 'false' if data is null
                          return Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons
                                    .favorite, // X icon for non-favorite recipes
                            color: isFavorite ? Colors.red : Colors.grey,
                          );
                        }
                      },
                    ),
                    onPressed: toggleFavorite,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
