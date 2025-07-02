import 'package:appshopbread/bloc/search/search_bloc.dart';
import 'package:appshopbread/models/category_model.dart';
import 'package:appshopbread/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/bread_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int selected = 0;
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
     body: SafeArea(
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: size.width,
                child: Stack(
                  children: [
                    Image.asset("assets/images/logobanhmi.png",width: 120,height: 120,),
                    Positioned(
                        top: 100,
                        left: 10,
                        right: 10,
                        child: Text("Order your favourite food!",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600
                        ),)),
                    Positioned(
                      right: 0,
                      top: 20,
                      child: IconButton(onPressed: () {
                      }, icon: Icon(Icons.camera_alt,size: 50,)),
                    )
                  ],
                ),
              ),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
               child: Row(
                 children: [
                   Container(
                     height: 50,
                     width: size.width * 0.7,
                     decoration: BoxDecoration(
                       color: Color(0xFFDCDCDC),
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(left: 8.0),
                       child: BlocBuilder<SearchBloc,SearchStates>(
                         builder: (context, state) {
                           return TextFormField(
                             controller: searchController,
                             decoration: InputDecoration(
                                 hintText: "Search food item...",
                                 border: InputBorder.none
                             ),
                             onChanged: (value) {
                               if(value.trim().isEmpty){
                                 context.read<SearchBloc>().add(SearchTextChanged(text: ''));
                               }
                             },
                           );
                         },
                       ),
                     ),
                   ),
                   SizedBox(width: 20,),
                   Container(
                     width: 50,
                     height: 50,
                     decoration: BoxDecoration(
                       color: Color(0xffef2b39),
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: IconButton(onPressed: () {
                       FocusScope.of(context).unfocus();
                       final text = searchController.text.trim();
                       context.read<SearchBloc>().add(SearchTextChanged(text: text));
                     }, icon: Icon(Icons.search,size: 35,color: Colors.white,)),
                   ),
                 ],
               ),
             ),
             SizedBox(
               height: 50,
               child: ListView.builder(
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 itemCount: Bread.breadList.length,
                 itemBuilder: (context, index) {
                 return BlocBuilder<SearchBloc,SearchStates>(
                   builder: (context, state) {
                     return GestureDetector(
                       onTap: () {
                         setState(() {
                           selected = index;
                         });
                         context.read<SearchBloc>().add(SelectedEvent(Bread.breadList[index].breadName));
                       },
                       child: Container(
                         height: 50,
                         margin: EdgeInsets.only(right: 10,left: 10),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: selected == index ? Color(0xffef2b39) : Color(0xFFDCDCDC),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                           child: Row(
                             children: [
                               Image.asset(Bread.breadList[index].imageURL,width: 40,height: 40,),
                               SizedBox(width: 10,),
                               Text(Bread.breadList[index].breadName,style: TextStyle(
                                   fontSize: 15,
                                   fontWeight: FontWeight.bold,
                                   color: selected == index ? Colors.white : Colors.black
                               ),),
                             ],
                           ),
                         ),
                       ),
                     );
                   },
                 );
               },),
             ),
             BlocBuilder<SearchBloc,SearchStates>(
                 builder: (context, state) {
                   final breads = state.selectedItem.isNotEmpty ? state.selectedItem : (state.search.isEmpty ? Breads.breadList : state.search);
                   if(state.search.isEmpty && state.messenger.isNotEmpty){
                     return Padding(
                       padding: const EdgeInsets.only(top: 58.0),
                       child: Center(child: Text(state.messenger),),
                     );
                   }
                   return SizedBox(
                     height: size.height * 0.9,
                     child: GridView.builder(
                       itemCount: breads.length,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 1,
                         mainAxisSpacing: 2,
                         childAspectRatio: 2/3,),
                       itemBuilder: (context, index) {
                         final bread = breads[index];
                         return Container(
                           height: size.height,
                           margin: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 20),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               border: Border.all(
                                 color: Colors.black87,
                                 width: 1,
                               )
                           ),
                           child: Stack(
                             children: [
                               Column(
                                 children: [
                                   Expanded(
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 10.0),
                                       child: Align(
                                         alignment: Alignment.topCenter,
                                         child: Image.asset(
                                           bread.imageURL,
                                           width: 150,
                                           height: 150,),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               Positioned(
                                   top: 150,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Container(
                                         width: 120,
                                         margin: EdgeInsets.only(right: 20,left: 10),
                                         child: Text(bread.breadName,
                                           style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 18,
                                           ),
                                           maxLines: 2,),
                                       ),
                                       Container(
                                         width: 60,
                                         height: 30,
                                         margin: EdgeInsets.only(left: 10),
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10),
                                             color: Colors.orange
                                         ),
                                         child: Center(
                                           child: Text('\$ ${bread.price}',
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 18,
                                                 color: Colors.white
                                             ),
                                             maxLines: 2,),
                                         ),
                                       ),
                                     ],
                                   )),
                               Positioned(
                                   bottom: 0,
                                   right: 0,
                                   child: Align(
                                     alignment: Alignment.bottomRight,
                                     child: GestureDetector(
                                       onTap: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => Details(bread: bread,),));
                                       },
                                       child: Container(
                                           width: 80,
                                           height: 50,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.only(topLeft:
                                               Radius.circular(40),
                                                   bottomRight: Radius.circular(20)),
                                               color: Colors.red
                                           ),
                                           child: Center(child: Icon(Icons.arrow_forward,
                                             color: Colors.white,size: 35,))
                                       ),
                                     ),
                                   )),
                             ],
                           ),
                         );
                       },),
                   );
                 },)
           ],
         ),
       ),
     ),
    );
  }
}
