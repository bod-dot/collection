import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../helper/constans.dart';
import '../../../models/customer.dart';
import '../take_reading_screen.dart';
//this
class DataTableReport extends StatefulWidget {
  const DataTableReport({super.key});

  @override
  State<DataTableReport> createState() => _DataTableReportState();
}

class _DataTableReportState extends State<DataTableReport> {
 late List<Customer>customer;

 @override
  void initState() {
    customer=BlocProvider.of<HomeCubit>(context).customers..sort((a, b) {
      if (a.electronicMeterHasBeenRead && !b.electronicMeterHasBeenRead) {
        return -1; // a قبل b
      } else if (!a.electronicMeterHasBeenRead && b.electronicMeterHasBeenRead) {
        return 1;  // a بعد b
      }
      return 0; // إذا كانتا متساويتين
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
             const  SizedBox(height: 20,),
              Container(
               // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DataTable(
                  border: TableBorder(
                    horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
                    top:const   BorderSide(width: 1.5, color: Colors.black),
                    bottom:const  BorderSide(width: 1.5, color: Colors.black),
                    verticalInside: BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  columnSpacing: 15,
                  headingRowColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.blueGrey.shade100,
                  ),
                  columns: const [
                    DataColumn(label: Text(
                        "الاسم", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kColorPrimer))),
                    DataColumn(label: Text("رقم المشترك", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kColorPrimer))),
                    DataColumn(label: Text("تاريخ التسديد", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kColorPrimer))),
                    DataColumn(label: Text("الرصيد المتبقي ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kColorPrimer))),
                    DataColumn(label: Text(" الحالة", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: kColorPrimer))),
                  ],
                  rows: [
                    ...customer.map((data) {
                      return DataRow(
                       onSelectChanged: (selected)
                       {
                         if (selected != null &&data.electronicMeterHasBeenRead)
                         {
                           Navigator.pushNamed(context, TakeReadingScreen.id); 
                         }
                       },
                        cells: [
                        DataCell(Text(data.customerName.toString(),
                            style:const  TextStyle(fontSize:20))),
                    
                         DataCell(Text(data.customerID.toString(),
                            style:const TextStyle(fontSize:20))),
                        DataCell(Text(data.customerMovementDate!=null ?"${data.customerMovementDate!.year}-${data.customerMovementDate!.month}-${data.customerMovementDate!.day}":'',
                            style:const  TextStyle(fontSize:20))),
                        DataCell(Text(data.customerTotalDues.toString(),
                            style:const  TextStyle(fontSize: 20))),
                         DataCell(Icon(data.electronicMeterHasBeenRead?Icons.pending_actions:Icons.check_circle,color: data.electronicMeterHasBeenRead? Colors.orange :Colors.green ,)),
                      ]);
                    }),
              
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}