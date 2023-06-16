import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

class APIService {
  static const String baseUrl =
      "https://open.neis.go.kr/hub/mealServiceDietInfo?ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010552";
  static const key = "bbcc1c5ce6d0488982f4c5356f0fb8eb";
  static const error200 = "급식 정보가 없습니다.";
  static const error500 = "서버에 문제가 생겼습니다. 잠시만 기다려주세요.";
  static const error600 = "데이터베이스에 문제가 생겼습니다. 잠시만 기다려주세요.";
  static const errorother = "급식 정보를 불러올 수 없습니다. 다시 시도해주세요.";

  Future<String> getLunchJsonFromAPI(String date) async {
    try {
      final url = Uri.parse("$baseUrl&MLSV_YMD=$date&type=json&KEY=$key");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String lunchDishData = jsonDecode(response.body)['mealServiceDietInfo']
            [1]['row'][0]['DDISH_NM'];

        while (lunchDishData.contains(")")) {
          if (lunchDishData.startsWith(".", lunchDishData.indexOf(")") - 1)) {
            lunchDishData = lunchDishData.replaceFirst("(", "");
            lunchDishData = lunchDishData.replaceFirst(")", "");
          } else {
            lunchDishData =
                lunchDishData.replaceFirst("(", "[temporary_open_parentheses]");
            lunchDishData = lunchDishData.replaceFirst(
                ")", "[temporary_close_parentheses]");
          }
        }
        lunchDishData =
            lunchDishData.replaceAll("[temporary_open_parentheses]", "(");
        lunchDishData =
            lunchDishData.replaceAll("[temporary_close_parentheses]", ")");

        lunchDishData = lunchDishData.replaceAll("<br/>", "");
        lunchDishData = lunchDishData.replaceAll(".", "");
        lunchDishData = lunchDishData.trim();
        for (int i = 0; i < 10; i++) {
          lunchDishData = lunchDishData.replaceAll("$i", "");
        }
        lunchDishData = lunchDishData.trimRight();
        lunchDishData = lunchDishData.replaceAll("  ", "\n\n");
        return lunchDishData;
      } else if (response.statusCode == 500) {
        return error500;
      } else if (response.statusCode == 600) {
        return error600;
      } else {
        return errorother;
      }
    } catch (e) {
      return error200;
    }
  }

  Future<String> getDinnerJsonFromAPI(String date) async {
    try {
      final url = Uri.parse("$baseUrl&MLSV_YMD=$date&type=json&KEY=$key");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String dinnerDishData = jsonDecode(response.body)['mealServiceDietInfo']
            [1]['row'][1]['DDISH_NM'];

        while (dinnerDishData.contains(")")) {
          if (dinnerDishData.startsWith(".", dinnerDishData.indexOf(")") - 1)) {
            dinnerDishData = dinnerDishData.replaceFirst("(", "");
            dinnerDishData = dinnerDishData.replaceFirst(")", "");
          } else {
            dinnerDishData = dinnerDishData.replaceFirst(
                "(", "[temporary_open_parentheses]");
            dinnerDishData = dinnerDishData.replaceFirst(
                ")", "[temporary_close_parentheses]");
          }
        }
        dinnerDishData =
            dinnerDishData.replaceAll("[temporary_open_parentheses]", "(");
        dinnerDishData =
            dinnerDishData.replaceAll("[temporary_close_parentheses]", ")");

        dinnerDishData = dinnerDishData.replaceAll("<br/>", "");
        dinnerDishData = dinnerDishData.replaceAll(".", "");
        dinnerDishData = dinnerDishData.trim();
        for (int i = 0; i < 10; i++) {
          dinnerDishData = dinnerDishData.replaceAll("$i", "");
        }
        dinnerDishData = dinnerDishData.trimRight();
        dinnerDishData = dinnerDishData.replaceAll("  ", "\n\n");
        return dinnerDishData;
      } else if (response.statusCode == 500) {
        return error500;
      } else if (response.statusCode == 600) {
        return error600;
      } else {
        return errorother;
      }
    } catch (e) {
      return error200;
    }
  }
}
