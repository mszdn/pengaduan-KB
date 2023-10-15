import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatefulWidget {
  String title;
  String description;
  final String image;
  PdfPreviewPage(
      {required this.title,
      required this.description,
      required this.image,
      super.key});

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade600,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'PDF Preview',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load(widget.image);
    final Uint8List byteList = bytes.buffer.asUint8List();
    final image = await imageFromAssetBundle("${widget.image}");
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // pw.Image(image),

                      pw.Image(pw.MemoryImage(byteList),
                          fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                    ]),
                // pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Header(text: "${widget.title}", level: 1),
                pw.Header(text: "${widget.description}", level: 1),
              ]);
        }));
    return pdf.save();
  }
}
