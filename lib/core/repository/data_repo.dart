import '../core.dart';

class DataRepository {
  final ApiClient _apiClient;

  DataRepository(this._apiClient);

  Future<List<Beer>?> fetchBeersList(int page) async {
    try {
      final result = await _apiClient.fetchList(
        "/beers",
        queryParams: {
          'page': page.toString(),
        },
      );
      List<Beer> beers = [];
      for (Map<String, dynamic> element in result) {
        beers.add(Beer.fromJson(element));
      }
      return beers;
    } catch (e) {
      print("errror ${e.toString()}");
      return null;
    }
  }
}
