import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jezt_tecnologies/MovieModelclass.dart';
import 'package:http/http.dart' as http;

class vHttpServices {
  final String apiUrl =
      "http://www.omdbapi.com/?i=tt3896198&apikey=3710fd57";


  Future<MoviesModel> getPost() async {
    http.Response res = await http.get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);

      MoviesModel umodel = MoviesModel.fromJson(body);
      if (kDebugMode) {
        print(umodel.toString());
      }
      return umodel;

    } else {
      throw Exception("Unable to retrieve posts.");
    }
  }
}