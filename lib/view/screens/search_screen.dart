import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app2/constant.dart';
import 'package:movies_app2/view/screens/description_screen.dart';

import '../../controller/get_search.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  String vv = "";

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
   // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Kblack,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff0B0B0D),
              Color(0xff333739),
            ]),
          ),
        ),
        // centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            color: KprimaryColor,
          ),
        ),
        centerTitle: true,
        elevation: .5,
        backgroundColor: Colors.grey,
        leading: IconButton(
          color: KprimaryColor,
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white70,
            )),
      ),
      body: Consumer(builder: (context, watch, child) {
        final viewmodelSearch = watch;

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                      color: KbackGroundWhite, borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    onChanged: (value) {
                      viewmodelSearch.watch(getSearchData).getData(vv: value);
                      value == ""
                          ? viewmodelSearch
                          .watch(getSearchData)
                          .listDataModel
                          .clear()
                          : null;
                      // vv = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Search is Empty";
                      }
                    },
                    cursorColor: Color(0xFF000000),
                    keyboardType: TextInputType.text,
                    controller: viewmodelSearch
                        .watch(getSearchData)
                        .searchTextController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF000000).withOpacity(0.5),
                        ),
                        suffixIcon: viewmodelSearch
                            .watch(getSearchData)
                            .searchTextController
                            .text
                            .isNotEmpty
                            ? IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            color: Kblack,
                          ),
                          onPressed: () {
                            viewmodelSearch
                                .watch(getSearchData)
                                .clearSearch();
                          },
                        )
                            : null,
                        hintText: "Search",
                        border: InputBorder.none),
                  )),
            ),
            viewmodelSearch.watch(getSearchData).listDataModel.isEmpty
                ?   SizedBox(
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SizedBox(height: hight*.3,),
                    const Text(
                      "Welcom here",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: KbackGroundWhite),
                    ),
                  ],
                ),
              ),
            )
                : Container(
                child: Expanded(
                    child: StaggeredGridView.countBuilder(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        itemCount: viewmodelSearch
                            .watch(getSearchData)
                            .listDataModel
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => DescriotionScreen(
                                    original_title:
                                    "${viewmodelSearch.watch(getSearchData).listDataModel[index].original_title}",
                                    backdrop_path:
                                    "${Kimage_url+viewmodelSearch.watch(getSearchData).listDataModel[index].backdrop_path}",
                                    release_date:
                                    "${viewmodelSearch.watch(getSearchData).listDataModel[index].release_date}",
                                    id: viewmodelSearch
                                        .watch(getSearchData)
                                        .listDataModel[index]
                                        .id,
                                    poster_path:
                                    "${Kimage_url+viewmodelSearch.watch(getSearchData).listDataModel[index].poster_path}",
                                    title:
                                    "${viewmodelSearch.watch(getSearchData).listDataModel[index].title}",
                                    vote_average: viewmodelSearch
                                        .watch(getSearchData)
                                        .listDataModel[index]
                                        .vote_average,
                                    overview:
                                    "${viewmodelSearch.watch(getSearchData).listDataModel[index].overview}",
                                    original_language: "${viewmodelSearch.watch(getSearchData).listDataModel[index].original_language}",
                                  )));
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                color: Kblack,
                                child: Column(
                                  children: [
                                    Image.network(
                                      Kimage_url +
                                          viewmodelSearch
                                              .watch(getSearchData)
                                              .listDataModel[index]
                                              .poster_path ==
                                          Kimage_url
                                          ? "https://previews.123rf.com/images/kaymosk/kaymosk1804/kaymosk180400005/99776312-fehler-404-seite-nicht-gefunden-fehler-mit-glitch-effekt-auf-dem-bildschirm-vektor-illustration-f%C3%BCr-.jpg"
                                          : Kimage_url +
                                          viewmodelSearch
                                              .watch(getSearchData)
                                              .listDataModel[index]
                                              .poster_path,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        viewmodelSearch
                                            .watch(getSearchData)
                                            .listDataModel[index]
                                            .title,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1))))
          ],
        );
      }),
    );
  }
}