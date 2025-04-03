import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


import '../helper/constans.dart';
//this

class Cusotmtextformintacknewreanding extends StatelessWidget {
   const Cusotmtextformintacknewreanding({super.key, required  this.label, required this.icon,  this.textInputType,this.validator,this.isEnable=true, required this.text});
 final String label;
    final IconData icon;
   final TextInputType ?textInputType;
   final String? Function(String?)? validator;
  final  bool isEnable;
  final TextEditingController text ;
  
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: TextFormField(
            
            controller: text,
            enabled:isEnable ,
            style:const  TextStyle(color: Colors.white),
            keyboardType: textInputType,
            validator: validator,
            decoration: InputDecoration(
              labelText: label,
            
              labelStyle:const  TextStyle(color: kColorThreed),
              prefixIcon: Icon(icon, color: Colors.amber),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isEnable?Colors.white.withOpacity(0.1):Colors.grey.withOpacity(0.1),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }
}