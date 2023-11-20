import 'package:flutter/material.dart';
import 'package:tts/constant/color.dart';

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
                      if (_formKey.currentState!.validate()) {
                        // Implement sign up logic
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
}
