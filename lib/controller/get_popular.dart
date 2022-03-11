import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../model/movie.dart';
final getPopularData=ChangeNotifierProvider<GetPopuar>((ref) => GetPopuar(),);

class GetPopuar with ChangeNotifier {
  List<Movie> listDataModel = [];
  GetPopuar() {
    getData();
  }

  getData() async {
    listDataModel = [];
    listDataModel.clear();

    try{
      String apiKey="23a90089ddfee7fe3c9609b20ce850b9";
      var url=Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=$apiKey");
      print(url);
      var response=await http.get(url);
      var responseBody=jsonDecode(response.body)["results"];
      for(var i in responseBody){
        listDataModel.add(Movie.fromMap(i));
      }
    }catch(e){
      print("e=>$e");
    }
    notifyListeners();
  }
}
