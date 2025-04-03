
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_tayrd/Views/Pages/Widgets/my_droup_down.dart';
import 'package:this_is_tayrd/controllers/area_controller.dart';



import '../cubit/login_cubit/login_cubit.dart';
import '../helper/constans.dart';
import '../models/ares.dart';
import 'custom_button.dart';
import 'custom_text_from.dart';
//this
class BuildLoginFormLogin extends StatefulWidget {
  const BuildLoginFormLogin({super.key});

  @override
  State<BuildLoginFormLogin> createState() => _BuildLoginFormLoginState();
}

class _BuildLoginFormLoginState extends State<BuildLoginFormLogin> {
  TextEditingController area = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController passwrod = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool check = true;
  List<Area> areaList=[];
  @override
  void initState() {
    super.initState();
   getArea();
   
  
  }
  void getArea()
 async {
  areaList=await AreaController().getArea(context);
   setState(() {
    
  });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
         areaList.isNotEmpty ?Mydropdown(areaList: areaList) :const  SizedBox.shrink(),
            const SizedBox(height: 20),
            Customtextfrom(
              label: "رقم الهاتف",
              icon: const Icon(Icons.phone_android, color: kColorPrimer),
              textEditingController: phoneNumber,
              textInputType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Customtextfrom(
              isPassword: true,
              obscureText: check,
              onPressed: () {
                setState(() {
                  check = !check;
                });
              },
              label: "كلمة السر",
              icon: const Icon(
                Icons.lock_open_outlined,
                color: kColorPrimer,
              ),
              textEditingController: passwrod,
            ),
            const SizedBox(height: 30),
            BlocBuilder<LoginCubitCubit,LoginState>(
              builder: (context, state) {
                return Custombutton(
                    isLoading: state is LoginLoding ,
                    lable: 'تسجيل الدخول',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubitCubit>(context).loginCub(
                           
                            phoneNumber: int.parse(phoneNumber.text),
                            passwrod: passwrod.text);
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
