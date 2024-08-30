import 'dart:convert';

import 'package:magic/src/data/api/ApiConfig.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/domain/utils/ListToString.dart';
import 'package:magic/src/domain/utils/Resources.dart';
import 'package:http/http.dart' as http;

class MagicService {
  Future<Resource<List<MagicCard>>> getCards() async {
    try {
      Uri url = Uri.parse(
          "${ApiConfig.BASE_URL}${ApiConfig.CARDS}?page=1&pageSize=10");
      print(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.get(url, headers: headers);
      print('DATedddA $response');

      List<dynamic> data = jsonDecode(response.body)['cards'];
      print('DATA $data');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(
            data.map((vehicle) => MagicCard.fromJson(vehicle)).toList());
      } else {
        return Error(listToString("Error: ${response.statusCode}"));
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Error("$e");
    }
  }
}
