import 'package:beer_barrel/core/api.dart';
import 'package:beer_barrel/core/core.dart';

class DataRepository {
  DataRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<Beer>> fetchProductList(int page) async {
    final List<Map<String, dynamic>> result = await _apiClient.fetchList(
      "/beers",
      queryParams: {
        'page': page.toString(),
      },
    ).then(
      (List<dynamic> value) =>
          value.map((dynamic e) => e as Map<String, dynamic>).toList(),
    );

    final List<Beer> productList = <Beer>[];
    for (Map<String, dynamic> element in result) {
      productList.add(Beer.fromJson(element));
    }
    return productList;
  }
}
