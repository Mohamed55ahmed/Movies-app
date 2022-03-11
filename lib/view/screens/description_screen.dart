import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flip_card/flip_card.dart';
import 'package:movies_app2/constant.dart';
import 'in_app_egy_screen.dart';


class DescriotionScreen extends StatelessWidget {
  int id;
  num vote_average;
  String title;
  String original_language;
  String poster_path;
  String release_date;
  String backdrop_path;
  String overview;
  String original_title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      //   elevation: 0,
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.network(
                poster_path,
                fit: BoxFit.fill,
              )),
          BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.transparent.withOpacity(0.01),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 24,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: Text(
                        "Back",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    front: Container(
                      height: MediaQuery.of(context).size.height / 1.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              poster_path,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    back: Container(
                      height: MediaQuery.of(context).size.height / 1.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              backdrop_path,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text("$title",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ),
                      Text("${vote_average}/10",
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Text("$overview",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: KprimaryColor,
        elevation: 5,
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute (
              builder: (BuildContext context) => InAppEgyScreen(title: title,),
            ),);
        },
        label: Row(
          children: [
            Icon(Icons.search),
            Text("EgyBest",style: TextStyle(fontSize: 25),)
          ],
        ),

      ),
    );
  }

  DescriotionScreen({
    required this.id,
    required this.vote_average,
    required this.title,
    required this.original_language,
    required this.poster_path,
    required this.release_date,
    required this.backdrop_path,
    required this.overview,
    required this.original_title,
  });
}
