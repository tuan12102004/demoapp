import 'package:appshopbread/admin/home_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool isEye = false;

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
            bottom: 120,
            left: 20,
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.46,
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
                        "Admin",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "User",
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
                        controller: userController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter Name",
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
                      "Enter pass",
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
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
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
                        loginAdmin();
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
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["username"] != userController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Your name is not correct ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else if (result.data()["password"] != passController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Your password is not correct ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin(),));
        }
      });
    });
  }
}
