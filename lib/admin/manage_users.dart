import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/database.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  Stream? userStream;
  getOnTheLoad() async {
    userStream = await DatabaseMethods().getAllUsers();
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    getOnTheLoad();
    super.initState();
  }
  Widget allUsers() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, AsyncSnapshot snapshot) {
        Size size = MediaQuery.of(context).size;
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              print("🔥 Số người là: ${ds.data()}");
              return Column(
                children: [
                  Container(
                    width: size.width * 0.9,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/images/robot.png"),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person,color: Colors.red,),
                                Text(ds["name"])
                              ],
                            ),
                            SizedBox(height: 7,),
                            Row(
                              children: [
                                Icon(Icons.mail,color: Colors.red,),
                                Text(ds["email"])
                              ],
                            ),
                            SizedBox(height: 7,),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().deleteUser(ds["id"]);
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black
                                ),
                                child: Center(
                                  child: Text("Remove",style: TextStyle(
                                      color: Colors.white,fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("Không có người nào cả."));
        }
      },
    );
  }
  @override
  Widget build(BuildContext context){
  Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        child: Icon(Icons.arrow_back,color: Colors.white,),
                      ),
                    ),
                    SizedBox(width: 80,),
                    Text("Current Users",style: TextStyle(
                        fontSize: 28,fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )
                  ),
                  child: allUsers(),
                ),
              ),
            ],
          )),
    );
  }
}
