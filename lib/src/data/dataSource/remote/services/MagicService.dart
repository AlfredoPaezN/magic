import 'dart:convert';

import 'package:magic/src/data/api/ApiConfig.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/domain/utils/ListToString.dart';
import 'package:magic/src/domain/utils/Resources.dart';
import 'package:http/http.dart' as http;
import 'package:magic/src/domain/utils/cache_manager.dart';

class MagicService {
  final CacheManager _cacheManager = CacheManager();
  Future<Resource<List<MagicCard>>> getCards(
      {int page = 1, int pageSize = 8}) async {
    try {
      bool isCached = await _cacheManager.checkPages(page);
      if (isCached) {
        final cachedCards = await _cacheManager.getCachedCards();
        if (cachedCards != null) {
          return Success(cachedCards);
        }
      }

      Uri url = Uri.parse(
          "${ApiConfig.BASE_URL}${ApiConfig.CARDS}?page=$page&pageSize=$pageSize");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept': '*/*',
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = jsonDecode(response.body)['cards'];
        List<MagicCard> cards =
            data.map((card) => MagicCard.fromJson(card)).toList();

        await _cacheManager.cachePages(page);

        await _cacheManager.cacheCards(cards);

        return Success(cards);
      } else {
        return Error("Error: ${response.statusCode}");
      }
    } catch (e) {
      return Error("$e");
    }
  }
}
