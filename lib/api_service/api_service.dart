


import 'dart:io';

import 'package:cat_trivia/model/fact_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'api_const.dart';

 class ApiService {


   ApiService.init() {
     if (_dio == null) {
       _dio = Dio();
       (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
           (client) {
         client.badCertificateCallback =
             (X509Certificate cert, String host, int port) => true;
         return client;
       };
     }
   }

   Dio? _dio;

   Future<Fact?> getFact() async {
    try {
      var  response = await _dio?.get(
        APIConst.apiURL + APIConst.fact,
        options: Options(),
      );

      if (response != null) {

        return Fact.fromJson(response.data);

      }
    } catch (e) {
      return null;
    }
    return null;
  }


}
