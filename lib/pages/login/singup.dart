import 'package:appshopbread/pages/login/singin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../../service/database.dart';
import '../../service/shared_preferences.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
   bool isEye = false;
   String email = "",
       password = "",
       name = "";
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController passController = TextEditingController();

   registration() async {
     if (password != null && nameController.text != "" &&
         emailController.text != "") {
       try {
         UserCredential userCredential = await FirebaseAuth.instance
             .createUserWithEmailAndPassword(email: email, password: password);
         String Id = randomAlphaNumeric(10);
         Map<String,dynamic> userInfoMap = {
           "id": Id,
           "name": nameController.text,
           "email": emailController.text,
           "passs": passController.text,
           "wallet" : "0",
         };
         await SharedPreferenceHelper().saveUserEmail(email);
         await SharedPreferenceHelper().saveUserName(nameController.text);
         await SharedPreferenceHelper().saveUserId(Id);
         await DatabaseMethods().addUserDetail(userInfoMap, Id);
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                 backgroundColor: Colors.green,
                 content: Text("Registered Successfully",
                   style: TextStyle(
                       fontSize: 18
                   ),)));
         Navigator.push(context, MaterialPageRoute(builder: (context) => SingIn(),));
       } on FirebaseAuthException catch (e) {
         if (e.code == "weak-password") {
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                   backgroundColor: Colors.orangeAccent,
                   content: Text("Password provided is too weak",
                     style: TextStyle(
                         fontSize: 18
                     ),)));
         } else if(e.code == "email-already-in-use") {
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                   backgroundColor: Colors.orangeAccent,
                   content: Text("Email is already in use",
                     style: TextStyle(
                         fontSize: 18
                     ),)));
         }
       }
     }
   }
   @override
  void initState() {
      isEye = false;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: Colors.orange.withAlpha(50),
                ),
              ),
            ],
          ),
          Positioned(
            left: 120,
            bottom: 550,
            child: Image.asset(
              "assets/images/logosingin.png",
              width: size.width * 0.4,
              height: size.height * 0.4,
            ),
          ),
          Positioned(
            top: 70,
            left: 80,
            child: Image.asset(
              "assets/images/logochu.png",
              width: size.width * 0.6,
              height: size.height * 0.4,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black45, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Đăng ký tài khoản",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Tên đăng nhập",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Nhập tên",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color(0xFFEEEEEE),
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Nhập Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color(0xFFEEEEEE),
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pass",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: passController,
                        style: TextStyle(color: Colors.black),
                        obscureText: isEye ? false : true,
                        decoration: InputDecoration(
                          hintText: "Nhập Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                              onPressed: () {
                               setState(() {
                                 isEye = !isEye;
                               });
                          }, icon: Icon(Icons.remove_red_eye)),
                          filled: true,
                          fillColor: Color(0xFFEEEEEE),
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                         if(nameController.text != "" && emailController.text != "" && passController.text != ""){
                           setState(() {
                             name = nameController.text;
                             email = emailController.text;
                             password = passController.text;
                           });
                           registration();
                         }
                      },
                      child: Container(
                        height: 60,
                        width: 140,
                        margin: EdgeInsets.only(left: 90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Text("Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        children: [
                          Center(
                            child: Text("Do you have a account?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                              ),),
                          ),
                          SizedBox(width: 2),
                          TextButton(onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => SingIn(),));
                          }, child: Text("Login",style: TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
