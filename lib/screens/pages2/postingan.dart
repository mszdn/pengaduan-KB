import 'dart:developer';
import 'dart:io';

import 'package:adumas/core/cache/network.dart';
import 'package:adumas/core/env.dart';
import 'package:adumas/main.dart';
import 'package:adumas/screens/auth/login_screen.dart';
import 'package:adumas/screens/pages2/comments/comment.dart';
import 'package:adumas/screens/pages2/createPost.dart';
import 'package:adumas/widgets/WAvatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/Walert_Dialog.dart';

class Postinganlelang extends StatefulWidget {
  const Postinganlelang({super.key});

  @override
  State<Postinganlelang> createState() => _PostinganlelangState();
}

class _PostinganlelangState extends State<Postinganlelang> {
  Dio dio = Dio();
  Future<dynamic> getpost() async {
    String token = await getSysToken();
    var url =
        "https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan?\$lookup=*";
    Response res = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer ${token}"}));
    if (res.statusCode == 200) {
      return res.data;
    } else {
      print("kontloff ${url}");
      return null;
    }
  }

  File? imageFile;
  bool isPicked = false;
  _getCamerraPhoto() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 1800,
        maxWidth: 1800);
    if (image == null) {
      print("KOSONG");
    }
    if (image != null) {
      setState(() async {
        imageFile = File(image.path);
        log(imageFile!.path);
        // await Navigator.of(context, rootNavigator: true).push(HRoute(
        //     builder: (context) => createPostingan(
        //           image: imageFile!.path,
        //         )));
      });
    }
  }

  @override
  void initState() {
    // _getCamerraPhoto();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .push(HRoute(builder: (context) => const createPostingan()));
          // _getCamerraPhoto();
        },
        label: const Text(
          'Tambah Lelang',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
        elevation: 1,
      ),
      appBar: AppBar(
        title: Center(
            child: Text(
          "Lelangin",
          // "${token}",
          // "${sessionManager.nToken}",
          style: TextStyle(color: Colors.black),
        )),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => WDialong_ConfirmAlert(
                          context,
                          "Apakah anda ingin Logout?",
                          onConfirm: () {
                            sessionManager.clearSession().then((value) =>
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    HRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false));
                          },
                        ));
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getpost(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data == null) {
                CircularProgressIndicator();
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...snapshot.data.map((p) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            leading: WAvatar_Render(
                              maxRadius: 22,
                              iconSize: 26,
                              iconColor: Colors.black54,
                            ),
                            title: Row(children: [
                              Text(
                                p["createdBy"]["firstName"] ??
                                    "user".toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat.Hm().format(
                                    DateTime.parse(p["createdAt"]).toLocal()),
                                // v["createdAt"],
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              p["attachment"][0]["url"],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(HRoute(
                                            builder: (context) => commentpost(
                                                  id: p["_id"],
                                                )));
                                  },
                                  icon: Icon(Icons.message_rounded))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p["title"],
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.start),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p["description"],
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ],
                      );
                    })
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
