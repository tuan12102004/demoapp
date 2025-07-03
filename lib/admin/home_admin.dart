import 'package:appshopbread/admin/all_order.dart';
import 'package:appshopbread/admin/manage_users.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}
class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                      ),
                      child: Icon(Icons.arrow_back,color: Colors.white,),
                    ),
                    SizedBox(width: 80,),
                    Text("All Orders",style: TextStyle(
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
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        margin: EdgeInsets.only(top: 80),
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/manage_orders.png",),
                            SizedBox(width: 20,),
                            Text("Manage \nOrders",style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 25,),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AllOrder(),));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.red
                                ),
                                child: Center(
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 140,
                        margin: EdgeInsets.only(top: 40),
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/manage_users.png",),
                            SizedBox(width: 20,),
                            Text("Manage \nUsers",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 25,),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUsers(),));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.red
                                ),
                                child: Center(
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
