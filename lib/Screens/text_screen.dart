import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/Screens/home_screen.dart';
import 'package:tts/constant/color.dart';

class TextScreen extends StatefulWidget {
 
  const TextScreen({super.key, });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {

  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _currentLength = 0;
  DateTime? currentBackPressTime;
  

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.4;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
        backgroundColor: black,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
         final zoomdrawer = ZoomDrawer.of(context);
         zoomdrawer?.open();
          },
          icon: Icon(Icons.menu, color: white,),
        )
      ),

        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 100),
                   child: Text("Welcome!", style: TextStyle(fontFamily: 'Bold', fontSize: 28, color: primary),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 5),
                   child: Text('Please enter your text to convert\n                   into speech', style: TextStyle(fontFamily: 'Regular', fontSize: 18, color: white),),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                   child: Container(
                    height: containerHeight,
                    decoration: BoxDecoration(
                    color: black_900,
                   borderRadius: BorderRadius.circular(10.0),
                       ),
                     child: Stack(
                       children: [
                         TextFormField(
                          
                            onChanged: (text) {
                                 
                                  setState(() {
                                   _currentLength = text.length;
                                 });
                                 
                               },
                             controller: _textEditingController,
                             
                             maxLines: null, // Allow unlimited lines
                             maxLength: 1000, // Set the maximum character limit
                             validator: (value){
                              if (value!.isEmpty) {
                              return ("Please enter text");
                                    }
                                    if(_textEditingController.text.length < 5){
                                      return ('Please enter at least 5 characters');
                                    }
                                    return null;
                             },
                             cursorColor: primary,
                             style: TextStyle(color: white, fontFamily: 'Regular', fontSize: 16),
                             decoration: InputDecoration(
                               
                               filled: true,
                               
                               fillColor: black_900,
                               hintText: 'Your Text',
                               hintStyle: TextStyle(color: black_300,fontFamily: 'Regular', fontSize: 16),
                               
                               border: OutlineInputBorder(
                                 borderSide: BorderSide(color: black_900),
                                 borderRadius: BorderRadius.circular(10.0),
                               ),
                               errorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: black_900),
                                 borderRadius: BorderRadius.circular(10.0),
                               ),
                               focusedErrorBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: black_900),
                                 borderRadius: BorderRadius.circular(10.0),
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: black_900),
                                 borderRadius: BorderRadius.circular(10.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: black_900),
                                 borderRadius: BorderRadius.circular(10.0),
                               ),
                               counterText: '', // Empty counterText
                               
                             ),
                           ),
                           Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_currentLength/1000',
                    style: TextStyle(color: black_500, fontFamily: "Regular", fontSize: 10),
                  ),
                ),
                           ),
                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 70, right: 70, top: 30),
                   child: InkWell(
                    splashColor: black,
                    highlightColor: black,
                    onTap: ()async{
                      
                      if (_formKey.currentState!.validate()) {
                      String text = _textEditingController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TextToSpeechApp(text: text),
                      ),
                    );
                      }
                    },
                     child: Container(
                            height: 51,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(27),
                              
                            ),
                            child:  Center(child: Text('Next', style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: black),)),
                           ),
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        
        msg: 'Double press back to close',
        backgroundColor: black_900,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }
}