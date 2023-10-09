import 'dart:convert';

import 'package:adumas/core/cache/network.dart';
import 'package:adumas/screens/pages/createpost.dart';
import 'package:adumas/screens/pages2/home.dart';
import 'package:adumas/screens/pages2/postingan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class createPostingan extends StatefulWidget {
  const createPostingan({super.key, this.todo});
  final Map? todo;
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
    final todo = widget.todo;
    if(todo != null){
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }
  @override

  Widget build(BuildContext context) {
     var mediaH = MediaQuery.of(context).size.height;
    var mediaW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(
         isEdit?'Edit todo': 'Add todo',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          InkWell(onTap: () {
            print("object");
          },
            child: IW_AddImage(mediaH: 500, mediaW:mediaW)),
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
            onPressed: isEdit? updateData : submitData,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
            child:  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                isEdit?'Update':'Submit',
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
    if(todo == null){
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
    final url = 'https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan/$id?\$lookup=*';
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
    const url = 'https://api.kontenbase.com/query/api/v1/d4197ca7-322a-4e1c-88fc-abd98133eb48/Postingan';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json', "Authorization": "Bearer 86ccd5a820b3b2b20785162d2e71ac2d"},
    );
    //Map cannot be passed directly hence jsonEncoder converts map array into string

    //show success or fail message
    if (response.statusCode == 201) {
      titleController.text='';
      descriptionController.text='';
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
