import 'package:flutter/material.dart';
import 'package:tts/constant/color.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: white),
        ),
      ),
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50), // Add space for image or any other widgets

                Image.asset(
                  'assets/icons/forgot.png',
                  height: 200,
                  width: 200,
                  // Adjust height and width as needed
                ),

                const SizedBox(height: 20),

                Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: primary,
                    fontSize: 24,
                    fontFamily: 'Medium',
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Please enter your registered email\n   address to reset your password',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 16),
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    hintStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    labelText: 'Email ID',
                    labelStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    floatingLabelStyle: TextStyle(fontFamily: 'Regular', color: primary, fontSize: 12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email Address';
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                      return 'Please Enter a Valid Email Address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Implement submit logic
                      }
                    },
                    child: Container(
                      height: 51,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: black),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
