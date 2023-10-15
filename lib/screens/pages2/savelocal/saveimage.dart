import 'dart:io';

import 'package:adumas/screens/pages2/printToPdf.dart/pdfpreview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class saveimage extends StatefulWidget {
  saveimage({super.key, required this.image, this.title, this.description});
  final String image;
  final String? title;
  final String? description;

  @override
  State<saveimage> createState() => _saveimageState();
}

class _saveimageState extends State<saveimage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(widget.image),
          ElevatedButton(
              onPressed: () async {
                var response = await http.get(Uri.parse(widget.image));
                Directory? externalStorrageDirectory =
                    await getExternalStorageDirectory();
                File file = new File(path.join(externalStorrageDirectory!.path,
                    path.basename(widget.image)));
                await file.writeAsBytes(response.bodyBytes);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("sukses"),
                      content: Image.file(file),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PdfPreviewPage(
                                  title: "${widget.title}",
                                  description: "${widget.description}",
                                  image: "${file}",
                                );
                              }));
                            },
                            child: Text("Save Ke Pdf"))
                      ],
                    );
                  },
                );
              },
              child: Text("save"))
        ],
      ),
    );
  }
}
