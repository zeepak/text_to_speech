import 'package:flutter/material.dart';
import 'package:tts/Screens/Auth/login_screen.dart';
import 'package:tts/constant/color.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 100), // Add space for image or any other widgets

              Image.asset(
                'assets/icons/verify.png',
                height: 200,
                width: 200,
                // Adjust height and width as needed
              ),

              const SizedBox(height: 20),

              Text(
                'We have just sent an email verification link\nto your email. Please check your email and\nclick on that link to verify your email address',
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                  fontFamily: 'Regular',
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'After verification, click on the\n           Continue button',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontFamily: 'Regular',
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: InkWell(
                  onTap: () {
                    // Implement continue logic
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
                        'Continue',
                        style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: black),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  // Implement resend email link logic
                },
                child: Text(
                  'Resend Email Link',
                  style: TextStyle(
                    color: primary,
                    fontFamily: 'Bold',
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, 
                  MaterialPageRoute(builder: (context) => const Login()),
                   (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_rounded, color: primary),
                    Text(
                      'Back to Login',
                      style: TextStyle(
                        color: primary,
                        fontFamily: 'Bold',
                        fontSize: 16,
                      ),
                    ),
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
