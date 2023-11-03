import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextStyle _AppBarFont =
  const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 32, color: Color(0xffc29843));

  var searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffae9c4),
        centerTitle: true,
        title: Text("Potato",style: _AppBarFont),
      ),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xfffae9c4)),
          ),
          SafeArea(
            child: Column(
              
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if((searchController.text).replaceAll(" ", "") == ""){
                            print("blank search");
                          }else{
                            Navigator.pushReplacementNamed(context, "/loading",arguments: {
                              "searchText" : searchController.text,
                            });
                          }

                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Color(0xffc29843),
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "You look Hungry!", hintStyle:TextStyle(color: Color(0xfff0c694))),
                        ),
                      )
                    ],
                  ),
                ),
                Container(

                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("What do you want to cook?", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Color(0xffc29843)),),
                      SizedBox(height: 10,),
                      Text("Let's cook somethig....", style: TextStyle( fontSize: 20, color: Color(0xffc29843)),)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
