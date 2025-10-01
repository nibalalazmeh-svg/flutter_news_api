
import 'package:difficult_app/model.dart';
import 'package:dio/dio.dart';

class NewsService {
  Dio dio = Dio();
  String baseurl = "https://newsapi.org/v2/everything";
  late Response response;
  String apikey = "1ef1b21977aa42688d9cb9a54fa2800d";
  String sortBy = "publishedAt";
  String from = "2025-08-22";

  Future<List<ArticalModel>> getNews(String title) async {
    try {
      
    response = await dio.get(
      baseurl,
      queryParameters: {
        "q": title,
     
        "apikey": apikey,
        "from": from,
      },
    );
  print(response);
    List<ArticalModel> articals = [];
    print(response.data['articles']);
    for (var i = 0; i < response.data['articles'].length; i++) {
      articals.add(ArticalModel.fromMap(response.data['articles'][i]));
    }
    return articals;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}