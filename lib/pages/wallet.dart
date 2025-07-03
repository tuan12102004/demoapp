import 'package:appshopbread/service/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import '../service/database.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _State();
}

class _State extends State<Wallet> {
  Map<String, dynamic>? paymentIntent;
  String? email, wallet, id;
  TextEditingController addMoney = TextEditingController();

  getTheSharedpref() async {
    email = await SharedPreferenceHelper().getUserEmail();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  getUserWallet() async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserWalletByEmail(
      email!,
    );
    walletStream = await DatabaseMethods().getUserTransactions(id!);
    wallet = "${querySnapshot.docs[0]["wallet"]}";
    print(wallet);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    addMoney.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getTheSharedpref().then((_) {
      if (email != null) {
        getUserWallet();
      } else {
        print("⚠️ Không tìm thấy email từ SharedPreferences");
      }
    });
  }
  Stream? walletStream;
  Widget allOrders() {
    return StreamBuilder(
      stream: walletStream,
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
                child:  Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(ds["Date"],style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            Text("Account added to wallet"),
                            Text("\$"+ds["Amount"],style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.red
                            ),),
                          ],
                        )
                      ],
                    ),
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
      body:
          wallet == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
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
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 160,
                          left: 20,
                          child: Container(
                            height: 120,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/logomoney.png",
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your Wallet",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      wallet != null
                                          ? "\$" + wallet!
                                          : "Loading...",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 300,
                          left: 20,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  makePayment("50");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\$50",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  makePayment("100");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\$100",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  makePayment("200");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "\$200",
                                      style: TextStyle(
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
                        Positioned(
                          top: 390,
                          left: 80,
                          child: GestureDetector(
                            onTap: () {
                              openBox();
                            },
                            child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 1),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  "Add Money",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.43,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // ✅ Thêm padding
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Transactions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                ),
                                Expanded(
                                  child: allOrders(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: "App Shop Bread",
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print("Lỗi khác: $e$s");
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            int updateWallet = int.parse(wallet!) + int.parse(amount);
            await DatabaseMethods().updateUserWallet(
              updateWallet.toString(),
              id!,
            );
            await getUserWallet();
            setState(() {

            });
            DateTime now = DateTime.now();
            String formattedDate = DateFormat("dd MMM").format(now);
            Map<String,dynamic> userTransactions = {
              "Amount" : amount,
              "Date" : formattedDate,
            };
            await DatabaseMethods().addUserTransactions(userTransactions,id!);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          Text("Payment Successful"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            print("Lỗi: ----> $error $stackTrace");
          });
    } on StripeException catch (e) {
      print("Error is : -----> $e");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("Cancelled"));
        },
      );
    } catch (e) {
      print("Lỗi $e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Dio dio = Dio();

      int amountInCents = (double.parse(amount) * 100).toInt();

      print("📦 Gửi đến Stripe:");
      print("  👉 amount (cents): $amountInCents");
      print("  👉 currency: $currency");

      final data = {
        'amount': amountInCents.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          headers: {
            'Authorization':
                'Bearer sk_test_51RfYGZ2E8Xmt3KGCVgXqfxffqcdLK91sgQzQnjR8XFwuXW0qROSXMyeOEqLfLAVZHzMOCeVgZTadfWkQFO1ntvBC00AAoaMlcO',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      print("✅ Stripe trả về: ${response.data}");
      return response.data;
    } catch (e) {
      print('❌ createPaymentIntent error: $e');
      rethrow;
    }
  }

  Future openBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Icon(Icons.close, color: Colors.white)),
                ),
              ),
              SizedBox(width: 25),
              Text(
                "Add the Money",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add money"),
                SizedBox(height: 10),
                TextFormField(
                  controller: addMoney,
                  decoration: InputDecoration(
                    hintText: "Money...",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    makePayment(addMoney.text);
                    setState(() {
                      addMoney.text = "";
                    });
                  },
                  child: Center(
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal,
                      ),
                      child: Center(child: Text("Add", style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
