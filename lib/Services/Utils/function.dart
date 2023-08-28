import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pixel/config.dart';
import '../../Model/pexel_api_model.dart';

class PexelsApi {
  final String curatedApiUrl = "https://api.pexels.com/v1/curated";
  final String searchApiUrl = "https://api.pexels.com/v1/search";

  Future<PexelApiModel> getCuratedWallpapers() async {
    final response = await http.get(
      Uri.parse("$curatedApiUrl?page=1&per_page=100"),
      headers: {"Authorization": Config().apiKey},
    );
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return PexelApiModel.fromJson(data);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<PexelApiModel> getSearchWallpapers(String query) async {
    final response = await http.get(
      Uri.parse("$searchApiUrl?query=$query&page=1&per_page=100"),
      headers: {"Authorization": Config().apiKey},
    );
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return PexelApiModel.fromJson(data);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
