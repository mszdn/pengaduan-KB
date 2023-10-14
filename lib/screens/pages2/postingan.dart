import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adumas/core/cache/network.dart';
import 'package:adumas/core/env.dart';
import 'package:adumas/main.dart';
import 'package:adumas/screens/auth/login_screen.dart';
import 'package:adumas/screens/auth/signup_screen_petugas.dart';
import 'package:adumas/screens/pages2/comments/comment.dart';
import 'package:adumas/screens/pages2/createPost.dart';
import 'package:adumas/screens/pages2/postinganSold.dart';
import 'package:adumas/screens/pages2/printToPdf.dart/cat.dart';
import 'package:adumas/widgets/WAvatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../widgets/Walert_Dialog.dart';

class Postinganlelang extends StatefulWidget {
  const Postinganlelang({super.key});

  @override
  State<Postinganlelang> createState() => _PostinganlelangState();
}

class _PostinganlelangState extends State<Postinganlelang> {
  List items = [];
  bool isLoad = true;
  Dio dio = Dio();
  Future<dynamic> getpost() async {
    try {
      String token = await getSysToken();
      var url =
          "https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan?\$lookup=*&\$sort[0][createdAt]=1";
      Response res = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer ${token}"}));
      setState(() {
        isLoad = false;
      });

      return res.data;
      // if (res.statusCode == 200) {
      //   return res.data;
      // } else {
      //   print("kontloff ${url}");
      //   return null;
      // }
    } catch (e) {}
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

  String? level;
  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      level = prefs.getString('level');
    });
  }

  Future deletePost(
    String id,
  ) async {
    print("jjjj");
    String _token = await getSysToken();
    Uri url = Uri.parse(
        "https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan/$id");
    var res =
        await http.delete(url, headers: {"Authorization": "Bearer $_token"});
    if (res.statusCode < 300) return true;
    return false;
  }

  @override
  void initState() {
    // level = sessionManager.nLevel;
    getpost();
    setState(() {
      sessionManager.nLevel;
    });
    // _getCamerraPhoto();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          sessionManager.nLevel == "petugas" || sessionManager.nLevel == "admin"
              ? SpeedDial(
                  icon: Icons.add,
                  backgroundColor: Colors.amber,
                  children: [
                      SpeedDialChild(
                        child: const Icon(Icons.toys),
                        label: 'Tambah Lelang',
                        backgroundColor: Colors.amberAccent,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              HRoute(builder: (context) => createPostingan()));
                        },
                      ),
                      sessionManager.nLevel == "admin"
                          ? SpeedDialChild(
                              child: const Icon(Icons.people_alt),
                              label: 'Tambah Petugas',
                              backgroundColor: Colors.amberAccent,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    HRoute(
                                        builder: (context) =>
                                            const SignupScreenPetugas()));
                              },
                            )
                          : SpeedDialChild()
                    ])
              : SizedBox(),
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade600,
        leading: sessionManager.nLevel == "admin" ||
                sessionManager.nLevel == "petugas"
            ? IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                      HRoute(builder: (context) => PostinganlelangHabis()));
                },
                icon: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Colors.black,
                ))
            : Icon(
                Icons.abc,
                color: Colors.yellow.shade600,
              ),
        title: Center(
            child: Text(
          "Lelangin",
          // "${level}",
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
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : SingleChildScrollView(
              child: FutureBuilder(
                future: getpost(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List data = snapshot.data;
                    var rev = data.reversed;
                    List reversedData = new List.from(rev);
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...reversedData.map((p) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                p["status"] == "Masih"
                                    ? Column(
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  DateFormat.Hm().format(
                                                      DateTime.parse(
                                                              p["createdAt"])
                                                          .toLocal()),
                                                  // v["createdAt"],
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                                Spacer(),
                                              ]),
                                              trailing: sessionManager.nLevel ==
                                                          "admin" ||
                                                      sessionManager.nLevel ==
                                                          "petugas"
                                                  ? PopupMenuButton(
                                                      onSelected: (value) {
                                                        if (value == 'edit') {
                                                          //open edit page
                                                          navigateToEditPage(
                                                            p,
                                                            p["attachment"][0]
                                                                ["url"],
                                                          );
                                                        } else if (value ==
                                                            'delete') {
                                                          //open delete page
                                                          // deleteById(id);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  WDialong_ConfirmAlert(
                                                                    context,
                                                                    "Yakin ingin menghapus?",
                                                                    onConfirm:
                                                                        () {
                                                                      deletePost(
                                                                          p["_id"]);
                                                                    },
                                                                  ));
                                                        }
                                                      },
                                                      itemBuilder: (context) {
                                                        return [
                                                          const PopupMenuItem(
                                                            value: 'edit',
                                                            child: Text('Edit'),
                                                          ),
                                                          const PopupMenuItem(
                                                            value: 'delete',
                                                            child:
                                                                Text('Hapus'),
                                                          ),
                                                        ];
                                                      },
                                                    )
                                                  : SizedBox()),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Image.network(
                                                p["attachment"][0]["url"],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .push(HRoute(
                                                            builder:
                                                                (context) =>
                                                                    commentpost(
                                                                      id: p[
                                                                          "_id"],
                                                                    )));
                                                  },
                                                  icon: Icon(
                                                      Icons.message_rounded))
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(p["title"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        textAlign:
                                                            TextAlign.start),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(p["description"],
                                                        textAlign:
                                                            TextAlign.start),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox()
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

  Future<void> navigateToEditPage(Map item, String image) async {
    final route = MaterialPageRoute(
      builder: (context) => createPostingan(
        imagenet: image,
        todo: item,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoad = true;
    });
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      //error
    }
    setState(() {
      isLoad = false;
    });
  }
}
