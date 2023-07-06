import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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

class Family {
  String father_name;
  String mother_name;
  String father_sick;
  String mother_sick;
  String localisation_map;
  String address;
  List<Kids> kids;

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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Family> families = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: families.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(families[index].father_name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              families[index].localisation_map,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.copy, color: Colors.deepPurple),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                text: families[index].localisation_map,
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text('localisation_map copied')),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              openMap(families[index].localisation_map);
                            },
                            icon: Icon(Icons.map, color: Colors.deepPurple),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.deepPurple),
                            onPressed: () {
                              // Show the edit family dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditFamilyDialog(
                                    family: families[index],
                                    onFamilyUpdated: (updatedFamily) {
                                      // Update the family details in the list
                                      setState(() {
                                        families[index] = updatedFamily;
                                      });
                                      Navigator.pop(context); // Close the dialog
                                    },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddFamilyDialog(
                onFamilyAdded: (family) {
                  
                  setState(() {
                    families.add(family);
                  });
                  Navigator.pop(context); // Close 
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddFamilyDialog extends StatefulWidget {
  const AddFamilyDialog({required this.onFamilyAdded});
  final Function(Family) onFamilyAdded;
  @override
  State<AddFamilyDialog> createState() => _AddFamilyDialogState();
}

class _AddFamilyDialogState extends State<AddFamilyDialog> {
  List<Kids> kids = [];
  Family? family;
  final TextEditingController father_nameController = TextEditingController();
  final TextEditingController mother_nameController = TextEditingController();
  final TextEditingController localisation_mapController = TextEditingController();
  final TextEditingController father_sickController = TextEditingController();
  final TextEditingController mother_sickController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController kidsNameController = TextEditingController();
  final TextEditingController kidsAgeController = TextEditingController();
  final TextEditingController kidsWorkController = TextEditingController();
  final TextEditingController kidsSickController = TextEditingController();
  
  

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Family'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: father_nameController,
              decoration: InputDecoration(labelText: 'Father\'s Name'),
            ),
            TextField(
              controller: mother_nameController,
              decoration: InputDecoration(labelText: 'Mother\'s Name'),
            ),
            TextField(
              controller: father_sickController,
              decoration: InputDecoration(labelText: 'Father\'s Sickness'),
            ),
            TextField(
              controller: mother_sickController,
              decoration: InputDecoration(labelText: 'Mother\'s Sickness'),
            ),
            TextField(
              controller: localisation_mapController,
              decoration: InputDecoration(labelText: 'Map Location'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Add a Kid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
                    
                    itemCount: family?.kids.length,
                    itemBuilder: (context, index) {
                      final kid = family!.kids[index];
                      return ListTile(
                        title: Text(kid.name),
                        subtitle: Text('Age: ${kid.age} Work: ${kid.work} Sickness: ${kid.sick}'),
                      );
                    },),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Create a new Family object
            Family family = Family(
              father_name: father_nameController.text,
              localisation_map: localisation_mapController.text,
              mother_name: mother_nameController.text,
              father_sick: father_sickController.text,
              mother_sick: mother_sickController.text,
              address: addressController.text,
              kids: kids,
            );

            // Call the onFamilyAdded callback with the new family
            widget.onFamilyAdded(family);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class EditFamilyDialog extends StatefulWidget {
  final Family family;
  final Function(Family) onFamilyUpdated;

  EditFamilyDialog({required this.family, required this.onFamilyUpdated});

  @override
  _EditFamilyDialogState createState() => _EditFamilyDialogState();
}

class _EditFamilyDialogState extends State<EditFamilyDialog> {
  late TextEditingController father_nameController;
  late TextEditingController mother_nameController;
  late TextEditingController father_sickController;
  late TextEditingController mother_sickController;
  late TextEditingController localisation_mapController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    father_nameController = TextEditingController(text: widget.family.father_name);
    mother_nameController = TextEditingController(text: widget.family.mother_name);
    father_sickController = TextEditingController(text: widget.family.father_sick);
    mother_sickController = TextEditingController(text: widget.family.mother_sick);
    localisation_mapController = TextEditingController(text: widget.family.localisation_map);
    addressController = TextEditingController(text: widget.family.address);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Family'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: father_nameController,
              decoration: InputDecoration(labelText: 'Father\'s Name'),
            ),
            TextField(
              controller: mother_nameController,
              decoration: InputDecoration(labelText: 'Mother\'s Name'),
            ),
            TextField(
              controller: father_sickController,
              decoration: InputDecoration(labelText: 'Father\'s Sickness'),
            ),
            TextField(
              controller: mother_sickController,
              decoration: InputDecoration(labelText: 'Mother\'s Sickness'),
            ),
            TextField(
              controller: localisation_mapController,
              decoration: InputDecoration(labelText: 'Map Location'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Create a new Family object with updated details
            Family updatedFamily = Family(
              father_name: father_nameController.text,
              mother_name: mother_nameController.text,
              father_sick: father_sickController.text,
              mother_sick: mother_sickController.text,
              localisation_map: localisation_mapController.text,
              address: addressController.text,
              kids: widget.family.kids,
            );

            // Call the onFamilyUpdated callback with the updated family
            widget.onFamilyUpdated(updatedFamily);
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}

void openMap(String goto) async {
  String googleMapsUrl =
      'https://www.google.com/maps/search/?api=1&query=$goto';

  try {
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  } catch (e) {
    print('An error occurred: $e');
    // Handle the error gracefully, e.g., show an error message to the user
  }
}