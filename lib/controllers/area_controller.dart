import 'dart:async';
import 'package:flutter/widgets.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_tayrd/cubit/login_cubit/login_cubit.dart';
import 'package:this_is_tayrd/helper/api_my.dart';
import 'package:this_is_tayrd/models/ares.dart';

class AreaController
{
 

Future<List<Area>> getArea(BuildContext context)
async{
 bool check=await BlocProvider.of<LoginCubitCubit>(context).checkInternert();
 if(check){
  List<dynamic> data =await Api().get(url: 'GetAllArea.php');
  List<Area> areaList=[];
  for(int i=0;i<data.length;i++)
  {
    areaList.add(Area.factory(jsonData: data[i]));
  }
  return areaList;
 }
 return [];
}

}