import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/Screens/Auth/login_screen.dart';
import 'package:tts/constant/color.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }

  Future<void> _loadUserData() async {
    try {
      
      User? user = FirebaseAuth.instance.currentUser;

      
      if (user != null) {
        
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance
                .collection('UsersDetails')
                .doc(user.uid)
                .get();

        
        if (userDoc.exists) {
          
          String fullName = userDoc.get('fullName');

          
          setState(() {
            userName = fullName;
          });
        } else {
          
          setState(() {
            userName = 'User not found';
          });
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading user data: $e');
    }
  }
  final youtubeUri = Uri.parse('https://www.youtube.com/channel/UCeyJ0ypQxy4iIz0Pkunc72A');
  final facebookUri = Uri.parse('https://www.facebook.com/profile.php?id=61553112280229');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 CircleAvatar(
              backgroundColor: black,
              backgroundImage: const AssetImage('assets/icons/user.png'),
             ),
             const SizedBox(width: 5),
             Text(userName, style: TextStyle(fontFamily: 'Medium', fontSize: 17, color: black),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Icon(Icons.info_outline, color: black, size: 20,),
                 const SizedBox(width: 20),
                 Text("About", style: TextStyle(fontFamily: 'SemiBold', fontSize: 16, color: black)),
                 const SizedBox(width: 30),
                Icon(Icons.arrow_drop_down_rounded, size: 20, color: black,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
               splashColor: primary,
               highlightColor: primary,
               onTap: (){
                 setState(() {
                   launchUrl(
                    youtubeUri,
                    mode: LaunchMode.externalApplication,
                   );
                 });
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                  Image.asset('assets/icons/youtube.png', height: 20, width: 20,),
                  const SizedBox(width: 20),
                  Text("YouTube", style: TextStyle(fontFamily: 'Regular', fontSize: 16, color: black)),
                 ],
               ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                splashColor: primary,
                highlightColor: primary,
                onTap: (){
                  setState(() {
                    launchUrl(
                      facebookUri,
                      mode: LaunchMode.externalApplication,
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Image.asset('assets/icons/f.png', height: 20, width: 20,),
                   const SizedBox(width: 20),
                   Text("Facebook", style: TextStyle(fontFamily: 'Regular', fontSize: 16, color: black)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Icon(Icons.contact_page_outlined, color: black, size: 20,),
                 const SizedBox(width: 20),
                 Text("Contact", style: TextStyle(fontFamily: 'SemiBold', fontSize: 16, color: black)),
                 const SizedBox(width: 30),
                Icon(Icons.arrow_drop_down_rounded, size: 20, color: black,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                splashColor: primary,
                highlightColor: primary,
                onTap: ()async{
                  encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
                 final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'picodevbusiness@gmail.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject' : '',
                    'body' : 'Hello! PicoDev'
                  }),
                 );
                 if (await canLaunchUrl(emailUri)){
                   launchUrl(
                    emailUri,
                    mode: LaunchMode.externalApplication,
                    );
                 }else{
                  throw Exception('Could not launch $emailUri');
                 }
                 
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Image.asset('assets/icons/gmail.png', height: 20, width: 20,),
                   const SizedBox(width: 20),
                   Text("Email", style: TextStyle(fontFamily: 'Regular', fontSize: 16, color: black)),
                  ],
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Icon(Icons.settings_outlined, color: black, size: 20,),
                 const SizedBox(width: 20),
                 Text("Setting", style: TextStyle(fontFamily: 'SemiBold', fontSize: 16, color: black)),
                 const SizedBox(width: 30),
                Icon(Icons.arrow_drop_down_rounded, size: 20, color: black,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                splashColor: primary,
                highlightColor: primary,
                onTap: () => _showDeleteAccountDialog(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Image.asset('assets/icons/delete.png', height: 20, width: 20,),
                   const SizedBox(width: 20),
                   Text("Delete Account", style: TextStyle(fontFamily: 'Regular', fontSize: 16, color: black)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
              child: InkWell(
                splashColor: primary,
                highlightColor: primary,
                onTap: _signOut,
                child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: primary,
                                  border: Border.all(
                                    color: black
                                  ),
                                  borderRadius: BorderRadius.circular(27),
                                  
                                ),
                                child:  Center(child: Text('Logout', style: TextStyle(fontFamily: 'SemiBold', fontSize: 16, color: black),)),
                               ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text('Developed By PicoDev', style: TextStyle(fontFamily: 'Medium', color: black),),
                ),
              ),
            )
          ],
          ),
        ),
      ),
    );

  }
  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  Fluttertoast.showToast(
    backgroundColor: black_900,
            textColor: white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
    msg: 'Logout Successful'
    );
   // ignore: use_build_context_synchronously
   Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
}
Future<void> _showDeleteAccountDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: 
          BorderRadius.circular(20),
          ),
          backgroundColor: black_900,
          title: Text("Delete Account", style: TextStyle(fontFamily: 'Medium', color: white),),
          content: Text("Are you sure you want to delete your account? This action cannot be undone.",style: TextStyle(fontFamily: 'Regular', color: white), ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No", style: TextStyle(fontFamily: 'Medium', fontSize: 15, color: primary)),
            ),
            TextButton(
              onPressed: () {
                _deleteAccount(); // Call the function to delete the account
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Yes", style: TextStyle(fontFamily: 'Medium', fontSize: 15, color: primary)),
            ),
          ],
        );
      },
    );
  }

  // Function to delete the user account and associated data in Firestore
  Future<void> _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Delete user data in Firestore
        await FirebaseFirestore.instance
            .collection('UsersDetails')
            .doc(user.uid)
            .delete();

        // Delete the user account
        await user.delete();

        // Show a toast or navigate to a different screen after successful deletion
        Fluttertoast.showToast(
          backgroundColor: black_900,
          textColor: white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          msg: 'Account Deleted Successfully',
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false,
        );
      }
    } catch (e) {
      // Handle errors
      print('Error deleting account: $e');
    }
  }
  

}