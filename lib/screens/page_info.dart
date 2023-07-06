import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Family {
  String father_name;
  String mother_name;
  bool fatherInLife;
  bool motherInLife;
  String father_sick;
  String mother_sick;
  List<Kids> kids;

  Family({
    required this.father_name,
    required this.mother_name,
    required this.father_sick,
    required this.mother_sick,
    required this.fatherInLife,
    required this.motherInLife,
    required this.kids,
  });

  factory Family.fromJson(Map<String, dynamic> json) {
    List<dynamic> kidsJson = json['kids'];
    List<Kids> kidsList = kidsJson.map((kidJson) => Kids.fromJson(kidJson)).toList();

    return Family(
      father_name: json['father_name'],
      mother_name: json['mother_name'],
      father_sick: json['father_sick'],
      mother_sick: json['mother_sick'],
      fatherInLife: json['fatherInLife'],
      motherInLife: json['motherInLife'],
      kids: kidsList,
    );
  }
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

  factory Kids.fromJson(Map<String, dynamic> json) {
    return Kids(
      name: json['name'],
      age: json['age'],
      work: json['work'],
      sick: json['sick'],
    );
  }
}

class FamilyInfoPage extends StatefulWidget {
  @override
  _FamilyInfoPageState createState() => _FamilyInfoPageState();
}

class _FamilyInfoPageState extends State<FamilyInfoPage> {
  Family? family;

  @override

  void initState() {
    super.initState();
    loadFamily();
  }

  void loadFamily() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? familyJson = prefs.getString('family');
    if (familyJson != null) {
      setState(() {
        final Map<String, dynamic> familyMap = jsonDecode(familyJson);
        family = Family.fromJson(familyMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Families'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: family != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Father',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('Name: ${family!.father_name}'),
                  SizedBox(height: 8.0),
                  Text('Sickness: ${family!.father_sick}'),
                  SizedBox(height: 8.0),
                  Text('In Life: ${family!.fatherInLife ? 'Yes' : 'No'}'),
                  SizedBox(height: 16.0),
                  Text(
                    'Mother',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('Name: ${family!.mother_name}'),
                  SizedBox(height: 8.0),
                  Text('Sickness: ${family!.mother_sick}'),
                  SizedBox(height: 8.0),
                  Text('In Life: ${family!.motherInLife ? 'Yes' : 'No'}'),
                  SizedBox(height: 16.0),
                  Text(
                    'Kids',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  if (family!.kids.isNotEmpty)
                    Column(
                      children: family!.kids.map((kid) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${kid.name}'),
                            SizedBox(height: 8.0),
                            Text('Age: ${kid.age}'),
                            SizedBox(height: 8.0),
                            Text('Work: ${kid.work}'),
                            SizedBox(height: 8.0),
                            Text('Sickness: ${kid.sick}'),
                            SizedBox(height: 16.0),
                          ],
                        );
                      }).toList(),
                    ),
                ],
              )
            : Text('No family data available.'),
      ),
    );
  }
}
