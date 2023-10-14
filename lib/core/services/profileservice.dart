
import 'package:adumas/core/env.dart';
import 'package:dio/dio.dart';

Future<Map> uploadFileToMg({
  required String filePath,
  required String fileName,
  required String utoken,
}) async {
  Dio dio = Dio();
  FormData data = FormData.fromMap({
    "path": "photoProfile",
  });
  data.files.add(MapEntry(
      "file", await MultipartFile.fromFile(filePath, filename: fileName)));
  Response res = await dio.post(
      "$kbApi/storage/upload",
      data: data,
      options: Options(headers: {
        'Authorization': 'Bearer $utoken',
        // 'Content-type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json',
      }));
  if (res.statusCode! < 300) {
    var d = res.data;
    return {
      "res": "ok",
      "data": {"fileName": d["fileName"], "url": d["url"]},
    };
  }
  return {"res": "err"};
}