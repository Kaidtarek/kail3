import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Employee> employees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                color: Colors.grey[400],
                elevation: 0,
                child: ListTile(
                  title: Text(employees[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${employees[index].age}'),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text('Number phone:'),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '0${employees[index].phone}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _makePhoneCall('+213${employees[index].phone}');
                            },
                            icon: Icon(Icons.call,
                                size: 40, color: Colors.green),
                          ),
                          Card(
                            color: const Color.fromARGB(255, 161, 130, 75),
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Show the edit employee dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditEmployeeDialog(
                                      employee: employees[index],
                                      onEmployeeUpdated: (updatedEmployee) {
                                        // Update the employee details in the list
                                        setState(() {
                                          employees[index] = updatedEmployee;
                                        });
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the add employee dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddEmployeeDialog(
                onEmployeeAdded: (employee) {
                  // Add the new employee to the list
                  setState(() {
                    employees.add(employee);
                  });
                  Navigator.pop(context); // Close the dialog
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

class AddEmployeeDialog extends StatelessWidget {
  final Function(Employee) onEmployeeAdded;

  AddEmployeeDialog({required this.onEmployeeAdded});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Employee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Create a new Employee object
            Employee employee = Employee(
              name: nameController.text,
              age: int.tryParse(ageController.text) ?? 0,
              phone: phoneController.text,
            );

            // Call the onEmployeeAdded callback with the new employee
            onEmployeeAdded(employee);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class EditEmployeeDialog extends StatefulWidget {
  final Employee employee;
  final Function(Employee) onEmployeeUpdated;

  EditEmployeeDialog({required this.employee, required this.onEmployeeUpdated});

  @override
  _EditEmployeeDialogState createState() => _EditEmployeeDialogState();
}

class _EditEmployeeDialogState extends State<EditEmployeeDialog> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.employee.name);
    ageController = TextEditingController(text: widget.employee.age.toString());
    phoneController = TextEditingController(text: widget.employee.phone);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Employee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Create a new Employee object with updated details
            Employee updatedEmployee = Employee(
              name: nameController.text,
              age: int.tryParse(ageController.text) ?? 0,
              phone: phoneController.text,
            );

            // Call the onEmployeeUpdated callback with the updated employee
            widget.onEmployeeUpdated(updatedEmployee);
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}

class Employee {
  String name;
  int age;
  String phone;

  Employee({
    required this.name,
    required this.age,
    required this.phone,
  });
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

void _makePhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
