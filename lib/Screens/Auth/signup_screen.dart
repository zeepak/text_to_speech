import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/Screens/Auth/login_screen.dart';
import 'package:tts/constant/color.dart';

import '../../Models/auth_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                 // Add space for image or any other widgets

                Image.asset(
                  'assets/icons/signUp.png',
                  height: 200,
                  width: 200,
                  // Adjust height and width as needed
                ),

                const SizedBox(height: 20),

                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: primary,
                    fontSize: 24,
                    fontFamily: 'Medium',
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Please enter your Email ID to Sign Up.',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 16),
                  controller: fullnameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    labelText: 'Full Name',
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onSaved: (value) {
                    fullnameController.text = value!;
                  },
                  validator: (value) {
                   RegExp regex = RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return 'Name is required for sign up';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Enter Valid Name (Min. 3 Characters)';
                    }
                    return null;
                  },
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 16),
                  controller: passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    floatingLabelStyle: TextStyle(fontFamily: 'Regular', color: primary, fontSize: 12),
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
                    passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return 'Password is required for sign up';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Enter Valid Password (Min. 6 Characters)';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 16),
                  controller: confirmPasswordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(fontFamily: 'Regular', color: black_300, fontSize: 16),
                    floatingLabelStyle: TextStyle(fontFamily: 'Regular', color: primary, fontSize: 12),
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
                    confirmPasswordController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Confirm Your Password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: InkWell(
                    onTap: () {
                     signUp(emailController.text, passwordController.text);
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
                          'Sign Up',
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
                      'Already have an account?',
                      style: TextStyle(
                        color: white,
                        fontFamily: 'Regular',
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
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
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
      setState(() {
        loading = true;
      });
      
      
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            // ignore: body_might_complete_normally_catch_error
            .catchError((e) {
          Fluttertoast.showToast(
            backgroundColor: black_900,
            textColor: white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            msg: e!.message
            );
        });
      } on FirebaseAuthException catch (error) {
         setState(() {
          loading = false;
        });
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(
          backgroundColor: black_900,
            textColor: white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          msg: errorMessage!
          );
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullnameController.text;
   
    
    await firebaseFirestore
        .collection("UsersDetails")
        .doc(user.uid)
        .set(userModel.toMap());
       Fluttertoast.showToast(
        backgroundColor: black_900,
            textColor: white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
        msg: "Create Successfully"
        );
        await _auth.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const Login()),
              (route) => false);
      setState(() {

      });

  }
}
