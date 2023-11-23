import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/Drawer/drawer_screen.dart';
import 'package:tts/Screens/Auth/signup_screen.dart';
import 'package:tts/constant/color.dart';

import 'forgot_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final _auth = FirebaseAuth.instance;
bool loading = false;
  String? errorMessage;
  User? users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'assets/icons/signIn.png',
                  height: 200,
                  width: 200,
                  // Adjust height and width as needed
                ),

                const SizedBox(height: 20),

                Text(
                  'Welcome back',
                  style: TextStyle(
                    color: primary,
                    fontSize: 24,
                    fontFamily: 'Medium'
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Please enter your email ID or password\n                            to Sign In',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontFamily: 'Regular'
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 16),
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    
                    hintText: 'Email ID',
                    hintStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    labelText: 'Email ID',
                    labelStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    floatingLabelStyle:  TextStyle(fontFamily: 'Regular', color: primary, fontSize: 12),
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                   onSaved: (value) {
                                  emailcontroller.text = value!;
                                },
                  validator: (value) {
                   if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                                  }
                                  // reg expression for email validation
                                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                                  }
                                  return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 16),
                  controller: passwordcontroller,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    floatingLabelStyle:  TextStyle(fontFamily: 'Regular', color: primary, fontSize: 12),
                    border: OutlineInputBorder(
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  onSaved: (value) {
              passwordcontroller.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ("Password is required for login");
              }
              if (!regex.hasMatch(value)) {
                return ("Enter Valid Password(Min. 6 Character)");
              }
              return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgot()));
                      },
                      child: Text(

                        'Forgot Password',
                        style: TextStyle(
                          fontFamily: 'Bold',
                          color: primary,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: InkWell(
                    splashColor: black,
                    highlightColor: black,
                    onTap: () {
                     signIn(emailcontroller.text, passwordcontroller.text);
                    },
                    child: Container(
                      height: 51,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Center(
                        child: loading? CircularProgressIndicator(
                          color: black,
                        ):
                        Text(
                          'sign In',
                          style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: black),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: TextStyle(
                        color: white,
                        fontFamily: 'Regular',
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: primary,
                          fontFamily: 'Bold',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 void signIn(String email, String password) async {
  if (_formKey.currentState!.validate()) {
    try {
      setState(() {
        loading = true;
      });

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      setState(() {
        loading = false;
      });

      Fluttertoast.showToast(
        backgroundColor: black_900,
        textColor: white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        msg: "Login Successful",
      );

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const DrawerScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        loading = false;
      });

      String errorMessage;

      switch (error.code) {
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is incorrect.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many login attempts. Please try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined error occurred.";
      }

      Fluttertoast.showToast(
        backgroundColor: black_900,
        textColor: white,
        toastLength: Toast.LENGTH_LONG, // Use LONG for error messages
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        msg: errorMessage,
      );
    }
  }
 }
}
