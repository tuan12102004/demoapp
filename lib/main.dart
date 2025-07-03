import 'package:appshopbread/admin/admin_login.dart';
import 'package:appshopbread/bloc/products/products_bloc.dart';
import 'package:appshopbread/pages/bottomnav.dart';
import 'package:appshopbread/pages/details.dart';
import 'package:appshopbread/pages/home.dart';
import 'package:appshopbread/pages/login/singin.dart';
import 'package:appshopbread/pages/login/singup.dart';
import 'package:appshopbread/pages/onboarding.dart';
import 'package:appshopbread/pages/order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'admin/all_order.dart';
import 'admin/home_admin.dart';
import 'admin/manage_users.dart';
import 'bloc/search/search_bloc.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51RfYGZ2E8Xmt3KGCHFRSiYIm83ACeAFoN1ilBzNUBT2N6kfF2i6IfWQsL9NQEMNUGfbQv0XRtJ0b8N58bxMSTPSq00terpMZPT';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(
      MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => SearchBloc()),
      BlocProvider(create: (context) => ProductsBloc()),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNav(),
      ),
  ));
}