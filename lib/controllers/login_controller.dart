import 'package:shared_preferences/shared_preferences.dart';

import '../helper/api_my.dart';



class LoginContrloller

{

  Future<bool> loginMeth({required int phoneNumber,required String passwrod})
 async {
  Map<String,dynamic> data= await Api().post(url: "LoginColl.php", body: {
   
    'PhoneNumber':'$phoneNumber',
    "password":passwrod
  });
  bool isLogin=data['message']=='No data found';
  if(!isLogin)
  {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String employeeID = data['EmployeeID'].toString();
    String employeeName = data['EmployeeName'];
   
    shared.setString("EmployeeID", employeeID);
    shared.setString("EmployeeName", employeeName);

  }

  return isLogin;


  }

}