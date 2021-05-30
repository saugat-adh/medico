import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    @required this.id,
    @required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    @required this.title,
    @required this.price,
    @required this.description,
  });
}
List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "images/brufen.png",
      "images/cholecalciferol.png",
      "images/pantrozole.png",
      "images/fortiplex.png",
    ],

    title: "BRUFEN 400mg",
    price: 90.00,
    description: description,
    rating: 4.8,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "images/cholecalciferol.png",
    ],
    title: "Cholecalciferol 60k",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "images/pantrozole.png",
    ],
    title: "Pantrozole 40mg",
    price: 36.55,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "images/fortiplex.png",
    ],

    title: "Fortiplex",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular:false,
  ),
];
const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
