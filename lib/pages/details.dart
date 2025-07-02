import 'package:appshopbread/service/database.dart';
import 'package:appshopbread/service/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:random_string/random_string.dart';
import '../bloc/products/products_bloc.dart';
import '../models/bread_model.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.bread});

  final Breads bread;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  bool position = false;
  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController containerController;
  late Animation<double> containerAnimation;
  Map<String, dynamic>? paymentIntent;
  String? name, id, email, address, wallet;
  int quantity = 1, totalPrice = 0;
  getUserWallet() async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserWalletByEmail(
      email!,
    );
    wallet = "${querySnapshot.docs[0]["wallet"]}";
    print(wallet);
    setState(() {});
  }

  getTheSharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    id = await SharedPreferenceHelper().getUserId();
    email = await SharedPreferenceHelper().getUserEmail();
    address = await SharedPreferenceHelper().getUserAddress();
    print(name);
    print(id);
    print(email);
    setState(() {});
  }

  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalPrice = int.parse(widget.bread.price.toString());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTheSharedpref();     // 📌 Lấy email xong đã
      await getUserWallet();        // 📌 Sau đó mới lấy wallet
      setState(() {
        position = true;
      });
    });

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    containerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }


  @override
  void dispose() {
    animationController.dispose();
    containerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 260,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: Listenable.merge([animation, containerController]),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: animation.value + 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                            // changes position of shadow
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AnimatedPositioned(
              top: position ? 30 : -200,
              left: 0,
              right: 0,
              duration: Duration(seconds: 1),
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, animation.value),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        widget.bread.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.red,
                  ),
                  child: Icon(Icons.arrow_back, size: 30, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 330,
              left: 20,
              child: Row(
                children: [
                  Text(
                    widget.bread.breadName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(width: 100),
                  Text(
                    "\$${widget.bread.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 370,
              left: 20,
              child: Row(
                children: [
                  Text("Để nguội dần từ: ", style: TextStyle(fontSize: 16)),
                  Text(
                    "${widget.bread.recommendedHeatingTemperature}°C là ngon nhất",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 400,
              left: 20,
              child: Row(
                children: [
                  Text("Thời gian chế biến: ", style: TextStyle(fontSize: 16)),
                  Text(
                    "${widget.bread.servingTemperatureCelsius} phút",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 430,
              left: 20,
              child: Row(
                children: [
                  Text("Kích thước: ", style: TextStyle(fontSize: 16)),
                  Text(
                    "${widget.bread.servingTemperatureCelsius}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: 120),
                  Text("Đánh giá: ", style: TextStyle(fontSize: 16)),
                  Text(
                    "${widget.bread.rating}⭐",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 460,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.bread.description,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 23,
              child: SizedBox(
                height: 60,
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<ProductsBloc, ProductsStates>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductsBloc>().add(
                              RemoveProducts(products: widget.bread),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 15),
                    BlocBuilder<ProductsBloc, ProductsStates>(
                      builder: (context, state) {
                        final product = state.products.firstWhere((element) {
                          return element.breadId == widget.bread.breadId;
                        }, orElse: () => widget.bread.copyWith(quantity: 1));
                        return Text(
                          "${product.quantity}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 15),
                    BlocBuilder<ProductsBloc, ProductsStates>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductsBloc>().add(
                              AddProducts(products: widget.bread),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 40,
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: BlocBuilder<ProductsBloc, ProductsStates>(
                  builder: (context, state) {
                    final product = state.products.firstWhere(
                      (element) => element.breadId == widget.bread.breadId,
                      orElse: () => widget.bread.copyWith(quantity: 1),
                    );
                    final totalPrice = product.price * product.quantity;
                    return Center(
                      child: Text(
                        "\$$totalPrice",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 40,
              child: GestureDetector(
                onTap: () async {
                  final product = context.read<ProductsBloc>().state.products.firstWhere(
                        (element) => element.breadId == widget.bread.breadId,
                    orElse: () => widget.bread.copyWith(quantity: 1),
                  );
                  int actualQuantity = product.quantity;
                  int actualTotal = product.price * actualQuantity;

                  if (address == null || address!.isEmpty) {
                    bool success = await openBox(); // Chờ nhập địa chỉ
                    if (!success) return;
                  }
                  // 👉 Kiểm tra ví và trừ tiền
                  if (int.parse(wallet!) >= actualTotal) {
                    String orderId = randomAlphaNumeric(10);
                    int updateWallet = int.parse(wallet!) - actualTotal;

                    await DatabaseMethods().updateUserWallet(updateWallet.toString(), id!);

                    Map<String, dynamic> userOrderMap = {
                      "Name": name,
                      "Id": id,
                      "Quantity": actualQuantity,
                      "Total": actualTotal,
                      "Email": email,
                      "FoodName": widget.bread.breadName,
                      "FoodImage": widget.bread.imageURL,
                      "orderId": orderId,
                      "Status": "Pending",
                      "Address": address ?? addressController.text,
                    };

                    await DatabaseMethods().addUserOrderDetail(userOrderMap, id!, orderId);
                    await DatabaseMethods().addAdminOrderDetail(userOrderMap, orderId);

                    // ✅ Cập nhật lại local wallet
                    wallet = updateWallet.toString();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Order Placed Successful", style: TextStyle(fontSize: 18)),
                      ),
                    );
                    context.read<ProductsBloc>().add(
                      ResetProductQuantity(products: widget.bread),
                    );

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Add some money to your wallet", style: TextStyle(fontSize: 18)),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 60,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
        String orderId = randomAlphaNumeric(10);

        // 🔧 Lấy dữ liệu sản phẩm từ Bloc
        final product = context.read<ProductsBloc>().state.products.firstWhere(
              (element) => element.breadId == widget.bread.breadId,
          orElse: () => widget.bread.copyWith(quantity: 1),
        );
        int actualQuantity = product.quantity;
        int actualTotal = product.price * actualQuantity;



        // 🧾 Tạo đơn hàng
        Map<String, dynamic> userOrderMap = {
          "Name": name,
          "Id": id,
          "Quantity": actualQuantity,
          "Total": actualTotal,
          "Email": email,
          "FoodName": widget.bread.breadName,
          "FoodImage": widget.bread.imageURL,
          "orderId": orderId,
          "Status": "Pending",
          "Address": address ?? addressController.text,
        };

        await DatabaseMethods().addUserOrderDetail(userOrderMap, id!, orderId);
        await DatabaseMethods().addAdminOrderDetail(userOrderMap, orderId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Order Placed Successful", style: TextStyle(fontSize: 18)),
          ),
        );

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text("Payment Successful"),
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

  Future<bool> openBox() async {
    bool result = false;
    await showDialog(
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
                "Add the Address",
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add Address"),
                SizedBox(height: 10),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Address...",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      final enteredAddress = addressController.text.trim();
                      if (enteredAddress.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Vui lòng nhập địa chỉ")),
                        );
                        return;
                      }
                      address = enteredAddress;
                      Navigator.pop(context);
                      result = true;
                    },
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text("Add", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }
}
