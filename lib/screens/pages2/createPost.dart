import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adumas/constant/Hroute.dart';
import 'package:adumas/core/cache/network.dart';
import 'package:adumas/core/env.dart';
import 'package:adumas/core/services/profileservice.dart';
import 'package:adumas/main.dart';
import 'package:adumas/screens/pages/createpost.dart';
import 'package:adumas/screens/pages2/createPostAtt.dart';
import 'package:adumas/screens/pages2/home.dart';
import 'package:adumas/screens/pages2/postLelang/newpost.dart';
import 'package:adumas/screens/pages2/postingan.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class createPostingan extends StatefulWidget {
  const createPostingan({super.key, this.todo, this.image});
  final Map? todo;
  final File? image;
  @override
  State<createPostingan> createState() => _createPostinganState();
}

class _createPostinganState extends State<createPostingan> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    // _getCamerraPhoto();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  final picker = ImagePicker();
  File? galleryFile;

  Future GetImageCamera(ImageSource img) async {
    final _pickedFile = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    XFile? xfilePick = _pickedFile;
    setState(() {
      if (xfilePick != null) {
        galleryFile = File(_pickedFile!.path);
        print("INI PATH VIDEOS ===> ${galleryFile!.path}");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
            const SnackBar(content: Text('Tidak Ada foto Yang Dimasukkan')));
      }
    });
  }

  Future GetImageGalery(ImageSource img) async {
    final _pickedFile = await picker.pickImage(source: ImageSource.gallery);

    XFile? xfilePick = _pickedFile;
    setState(() {
      if (xfilePick != null) {
        galleryFile = File(_pickedFile!.path);
        print("INI PATH VIDEOS ===> ${galleryFile!.path}");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
            const SnackBar(content: Text('Tidak Ada foto Yang Dimasukkan')));
      }
    });
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
  Widget build(BuildContext context) {
    var mediaH = MediaQuery.of(context).size.height;
    var mediaW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => Postinganlelang()),
                  (route) => false);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        title: Text(
          isEdit ? 'Edit todo' : 'Add todo',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          widget.image != null
              ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  padding: const EdgeInsets.all(12),
                  color: Color(0xffFEDC23),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: SizedBox(
                      height: mediaH / 3.5,
                      width: mediaW,
                      child: Center(child: Image.file(File(widget.image!.path))
                          // child: Text("data"),
                          ),
                    ),
                  ))
              : InkWell(
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       backgroundColor: Colors.black,
                    //       title: Text(
                    //         'Pilih Sumber Upload',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w600),
                    //       ),
                    //       content: const Text(''),
                    //       actions: <Widget>[
                    //         SizedBox(
                    //           height: MediaQuery.of(context).size.height / 8,
                    //           child: Row(
                    //             children: [
                    //               GestureDetector(
                    //                 onTap: () async {
                    //                   setState(() {
                    //                     // isLoading = true;
                    //                   });
                    //                   // Position position =
                    //                   //     await _getGeoLocationPosition();
                    //                   // setState(() {
                    //                   //   lokasi =
                    //                   //       "${position.latitude} ${position.longitude}";
                    //                   //   print(
                    //                   //       "INI LATLONG BOLO ${lokasi}");
                    //                   // });
                    //                   // getAddressFromLongLat(
                    //                   //     position);
                    //                   setState(() {
                    //                     // isLoading = false;
                    //                   });
                    //                   Navigator.pop(context);
                    //                   //   Navigator.push(
                    //                   //       context,
                    //                   //       MaterialPageRoute(
                    //                   //           builder: (context) =>
                    //                   //               NewPostScreen()));
                    //                 },
                    //                 child: Container(
                    //                   width: mediaW / 3.4,
                    //                   height: mediaH / 7,
                    //                   decoration: BoxDecoration(
                    //                       color: Colors.red,
                    //                       borderRadius:
                    //                           BorderRadius.circular(16)),
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: [
                    //                       Icon(
                    //                         Icons.image,
                    //                         size: mediaW / 7,
                    //                         color: Colors.white,
                    //                       ),
                    //                       const Text(
                    //                         'Pilih Dari Galeri',
                    //                         style: TextStyle(
                    //                             color: Colors.white,
                    //                             fontWeight: FontWeight.w500,
                    //                             fontSize: 12),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: mediaW / 20,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () async {
                    //                   // setState(() {
                    //                   //   isLoading = true;
                    //                   // });
                    //                   // Position position =
                    //                   //     await _getGeoLocationPosition();
                    //                   // setState(() {
                    //                   //   lokasi =
                    //                   //       "${position.latitude} ${position.longitude}";
                    //                   //   print(
                    //                   //       "INI LATLONG BOLO ${lokasi}");
                    //                   // });
                    //                   // getAddressFromLongLat(
                    //                   //     position);
                    //                   // setState(() {
                    //                   //   isLoading = false;
                    //                   // });

                    //                   _getCamerraPhoto();
                    //                   Navigator.pop(context);
                    //                   // Navigator.push(
                    //                   //     context,
                    //                   //     MaterialPageRoute(
                    //                   //         builder: (context) =>
                    //                   //             NewPostScreen(
                    //                   //               kabupaten:
                    //                   //                   kabupaten,
                    //                   //               kecamatan:
                    //                   //                   kecamatan,
                    //                   //               provinsi:
                    //                   //                   provinsi,
                    //                   //               location:
                    //                   //                   lokasi,
                    //                   //               alamatLengkap:
                    //                   //                   lokasiLengkap,
                    //                   //             )));
                    //                 },
                    //                 child: Container(
                    //                   width: mediaW / 3.4,
                    //                   height: mediaH / 7,
                    //                   decoration: BoxDecoration(
                    //                       color: Colors.red,
                    //                       borderRadius:
                    //                           BorderRadius.circular(16)),
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: [
                    //                       Icon(
                    //                         Icons.camera_alt_rounded,
                    //                         size: mediaW / 7,
                    //                         color: Colors.white,
                    //                       ),
                    //                       const Text(
                    //                         'Ambil Foto',
                    //                         style: TextStyle(
                    //                             color: Colors.white,
                    //                             fontWeight: FontWeight.w500,
                    //                             fontSize: 12),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     );
                    //   },
                    // );
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      // backgroundColor: Colors.grey,
                      context: context,
                      builder: (context) => BottomShet(),
                    );
                  },
                  child: IW_AddImage(mediaH: 500, mediaW: mediaW)),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed:
                // isEdit ? updateData :
                () {
              // uploadFeed(
              //     attachments: File(widget.image!.path),
              //     title: titleController.text,
              //     token: "${sessionManager.nToken}",
              //     userId: "${sessionManager.nUserId}",
              //     description: descriptionController.text);
              submitData(
                token: "${sessionManager.nToken}",
                attachments: List.filled(1, File(widget.image!.path)),
              );
              log(widget.image!.path.toString());
              // log("galeri pepeq ${galleryFile!.toString()}");
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print("No todo data ");
      return;
    }
    final title = titleController.text;
    final id = todo['_id'];
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "status": false,
    };
    //
    final url =
        'https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan/$id?\$lookup=*';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      showSuccessMessage('Updated');
    } else {
      showErrorMessage('Updation Failed');
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<Map> uploadFeed({
    required File attachments,
    required String title,
    required String token,
    required String userId,
    required String description,
  }) async {
    try {
      Uri url = Uri.parse('$kbApi/Postingan');
      List<Map> attachmentsMg = [];

      // await Future.forEach(attachments, (f) async {
      //   Map uploadImage = await uploadFileToMg(
      //       filePath: f.path, fileName: f.path.split("/").last, utoken: token);
      //   var d = uploadImage["data"];
      //   attachmentsMg.add({"url": d["url"], "fileName": d["fileName"]});
      // });

      // String? bigSent = keterangan;

      // String judul = keterangan;

      // if (bigSent.length != 0 && bigSent.split(" ").length >= 5) {
      //   List<String> splitted = bigSent.split(" ");
      //   List<String> smaller = splitted.sublist(0, 5);
      //   judul = smaller.join(" ");
      // }

      var body = jsonEncode({
        // "isPublish": true,
        "title": title,
        "description": description,
        "status": "false",
        "attachment": attachmentsMg,
        "user": [userId],
        // "type": "photo",
      });

      var res = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode < 300) return {"res": "ok"};
    } catch (e) {
      return {
        "res": "service-error",
        "error": {"error": e.toString()}
      };
    }
    return {"res": "api-error"};
  }

  Future<void> submitData({
    required List<File> attachments,
    required String token,
  }) async {
    //get the data from form
    List<Map> attachmentsMg = [];

    await Future.forEach(attachments, (f) async {
      Map uploadImage = await uploadFileToMg(
          filePath: f.path, fileName: f.path.split("/").last, utoken: token);
      var d = uploadImage["data"];
      attachmentsMg.add({"url": d["url"], "fileName": d["fileName"]});
    });
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "attachment": attachmentsMg,
      "title": title,
      "description": description,
      "status": "false",
    };
    //submit data to server
    const url =
        'https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"
      },
    );
    //Map cannot be passed directly hence jsonEncoder converts map array into string
    log("${response.statusCode.toString()} statusss");
    //show success or fail message
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Creation Success');
      Navigator.of(context).pushAndRemoveUntil(
          // ignore: prefer_const_constructors
          MaterialPageRoute(builder: (context) => Postinganlelang()),
          (Route route) => false);
    } else {
      showErrorMessage('Creation Failed');
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: Colors.green[300],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: Colors.red[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget BottomShet() {
    double mediaW = MediaQuery.of(context).size.width;
    double mediaH = MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.grey,
      height: 100,
      width: mediaW,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Choose Your PhotoProfil",
              style: TextStyle(
                  // color: c.blueColor,
                  fontFamily: "Poppins",
                  // fontWeight: FontWeight.w600,
                  fontSize: 15)),
          SizedBox(
            height: mediaH / 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  // takephoto(ImageSource.camera);
                  Navigator.pop(context);
                  await GetImageCamera(ImageSource.camera);
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => createPostingan(
                                image: galleryFile,
                              )),
                      (route) => false);
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt_rounded),
                      Text("Camera",
                          style: TextStyle(
                              // color: c.blueColor,
                              fontFamily: "Poppins",
                              // fontWeight: FontWeight.w600,
                              fontSize: 12))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: mediaW / 6,
              ),
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  await GetImageGalery(ImageSource.gallery);
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => createPostingan(
                                image: galleryFile,
                              )),
                      (route) => false);
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(Icons.photo),
                      Text("Galery",
                          style: TextStyle(
                              // color: c.blueColor,
                              fontFamily: "Poppins",
                              // fontWeight: FontWeight.w600,
                              fontSize: 12))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
