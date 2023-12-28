import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:potato/model.dart';
import 'package:potato/recipeview.dart';
import 'package:potato/searchscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<String> randomRecipeList = [
    "laddo",
    "burger",
    "pizza",
    "lemonade",
    "paratha",
    "matar paneer",
    "veg roll",
    "egg roll"
  ];

  String getRandomRecipe() {
    int randomIndex = Random().nextInt(randomRecipeList.length - 1);
    return randomRecipeList[randomIndex];
  }

  final TextStyle _AppBarFont = const TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: Color(0xffc29843));

  var searchController = TextEditingController();
  List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Spicy Food"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "South Indian"
    },
    {
      "imgUrl":
          "https://media.istockphoto.com/id/996188546/photo/assorted-indian-food-for-lunch-or-dinner-rice-lentils-paneer-dal-makhani-naan-chutney-spices.jpg?s=2048x2048&w=is&k=20&c=Z44berq859Vf5IwQK7dRje6pCNEmbHDpG1P__ZNDKUE=",
      "heading": "Punjabi"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1555126634-323283e090fa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8fDA%3D",
      "heading": "Chinese Food"
    }
  ];

  List<RecipeModel> recipeList = <RecipeModel>[];

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=e2d05329&app_key=8ceb35d8b90c0b54b3023e6b058dace2";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    response.body.toString();
    print(data);

    data['hits'].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipeList.add(recipeModel);

      setState(() {
        isLoading = false;
      });

      recipeList.toString();
    });

    recipeList.forEach((recipe) {
      print(recipe.applabel);
      print(recipe.appcalories);
    });
  }

  @override
  void initState() {
    super.initState();
    if (randomRecipeList.isNotEmpty) {
      getRecipe(getRandomRecipe());
    }
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(searchController.text)));
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
                  SizedBox(
                    height: 15,
                  ),

                  // Category container

                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    child: ListView.builder(
                        itemCount: reciptCatList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                              reciptCatList[index]
                                                  ["heading"])));
                                },
                                child: Card(
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 0.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: Image.network(
                                              reciptCatList[index]["imgUrl"],
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 250,
                                            )),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            top: 0,
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.black26,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      reciptCatList[index]
                                                          ["heading"],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28),
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    )),
                              ));
                        }),
                  ),
                  Container(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : recipeList.isEmpty
                            ? Text("no recipes found")
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: recipeList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (!mounted) {
                                    return SizedBox.shrink();
                                  }
                                  print(
                                      "RecipeList length: ${recipeList.length}, Index: $index");
                                  if (index < recipeList.length) {
                                    String calories = recipeList[index]
                                        .appcalories
                                        .toString();
                                    if (calories.length > 7) {
                                      calories = calories.substring(0, 7);
                                    }
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecipeView(
                                                          url: recipeList[index]
                                                              .appurl)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: EdgeInsets.all(15),
                                          elevation: 0.0,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
                                                        color:
                                                            Color(0xfffcdfb2),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15))),
                                                    child: Text(
                                                      recipeList[index]
                                                          .applabel,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xffc29843),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                              Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  height: 40,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .center,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xfffcdfb2),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          15))),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .local_fire_department,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    194,
                                                                    105,
                                                                    67),
                                                          ),
                                                          Text(
                                                            recipeList[index]
                                                                .appcalories
                                                                .toString()
                                                                .substring(
                                                                    0, 6),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xffc29843),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )))
                                            ],
                                          ),
                                        ));
                                  }else {
                                    return SizedBox.shrink();
                                  }
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
