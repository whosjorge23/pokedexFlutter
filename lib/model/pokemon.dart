import 'package:flutter/material.dart';

class Pokemon {
  String name = "";
  String imageUrl = "";
  String type = "";
  String description = "";
  int attack = 0;
  int defense = 0;

  Pokemon(this.name, this.imageUrl, this.type, this.description, this.attack,
      this.defense);

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    description = json['description'];
    attack = json['attack'];
    defense = json['defense'];
  }
}
