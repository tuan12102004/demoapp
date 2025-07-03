import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/database.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({super.key});

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  getOnTheLoad()async{
    orderStream = await DatabaseMethods().getAdminOrders();
    setState(() {
    });
  }
@override
  void initState() {
    // TODO: implement initState
  getOnTheLoad();
    super.initState();
  }
  Stream? orderStream;
  Widget allOrders() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print("📦 Tổng số đơn hàng: ${snapshot.data.docs.length}");
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              print("🔥 Order: ${ds.data()}");
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0,left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_outlined, color: Colors.red),
                                SizedBox(width: 2),
                                Text(ds["Address"],style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),)
                              ],
                            ),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Image.asset(ds["FoodImage"], width: 100, height: 100),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(ds["FoodName"],style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                  Row(
                                    children: [
                                      Icon(Icons.menu,color: Colors.red,),
                                      Text(ds["Quantity"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),),
                                      SizedBox(width: 30,),
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.red
                                        ),
                                        child: Center(child: Icon(Icons.attach_money,color: Colors.white,size: 20,),),
                                      ),
                                      SizedBox(width: 20,),
                                      Text("\$${ds["Total"]}",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),), // chắc chắn là String hoặc convert
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text(ds["Name"]),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.mail),
                                      Text(ds["Email"]),
                                    ],
                                  ),
                                  Text("${ds["Status"]}!",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red
                                  ),),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods().updateAdminOrders(ds.id);
                                      await DatabaseMethods().updateUserOrders(ds["Id"], ds.id);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black
                                      ),
                                      child: Center(
                                        child: Text("Delivered",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                          top: 4,
                          right: 0,
                          child:  Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red
                            ),
                            child: IconButton(
                                onPressed: () {
                                  ds.reference.delete();
                                }, icon: Icon(Icons.clear,color: Colors.white,)),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("Không có đơn hàng nào."));
        }
      },
    );
  }
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
                  child: allOrders(),
                ),
              ),
            ],
          )),
    );
  }
}
