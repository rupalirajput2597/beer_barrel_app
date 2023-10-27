import '../core.dart';

//Beer Barrel User Data Repository
class DataRepository {
  final ApiClient _apiClient;

  DataRepository(this._apiClient);

  Future<List<Beer>> fetchBeersList(int page) async {
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
  }
}
