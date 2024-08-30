import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magic/src/domain/models/magic_card.dart';

class CacheManager {
  static const String _cachedCardsKey = 'cached_cards';
  static const String _pagesCachedKey = 'cached_cards';

  Future<void> cacheCards(List<MagicCard> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringCached = prefs.getString(_cachedCardsKey);

    final String jsonString =
        jsonEncode(cards.map((card) => card.toJson()).toList());

    if (jsonStringCached != null) {
      List<dynamic> jsonData = jsonDecode(jsonStringCached);
      jsonData.addAll(jsonDecode(jsonString));
      await prefs.setString(_cachedCardsKey, jsonEncode(jsonData));
      return;
    }
    await prefs.setString(_cachedCardsKey, jsonString);
  }

  Future<void> cachePages(page) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_pagesCachedKey);
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      jsonData.add(page);
      await prefs.setString(_pagesCachedKey, jsonEncode(jsonData));
    } else {
      await prefs.setString(_pagesCachedKey, jsonEncode([page]));
    }
  }

  Future<bool> checkPages(page) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_pagesCachedKey);
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.contains(page);
    }
    return false;
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
