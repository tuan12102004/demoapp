import 'package:appshopbread/service/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/database.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;

  getTheSadRedPref()async{
    id = await SharedPreferenceHelper().getUserId();
    setState(() {
    });
  }
  getOnTheLoad()async{
     await getTheSadRedPref();
     orderStream = await DatabaseMethods().getUserOrders(id!);
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
                  height: 160,
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
                                  Text("${ds["Status"]}!",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    color: Colors.red
                                  ),),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: size.width * 0.4,
                  right: 0,
                  child: Text(
                    "Orders",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: size.height * 0.9,
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
            ),
          ],
        ),
      ),
    );
  }
}
