// import 'package:adumas/screens/pages2/printToPdf.dart/pdfpreview.dart';
// import 'package:flutter/material.dart';

// class CreatePdfMainPage extends StatelessWidget {
//   CreatePdfMainPage({super.key});

//   String text = "Your text to display below image";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Articles page"),
//       ),
//       body: Column(
//         children: [
//           Image.asset("assets/icon/LogoLelanginRm.png"),
//           Text(text),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//             return PdfPreviewPage(text, widget);
//           }));
//         },
//         child: const Icon(Icons.picture_as_pdf_sharp),
//       ),
//     );
//   }
// }
