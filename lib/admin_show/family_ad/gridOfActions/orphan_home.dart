

import 'package:flutter/material.dart';

class orphan_info extends StatelessWidget {
  const orphan_info({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Text('',style: TextStyle(fontSize: 20),),
          ),
          Card(
            child: Text("""
                 هنا نحطو ليست تاع العائلات ونديرو حذاها ايقونة تاع المعلومات تاعها لازم يكون فيها اان ونوع البناية و عندهم كهرباء ولالا عندهم غاز ولا بالقرعة و و المستلزمات ثلاجة تلفاز و وصيغة السكن كاري ولا باطل و لا ملكه 
            """,style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
  }
}
