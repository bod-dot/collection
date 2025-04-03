import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';


import '../../Widgets/cusotm_text_form_in_tack_new_reanding.dart';
import '../../Widgets/custom_button.dart';
import '../../helper/constans.dart';

//this

class TakeReadingScreen extends StatefulWidget {
  const TakeReadingScreen({super.key, required this.qrCode, required this.reading});
  final int qrCode ;
  final int reading;
  static String id='ReadingScreen';

  @override
  State<TakeReadingScreen> createState() => _TakeReadingScreenState();
}

class _TakeReadingScreenState extends State<TakeReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  TextEditingController qrCode = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController reading = TextEditingController();
  @override
  void initState() {
      qrCode.text=widget.qrCode.toString();
    reading.text=widget.reading.toString();
    setState(() {
      
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      title:const  Text(
        'أخذ قراءة جديدة ⚡',
        style:  TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
      backgroundColor: kColorPrimer, // تغيير هنا
      body: AnimationLimiter(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: AnimationConfiguration.staggeredList(
                position: 0,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Column(
                      children: [
                        
                        const SizedBox(height: 40),
                      Lottie.asset(
                            'asset/animations/electric.json',
                           width: 150,
                         repeat: true,
                                ),
                        const SizedBox(height: 30),
                         Cusotmtextformintacknewreanding(
                          label: 'رقم العداد',
                          icon: Icons.flash_on_outlined,
                          text: qrCode,
                          isEnable: false,
                        ),
                       const  SizedBox(height: 25),
                        Cusotmtextformintacknewreanding(
                          label: 'اسم العميل',
                          icon: Icons.person_outline,
                          validator: (v) => v!.isEmpty ? 'أدخل اسم العميل' : null,
                          text: name,
                          isEnable: false,
                        ),
                        const SizedBox(height: 25),
                        Cusotmtextformintacknewreanding(
                          label: 'القراءة الحالية',
                          icon: Icons.speed_outlined,
                          textInputType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'أدخل القراءة' : null,
                          text: reading,
                          isEnable: false,
                        ),
                        const SizedBox(height: 40),
                        Custombutton(isLoading: _isSending, onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isSending = true);
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() => _isSending = false);
                            });
                          }
                        }, lable: "ارسال القراءة",color: kColorSecond,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


 

}