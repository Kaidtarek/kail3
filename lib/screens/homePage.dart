
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafil/screens/page_info.dart';
import 'package:kafil/ui/actions.dart';
import 'package:kafil/ui/add_family.dart';
import 'package:kafil/ui/employee.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedpage =0;
  final _pageNo = [FamilyEditor() , CartPage() , ProfilePage(),];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Admin model'),
        ),
        
        body: _pageNo[selectedpage],
        
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.family_restroom, title: 'العائلات'),
            TabItem(icon: Icons.volunteer_activism_rounded, title: 'نشاطات'),
            TabItem(icon: Icons.group, title: 'الأعضاء'),
          ],
          initialActiveIndex: selectedpage,
          onTap: (int index){
              setState(() {
                selectedpage = index;
              });
          },
        ),
      ),
    );
  }
}