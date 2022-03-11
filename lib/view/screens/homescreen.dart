import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app2/constant.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app2/view/screens/search_screen.dart';

import '../../controller/fav_db.dart';
import '../../controller/get_data_from_api.dart';
import '../../controller/get_popular.dart';
import 'description_screen.dart';
import 'favourat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kblack,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                color: KprimaryColor,
              )),
          Consumer(builder: (context, watch, child) {
            final viewFav = watch;

            return Badge(
              borderSide: BorderSide(
                color: viewFav.watch(fav).favList.length == 0
                    ? Colors.transparent
                    : white1,
                width: 1,
              ),
              badgeColor: viewFav.watch(fav).favList.length == 0
                  ? Colors.transparent
                  : red,
              elevation: 0,
              position: BadgePosition.topEnd(top: 5, end: 5),
              animationDuration: Duration(milliseconds: 400),
              animationType: BadgeAnimationType.slide,
              badgeContent: viewFav.watch(fav).favList.length == 0
                  ? Text("", style: TextStyle(color: white0))
                  : Text(
                "${viewFav.watch(fav).favList.length}",
                style: TextStyle(color: white0, fontSize: 12),
              ),
              child: IconButton(
                color: white1,
                onPressed: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (_) => FavoriteScreen()));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: red,
                ),
              ),
            );
          }),

        ],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Netflix",
          style: TextStyle(
            color: KprimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, watch, child) {
              final viewmodeltoprated = watch;

              return viewmodeltoprated
                          .watch(getDataRated)
                          .listDataModel
                          .length ==
                      0
                  ? Center(child: CircularProgressIndicator())
                  : CarouselSlider.builder(
                      itemCount: viewmodeltoprated
                          .watch(getDataRated)
                          .listDataModel
                          .length,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DescriotionScreen(
                                    id: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .id,
                                    vote_average: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .vote_average,
                                    title: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .title,
                                    original_language: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .original_language,
                                    poster_path: Kimage_url +
                                        viewmodeltoprated
                                            .watch(getDataRated)
                                            .listDataModel[index]
                                            .poster_path,
                                    release_date: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .release_date,
                                    backdrop_path: Kimage_url +
                                        viewmodeltoprated
                                            .watch(getDataRated)
                                            .listDataModel[index]
                                            .backdrop_path,
                                    overview: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .overview,
                                    original_title: viewmodeltoprated
                                        .watch(getDataRated)
                                        .listDataModel[index]
                                        .original_language,
                                  ),
                                ));
                          },
                          child: GridTile(
                            child: Image.network(
                              Kimage_url +
                                  viewmodeltoprated
                                      .watch(getDataRated)
                                      .listDataModel[index]
                                      .poster_path,
                              fit: BoxFit.fill,
                            ),
                            footer: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              color: Colors.red.withOpacity(0.5),
                              child: Text(
                                viewmodeltoprated
                                    .watch(getDataRated)
                                    .listDataModel[index]
                                    .title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Kblack,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 1.5,
                        viewportFraction: 0.7,
                        height: MediaQuery.of(context).size.height / 3,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 35,
          ),
          Expanded(child: Consumer(
            builder: (context, watch, child) {
              final viewmodeltPopular = watch;

              return viewmodeltPopular
                          .watch(getPopularData)
                          .listDataModel
                          .length ==
                      0
                  ? SizedBox()
                  : StaggeredGridView.countBuilder(
                      itemCount: viewmodeltPopular
                          .watch(getPopularData)
                          .listDataModel
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DescriotionScreen(
                                    id: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .id,
                                    vote_average: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .vote_average,
                                    title: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .title,
                                    original_language: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .original_language,
                                    poster_path: Kimage_url +
                                        viewmodeltPopular
                                            .watch(getPopularData)
                                            .listDataModel[index]
                                            .poster_path,
                                    release_date: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .release_date,
                                    backdrop_path: Kimage_url +
                                        viewmodeltPopular
                                            .watch(getPopularData)
                                            .listDataModel[index]
                                            .backdrop_path,
                                    overview: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .overview,
                                    original_title: viewmodeltPopular
                                        .watch(getPopularData)
                                        .listDataModel[index]
                                        .original_language,
                                  ),
                                ));
                          },
                          child: Card(
                            color: KprimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image.network(
                                        Kimage_url +
                                            viewmodeltPopular
                                                .watch(getPopularData)
                                                .listDataModel[index]
                                                .poster_path,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: CircleAvatar(
                                            radius: 17,
                                            child: Consumer(builder:
                                                (context, watch, child) {
                                              final favoriteHelper = watch;
                                              return IconButton(
                                                onPressed: () {
                                                  if (favoriteHelper
                                                      .watch(fav)
                                                      .favList
                                                      .any((element) =>
                                                          element.id ==
                                                              viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .id)) {
                                                    favoriteHelper
                                                        .watch(fav)
                                                        .manageFav(
                                                            productId: viewmodeltPopular
                                                                .watch(
                                                                    getPopularData)
                                                                .listDataModel[
                                                                    index]
                                                                .id);
                                                  } else {
                                                    favoriteHelper
                                                        .watch(fav)
                                                        .insertdb({
                                                      'id': viewmodeltPopular
                                                          .watch(getPopularData)
                                                          .listDataModel[index]
                                                          .id,
                                                      'vote_average':
                                                      viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .vote_average,
                                                      'title': viewmodeltPopular
                                                          .watch(getPopularData)
                                                          .listDataModel[index]
                                                          .title,
                                                      'original_title':
                                                      viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .original_title,
                                                      'poster_path':
                                                      viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .poster_path,
                                                      'release_date':
                                                      viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .release_date,
                                                      'backdrop_path':
                                                      viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .backdrop_path,
                                                      'overview':
                                                      viewmodeltPopular
                                                              .watch(
                                                                  getPopularData)
                                                              .listDataModel[
                                                                  index]
                                                              .overview,
                                                    });

                                                    // favoriteHelper
                                                    //     .watch(fav)
                                                    //     .getdb();
                                                  }
                                                },
                                                icon: favoriteHelper
                                                        .watch(fav)
                                                        .isFavorite(
                                                    viewmodeltPopular
                                                                .watch(
                                                                    getPopularData)
                                                                .listDataModel[
                                                                    index]
                                                                .id)
                                                    ? Icon(
                                                        Icons.favorite,
                                                        size: 18,
                                                        color: red,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                        size: 18,
                                                        color: red,
                                                      ),
                                              );
                                            }),
                                            backgroundColor: light,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    color: Kblack,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      child: Text(
                                        viewmodeltPopular
                                            .watch(getPopularData)
                                            .listDataModel[index]
                                            .title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      crossAxisCount: 2,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    );
            },
          )),
        ],
      ),
    );
  }
}
