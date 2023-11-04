import './recipe.dart';
import 'package:flutter/material.dart';

var recipesList = [
  Recipe(
      id: 'r1',
      title: 'Fattoush',
      categoryId: ['c3'],
      difficulty: 1,
      ingredients: ['Lettuce', 'Tomato', 'Summac', 'Onion', 'Olive oil'],
      steps: 'Mix all together',
      isVegan: true,
      isVegeterian: true,
      imageURL:
          'https://assets.bonappetit.com/photos/57af6bea53e63daf11a4e565/16:9/w_1280,c_limit/fattoush.jpg'),
  Recipe(
      id: 'r2',
      title: 'Falafel',
      categoryId: ['c2', 'c3'],
      difficulty: 2,
      ingredients: ['Fava beans', 'Hummus', 'Spices', 'frying oil'],
      steps: 'Mix ingredients into balls and fry them',
      isVegan: true,
      isVegeterian: true,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/4/4f/Falafel.JPG'),
  Recipe(
      id: 'r3',
      title: 'Chicken Alfredo',
      categoryId: ['c1'],
      difficulty: 2,
      ingredients: ['pasta', 'chicken', 'alredo sauce'],
      steps: 'Boil pasta, prepare chicken and pour sauce over',
      isVegan: false,
      isVegeterian: false,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/5/57/Pasta_Alfredo_venezolana.jpg')
];
