import 'package:flutter/material.dart' ;
class Family {
  String father_name;
  String mother_name;
  String father_sick;
  String mother_sick;
  String localisation_map;
  String address;
  List<Kids>kids;
  
  /*
  String father_name;
  String mother_name;
  String father_sick;
  String mother_sick;
  String localisation_map;
   */

  Family({
    required this.father_name,
    required this.mother_name,
    required this.localisation_map,
    required this.father_sick,
    required this.mother_sick,
    required this.address,
    required this.kids,
  });
  
}
class Kids {
  String name;
  int age;
  String work;
  String sick;
    Kids({
    required this.name,
    required this.age,
    required this.work,
    required this.sick,
    
  });
}
