
import 'package:this_is_tayrd/helper/api_my.dart';

class CheckPermissions
{
Future<List<int>> checkPermissionsMeth({required int areaId,required String employeeID })
async {

     dynamic data = await Api().post(url: "Check_Permissions.php", body: {

      "AreaID":'$areaId',
    "EmployeeID":employeeID
     });
    List<int>result=[];
    result.add(data['PermissionStatus']);
    result.add(data['isDataofCollection']);

     return result;

}
}