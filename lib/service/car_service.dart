import 'dart:convert';
import 'dart:io';

import 'package:carlock/models/car_brand.dart';
import 'package:carlock/service/i_car_service.dart';
import 'package:dio/dio.dart';

class CarService extends ICarService {
  final Dio _dio;
  final String path = "https://gist.githubusercontent.com/shcyiza/71c64a33f3880e58980003c4c794db38/raw/febb04707f6ccc9ae3a445e147c5754e30f743fe/car_brands.json";

  CarService() : _dio = Dio();

  @override
  Future<List<CarBrand>?> fetchCarItems() async {
    try {
      final response = await _dio.get(path);

      if (response.statusCode == HttpStatus.ok) {
        print("basarili");
        List<dynamic> _list = json.decode(response.data);

        return _list.map((e) => CarBrand.fromJson(e)).toList();
      }
      else {
        return null;
      }
    } catch (err) {
      print("Error: " + err.toString());
      return null;
    }
  }
}
