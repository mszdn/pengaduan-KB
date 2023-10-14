import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:adumas/core/cache/network.dart';
import 'package:adumas/main.dart';
import 'package:adumas/screens/pages/createpost.dart';
import 'package:adumas/screens/pages2/home.dart';
import 'package:adumas/screens/pages2/postLelang/newpost.dart';
import 'package:adumas/screens/pages2/postingan.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class createPostinganatt extends StatefulWidget {
  const createPostinganatt({super.key, this.todo, required this.image});
  final Map? todo;
  final String? image;
  @override
  State<createPostinganatt> createState() => _createPostinganattState();
}

class _createPostinganattState extends State<createPostinganatt> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
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
      setState(() {
        imageFile = File(image.path);
        log(imageFile!.path);
        // Navigator.of(context, rootNavigator: true).push(HRoute(
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
        backgroundColor: Colors.black,
        title: Text(
          isEdit ? 'Edit todo' : 'Add todo',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
      DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  padding: const EdgeInsets.all(12),
                  color: Color(0xffFEDC23),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: SizedBox(
                      height: mediaH / 3.5,
                      width: mediaW,
                      child: Center(child: Image.file(File(imageFile!.path))),
                    ),
                  )),
           
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
            onPressed: isEdit ? updateData : submitData,
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

  Future<void> submitData() async {
    //get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
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
        "Authorization": "Bearer ${sessionManager.nToken}"
      },
    );
    //Map cannot be passed directly hence jsonEncoder converts map array into string

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
}
