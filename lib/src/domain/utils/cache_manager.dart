import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magic/src/domain/models/magic_card.dart';

class CacheManager {
  static const String _cachedCardsKey = 'cached_cards';

  Future<void> cacheCards(List<MagicCard> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString =
        jsonEncode(cards.map((card) => card.toJson()).toList());
    await prefs.setString(_cachedCardsKey, jsonString);
  }

  Future<List<MagicCard>?> getCachedCards() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cachedCardsKey);
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((item) => MagicCard.fromJson(item)).toList();
    }
    return null;
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cachedCardsKey);
  }
}
