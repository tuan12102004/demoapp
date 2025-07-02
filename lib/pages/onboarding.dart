import 'package:flutter/material.dart';

import 'bottomnav.dart';
import 'home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 18).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: size.height * 0.5,
                width: size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70),
                  )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70),
                  ),
                  child: Image.asset(
                    "assets/images/banhmi.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/anhdaubep.png",
                height: size.height * 0.6,
              ),
              Positioned(
                left: 140,
                top: 70,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value),
                      child: Image.asset(
                        "assets/images/logohamburber.png",
                        height: 200,
                        width: 200,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 50,
                top: 415,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Chào bạn đến với\nthế giới bánh mì 🍔",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        offset: Offset(1, 2),
                        blurRadius: 2
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Text("Ở đây có ổ bánh mì nóng hổi, nhân siêu ngon, hương thơm lan tỏa – chỉ cần một chạm là có ngay trong tay, giao tận nơi cực nhanh!",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,),
          ),
          SizedBox(height: 80,),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(),));
            },
            child: Container(
              height: 60,
              width: 160,
              margin: EdgeInsets.only(left: 180 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown.shade400
              ),
              child: Center(child: Text("Get Started",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),),),
            ),
          )
        ],
      ),
    );
  }
}
