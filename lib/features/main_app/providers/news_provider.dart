import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/api_endpoints.dart';
import '../../../core/app_config.dart';
import '../../../core/app_web_http.dart';
import '../models/model.dart';

class NewsProvider extends ChangeNotifier {
  final Http _http = Http(ApiEndpoint.baseUrl, Config.newsHost, Config.key);
  NewsResponseModel? _nrm;
  bool isLoading = false;

  NewsResponseModel get newsResponse => _nrm!;

  void search(String searchTerm) async {
    isLoading = false;
    notifyListeners();

    Response res = await _http
        .get(ApiEndpoint.news, params: {'q': searchTerm, 'lang': 'en'});
    if (res.statusCode == 200) {
      // print(res);
      _nrm = NewsResponseModel.fromJson(res.toString());
      isLoading = true;
      notifyListeners();
    }
  }
}
