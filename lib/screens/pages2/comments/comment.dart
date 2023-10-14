import 'dart:convert';

import 'package:adumas/core/cache/network.dart';
import 'package:adumas/core/env.dart';
import 'package:adumas/widgets/WAvatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class commentpost extends StatefulWidget {
  const commentpost({super.key, required this.id});
  final String id;
  @override
  State<commentpost> createState() => _commentpostState();
}

TextEditingController _postkomenn = TextEditingController();

class _commentpostState extends State<commentpost> {
  @override
  void initState() {
    // TODO: implement initState
    getSysToken();
    super.initState();
  }

  Dio dio = Dio();
  Future<dynamic> getcom() async {
    String token = await getSysToken();
    var url =
        "https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Comments?\$lookup=*&Postingan[0]=${widget.id}";
    Response res = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer ${token}"}));
    if (res.statusCode == 200) {
      return res.data;
    } else {
      print("kontloff ${url}");
      return null;
    }
  }

  Future createComment(String id) async {
    String token = await getSysToken();
    var body = jsonEncode({
      "comment": "${_postkomenn.text}",
      // "comment": "testt",
      "Postingan": [id]
    });
    String url2 =
        "https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Comments";
    var response = await Dio().post(url2,
        data: body,
        options: Options(headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sessionManager.nToken}',
        }));
    print("LO POKE ${id}");
    if (response.statusCode == 201) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Comment",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder(
          future: getcom(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List data = snapshot.data;
              var rev = data.reversed;
              List reversedData = new List.from(rev);
              return Column(
                children: [
                  ...reversedData.map((c) {
                    return Column(
                      children: [
                        ListTile(
                          leading: WAvatar_Render(
                            maxRadius: 22,
                            iconSize: 26,
                            iconColor: Colors.black54,
                          ),
                          title: Row(children: [
                            Text(
                              c["createdBy"]["firstName"] ?? "user".toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateFormat.Hm().format(
                                  DateTime.parse(c["createdAt"]).toLocal()),
                              // v["createdAt"],
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            ),
                          ]),
                          subtitle: Text(c["comment"]

                              // "${sessionManager.nToken}"
                              ),
                        )
                      ],
                    );
                  }),
                ],
              );
            }
            return Container();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextFormField(
        controller: _postkomenn,
        // keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () async {
                  if (_postkomenn.text.isNotEmpty) {
                    await createComment(widget.id);
                    _postkomenn.clear();
                  } else {
                    return null;
                  }
                  print(widget.id);
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                )),
            hintText: "  Tulis nominal"),
      ),
    );
  }
}
