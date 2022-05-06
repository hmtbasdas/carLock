import 'package:carlock/models/car_brand.dart';

abstract class ICarService {

  Future<List<CarBrand>?> fetchCarItems();
}