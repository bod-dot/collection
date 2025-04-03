import 'package:flutter/material.dart';


import '../helper/constans.dart';
//this
class Customtextfrom extends StatelessWidget {
  const  Customtextfrom({super.key,  this.obscureText=false ,required this.label, this.onPressed,required this.icon,this.isPassword=false, this.textInputType, required this.textEditingController});
final  bool obscureText ;
final String label;
final bool ? isPassword;
final Icon icon;
final  VoidCallback ?onPressed;
final TextInputType? textInputType;
final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:textInputType ,

      controller: textEditingController,
      obscureText: obscureText,
      
      decoration: InputDecoration(
        labelText: label,
        labelStyle:const  TextStyle(
          color: kColorPrimer,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: icon,
        suffixIcon: isPassword!?IconButton(
          icon: Icon(
            obscureText? Icons.visibility_off : Icons.visibility,
            color: kColorPrimer,
          ),
          onPressed: onPressed,
        ): null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:const BorderSide(color: kColorPrimer, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
      style: const TextStyle(
        color: kColorPrimer,
        fontWeight: FontWeight.w600,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return ' $label مطلوب';
       if(isPassword??false)
       {
         if (value.length < 6) return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
       }
        return null;
      },
    );
  }
}

