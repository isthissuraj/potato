import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:potato/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle _AppBarFont = const TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: Color(0xffc29843));

  var searchController = TextEditingController();

  List<RecipeModel> recipeList = <RecipeModel>[];

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=e2d05329&app_key=8ceb35d8b90c0b54b3023e6b058dace2";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    log(response.body.toString());
    print(data);

    data['hits'].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipeList.add(recipeModel);
      log(recipeList.toString());
    });

    recipeList.forEach((recipe) {
      print(recipe.applabel);
      print(recipe.appcalories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffae9c4),
        centerTitle: true,
        title: Text("Potato", style: _AppBarFont),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Color(0xfffae9c4)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("blank search");
                            } else {
                              getRecipe(searchController.text);
                            }
                          },
                          child: Container(
                            // ignore: sort_child_properties_last
                            child: const Icon(
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
                                border: InputBorder.none,
                                hintText: "You look Hungry!",
                                hintStyle: TextStyle(color: Color(0xfff0c694))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What do you want to cook?",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffc29843)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Let's cook somethig....",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffc29843)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recipeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.all(15),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        recipeList[index].appimgurl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Color(0xfffcdfb2),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15))),
                                          child: Text(
                                            recipeList[index].applabel,
                                            style: const TextStyle(
                                                color: Color(0xffc29843),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        height: 40,
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Color(0xfffcdfb2),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15))),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.local_fire_department,
                                                  color: Color.fromARGB(
                                                      255, 194, 105, 67),
                                                ),
                                                Text(
                                                  recipeList[index]
                                                      .appcalories
                                                      .toString()
                                                      .substring(0, 7),
                                                  style: const TextStyle(
                                                      color: Color(0xffc29843),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )))
                                  ],
                                ),
                              ));
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
