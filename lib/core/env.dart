// LOCAL IP TO CONNECT ON MONGODB

import 'package:dio/dio.dart';

// KONTENBASE API

String kbApi =
    'https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48';

Future<String> getSysToken() async {
  Dio dio = Dio();
  try {
    Response res = await dio.post("$kbApi/auth/login",
        data: {"email": "token@token.token", "password": "2wsx1qaz"});
    if (res.statusCode == 200) {
      return res.data["token"];
    }
  } catch (e) {
    print("error token $e");
    return "ERROR";
  }
  return "ERROR";
}
