// ملف reports_screen.dart
import 'package:flutter/material.dart';



import '../../helper/constans.dart';
import 'Widgets/data_table_report.dart';

//this
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('نظام التقارير'),
      backgroundColor: kColorPrimer,
      centerTitle: true,
      elevation: 4,
      shadowColor: kColorPrimer.withOpacity(0.3),
    ),
      body:const  DataTableReport(),
    
    );
  }
}