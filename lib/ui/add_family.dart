import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class FamilyEditor extends StatefulWidget {
  final Family? initialFamily;

  const FamilyEditor({Key? key, this.initialFamily}) : super(key: key);

  @override
  _FamilyEditorState createState() => _FamilyEditorState();
}

class _FamilyEditorState extends State<FamilyEditor> {
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController fatherSickController = TextEditingController();
  final TextEditingController motherSickController = TextEditingController();
  final TextEditingController kidsNameController = TextEditingController();
  final TextEditingController kidsAgeController = TextEditingController();
  final TextEditingController kidsWorkController = TextEditingController();
  final TextEditingController kidsSickController = TextEditingController();

  bool fatherInLife = true;
  bool motherInLife = true;
  List<Kids> kids = [];
  List<Family> family = [];

  void addKid() {
    final Kids newKid = Kids(
      name: kidsNameController.text,
      age: int.parse(kidsAgeController.text),
      work: kidsWorkController.text,
      sick: kidsSickController.text,
    );
    setState(() {
      kids.add(newKid);
    });
    kidsNameController.clear();
    kidsAgeController.clear();
    kidsWorkController.clear();
    kidsSickController.clear();
  }

  void editKid(int index) {
    final Kids editedKid = Kids(
      name: kidsNameController.text,
      age: int.parse(kidsAgeController.text),
      work: kidsWorkController.text,
      sick: kidsSickController.text,
    );
    setState(() {
      kids[index] = editedKid;
    });
    kidsNameController.clear();
    kidsAgeController.clear();
    kidsWorkController.clear();
    kidsSickController.clear();
  }

  void saveFamily() {
    final Family newFamily = Family(
      father_name: fatherNameController.text,
      mother_name: motherNameController.text,
      father_sick: fatherSickController.text,
      mother_sick: motherSickController.text,
      fatherInLife: fatherInLife,
      motherInLife: motherInLife,
      kids: kids,
    );

    fatherNameController.clear();
    motherNameController.clear();
    fatherSickController.clear();
    motherSickController.clear();
    kidsNameController.clear();
    kidsAgeController.clear();
    kidsWorkController.clear();
    kidsSickController.clear();
    setState(() {
      kids = [];
      family.add(newFamily); // Add newFamily to the family list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Family'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: family.length,
                itemBuilder: (context, index) {
                  final fam = family[index];
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(fam.father_name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 4),

                                  // IconButton(
                                  //   icon: Icon(Icons.copy, color: Colors.deepPurple),
                                  //   onPressed: () {
                                  //     Clipboard.setData(ClipboardData(
                                  //       text: families[index].localisation_map,
                                  //     ));
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //       SnackBar(
                                  //         content: Center(child: Text('localisation_map copied')),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     openMap(families[index].localisation_map);
                                  //   },
                                  //   icon: Icon(Icons.map, color: Colors.deepPurple),
                                  // ),
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.deepPurple),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Edit Family'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    controller:
                                                        fatherNameController,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Father Name'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        motherNameController,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Mother Name'),
                                                  ),
                                                  // Other fields for editing the family information
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Save'),
                                                onPressed: () {
                                                  // Perform the necessary update to the family object
                                                  // You can access the current family using the index parameter
                                                  // and update the properties based on the entered values in the text fields

                                                  // Example:
                                                  Family editedFamily =
                                                      family[index];
                                                  editedFamily.father_name =
                                                      fatherNameController.text;
                                                  editedFamily.mother_name =
                                                      motherNameController.text;
                                                  // Update other properties as needed

                                                  setState(() {
                                                    family[index] =
                                                        editedFamily;
                                                  });

                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.info_outlined),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Text(
                'Father',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: fatherSickController,
                decoration: InputDecoration(labelText: 'Sickness'),
              ),
              Row(
                children: [
                  Text('Is father alive?'),
                  Checkbox(
                    value: fatherInLife,
                    onChanged: (value) {
                      setState(() {
                        fatherInLife = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Mother',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: motherNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: motherSickController,
                decoration: InputDecoration(labelText: 'Sickness'),
              ),
              Row(
                children: [
                  Text('Is mother alive?'),
                  Checkbox(
                    value: motherInLife,
                    onChanged: (value) {
                      setState(() {
                        motherInLife = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Kids',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: kids.length,
                itemBuilder: (context, index) {
                  final kid = kids[index];
                  return ListTile(
                    title: Text(kid.name),
                    subtitle: Row(
                      children: [
                        Text(
                            'Age: ${kid.age} Work: ${kid.work} Sickness: ${kid.sick}'),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            kidsNameController.text = kid.name;
                            kidsAgeController.text = kid.age.toString();
                            kidsWorkController.text = kid.work;
                            kidsSickController.text = kid.sick;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Edit Kid'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: kidsNameController,
                                          decoration: InputDecoration(
                                              labelText: 'Name'),
                                        ),
                                        TextField(
                                          controller: kidsAgeController,
                                          decoration:
                                              InputDecoration(labelText: 'Age'),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextField(
                                          controller: kidsWorkController,
                                          decoration: InputDecoration(
                                              labelText: 'Work'),
                                        ),
                                        TextField(
                                          controller: kidsSickController,
                                          decoration: InputDecoration(
                                              labelText: 'Sickness'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        editKid(index);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Add a Kid',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: kidsNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: kidsAgeController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: kidsWorkController,
                decoration: InputDecoration(labelText: 'Work'),
              ),
              TextField(
                controller: kidsSickController,
                decoration: InputDecoration(labelText: 'Sickness'),
              ),
              ElevatedButton(
                child: Text('Add Kid'),
                onPressed: addKid,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(widget.initialFamily == null
                    ? 'Add Family'
                    : 'Save Family'),
                onPressed: saveFamily,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
