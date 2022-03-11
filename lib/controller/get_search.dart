import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../model/movie.dart';

final getSearchData = ChangeNotifierProvider<Getsearch>((ref) => Getsearch( ));
class Getsearch extends ChangeNotifier {
  List<Movie> listDataModel = [];
  TextEditingController searchTextController = TextEditingController();



  Getsearch() {
    getData( );

    notifyListeners();
  }

  Future getData({vv}) async {
    listDataModel = [];
    listDataModel.clear();
    try {
      String apiKey = "23a90089ddfee7fe3c9609b20ce850b9";
      var url = Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$vv");
      var response = await http.get(url);
      var responsebody = jsonDecode(response.body)["results"];
      for (int i = 0; i < responsebody.length; i++) {
        listDataModel.add(Movie.fromMap(responsebody[i]));

      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }


  void clearSearch() {
    searchTextController.clear();
    getData(vv:"");
    notifyListeners();
  }
}