import 'package:appshopbread/pages/bottomnav.dart';
import 'package:appshopbread/pages/login/singup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../onboarding.dart';


class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  bool isEye = false;
  String email = "",
      password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  userLogin() async {
      try {
      await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Onboarding(),));
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.orangeAccent,
                  content: Text("NO user Found for that Email",
                    style: TextStyle(
                        fontSize: 18
                    ),)));
        } else if(e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.orangeAccent,
                  content: Text("Wrong Password Provided by user",
                    style: TextStyle(
                        fontSize: 18
                    ),)));
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
    Size size = MediaQuery
        .of(context)
        .size;
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
              "assets/images/logosingup.png",
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
                        "Đăng nhập",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Quên mật khẩu?", style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if(emailController.text != "" && passController.text != ""){
                          setState(() {
                            email = emailController.text;
                            password = passController.text;
                          });
                          userLogin();
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
                          child: Text("Login",
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
                            child: Text("Bạn chưa có tài khoản?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                              ),),
                          ),
                          SizedBox(width: 2),
                          TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SingUp(),));
                          }, child: Text("Đăng ký", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,
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
