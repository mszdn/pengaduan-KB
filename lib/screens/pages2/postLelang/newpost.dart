// // ignore_for_file: must_be_immutable

// import 'dart:async';

// import 'package:adumas/screens/pages2/createPost.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:insta_assets_picker/insta_assets_picker.dart';

// import '../../../widgets/Walert_Dialog.dart';

// void main() => runApp(NewPostScreen());

// class NewPostScreen extends StatelessWidget {

//   NewPostScreen(
//       {super.key,
//       });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Lelangin',
//       // update to change the main theme of app + picker
//       theme: ThemeData(primarySwatch: Colors.amber),
//       home: PickerScreen(
  
//       ),
//       localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
//         // GlobalWidgetsLocalizations.delegate,
//         // GlobalMaterialLocalizations.delegate,
//         // GlobalCupertinoLocalizations.delegate,
//       ],
//     );
//   }
// }

// class PickerScreen extends StatefulWidget {

//   PickerScreen(
//       {super.key,
//       });

//   @override
//   State<PickerScreen> createState() => _PickerScreenState();
// }

// class _PickerScreenState extends State<PickerScreen> {
//   bool isCalled = false;

//   final _instaAssetsPicker = InstaAssetPicker();
//   final _provider = DefaultAssetPickerProvider(maxAssets: 5);
//   late final ThemeData _pickerTheme =
//       InstaAssetPicker.themeData(Theme.of(context).primaryColor).copyWith(
//     appBarTheme: const AppBarTheme(
//         titleTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
//   );

//   List<AssetEntity> selectedAssets = <AssetEntity>[];
//   InstaAssetsExportDetails? exportDetails;

//   Future<void> callRestorablePicker() async {
//     final List<AssetEntity>? result =
//         await _instaAssetsPicker.restorableAssetsPicker(
//       context,
//       title: 'Postingan Baru',
//       closeOnComplete: true,
//       provider: _provider,
//       pickerTheme: _pickerTheme,
//       onCompleted: (cropStream) {
//         // example withtout StreamBuilder
//         cropStream.listen((event) {
//           if (mounted) {
//             setState(() {
//               exportDetails = event;
//             });
//           }
//         });
//       },
//     );

//     if (result != null) {
//       selectedAssets = result;
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _provider.dispose();
//     _instaAssetsPicker.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isCalled == false) {
//       callRestorablePicker();
//     }
//     isCalled = true;
//     if (exportDetails == null) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Container(
//           margin: const EdgeInsets.only(bottom: 22),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width / 1.1,
//             child: WButton_Filled(
//                 () => callRestorablePicker(),
//                 const Text(
//                   "Tambah Postingan",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 context,
//                 color: Colors.red,
//                 height: 16),
//           ),
//         ),
//       );
//     }
//     return createPostingan();
//   }
// }

// // class PickerCropResultScreen extends StatelessWidget {
// //   const PickerCropResultScreen({super.key, required this.cropStream});

// //   final Stream<InstaAssetsExportDetails> cropStream;

// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.of(context).size.height - kToolbarHeight;

// //     return Scaffold(
// //       backgroundColor: c.black,
// //       appBar: AppBar(title: const Text('linimasa')),
// //       body: StreamBuilder<InstaAssetsExportDetails>(
// //         stream: cropStream,
// //         builder: (context, snapshot) => CropResultView(
// //           croppedFiles: snapshot.data?.croppedFiles ?? [],
// //           progress: snapshot.data?.progress,
// //           heightFiles: height / 2,
// //           heightAssets: height / 4,
// //         ),
// //       ),
// //     );
// //   }
// // }
