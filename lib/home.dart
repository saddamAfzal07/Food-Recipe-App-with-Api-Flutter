import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipi/model.dart';
import 'package:food_recipi/search.dart';
import 'package:http/http.dart';

import 'Recipedetails.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List category = [
    {
      "picurl":
          "https://images.unsplash.com/photo-1603496987351-f84a3ba5ec85?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80",
      "heading": "Desi Food",
    },
    {
      "picurl":
          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
      "heading": "Delicious Food",
    },
    {
      "picurl":
          "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fGRlc2klMjBmb29kfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      "heading": "Creamy food",
    },
    {
      "picurl":
          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
      "heading": "Delicious Food",
    },
    {
      "picurl":
          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
      "heading": "Delicious Food",
    },
  ];
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchcontroller = new TextEditingController();
  String url =
      "https://api.edamam.com/search?q=chicken&app_id=d24e5d64&app_key=51df1bac16cc1471acb6539f36f66cb4";
  getrecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=d24e5d64&app_key=51df1bac16cc1471acb6539f36f66cb4";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = new RecipeModel();
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);
        log(recipeList.toString());
        isLoading = false;
      });
      recipeList.forEach((element) {
        print(element.applabel);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    print("App start");
    getrecipe("Chicken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff213A50),
              Color(0xff071938),
            ])),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if ((searchcontroller.text)
                                        .replaceAll(" ", "") ==
                                    "") {
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              search(searchcontroller.text)));
                                }
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchcontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Any Recipe",
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WHAT DO YOU WANT TO COOK TODAY",
                          style: TextStyle(fontSize: 35.0, color: Colors.white),
                        ),
                        Text(
                          "Let,s Cook Something New!",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        category[index]["picurl"],
                                        width: 150,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.black26),
                                              child: Text(
                                                category[index]["heading"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        }),
                  ),
                  Container(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Recipedetails(
                                              recipeList[index].appurl)));
                                },
                                child: Card(
                                  margin: EdgeInsetsDirectional.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      // Image.network(recipeList[index].appurl),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          recipeList[index].appimgeurl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          color: Colors.black26,
                                          child: Text(
                                            recipeList[index].applabel,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    size: 20,
                                                  ),
                                                  Text(recipeList[index]
                                                      .appcalories
                                                      .toString()
                                                      .substring(1, 6)),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
