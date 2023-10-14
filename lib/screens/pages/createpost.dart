import 'dart:developer';
import 'dart:io';

import 'package:adumas/main.dart';
import 'package:adumas/screens/pages/home.dart';
import 'package:flutter/material.dart';

import '../../core/services/complaint_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

class Create extends StatefulWidget {
  const Create({
    Key? key,
  }) : super(key: key);
  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _tanggapan = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  bool _isLoading = false;

  createContact() {
    setState(() {
      _isLoading = true;
    });
    PhoneService()
        .createPhoneContact(_fullname.text, _description.text, _tanggapan.text,
            int.parse(_phonenumber.text))
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact created successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating contact!')),
      );
    });
  }

  File? imageFile;
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
        //     builder: (context) => ImageCameraPost(
        //           image: imageFile!.path,
        //         )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaW = MediaQuery.of(context).size.width;
    double mediaH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Postingan Lelang"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black,
                                          title: Text(
                                            'Pilih Sumber Upload',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          content: const Text(''),
                                          actions: <Widget>[
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        // isLoading = true;
                                                      });
                                                      // Position position =
                                                      //     await _getGeoLocationPosition();
                                                      // setState(() {
                                                      //   lokasi =
                                                      //       "${position.latitude} ${position.longitude}";
                                                      //   print(
                                                      //       "INI LATLONG BOLO ${lokasi}");
                                                      // });
                                                      // getAddressFromLongLat(
                                                      //     position);
                                                      setState(() {
                                                        // isLoading = false;
                                                      });
                                                      Navigator.pop(context);
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             NewPostScreen(
                                                      //               kabupaten:
                                                      //                   kabupaten,
                                                      //               kecamatan:
                                                      //                   kecamatan,
                                                      //               provinsi:
                                                      //                   provinsi,
                                                      //               location: lokasi,
                                                      //               alamatLengkap:
                                                      //                   lokasiLengkap,
                                                      //             )));
                                                    },
                                                    child: Container(
                                                      width: mediaW / 3.4,
                                                      height: mediaH / 7,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.image,
                                                            size: mediaW / 7,
                                                            color: Colors.white,
                                                          ),
                                                          const Text(
                                                            'Pilih Dari Galeri',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: mediaW / 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      // setState(() {
                                                      //   isLoading = true;
                                                      // });
                                                      // Position position =
                                                      //     await _getGeoLocationPosition();
                                                      // setState(() {
                                                      //   lokasi =
                                                      //       "${position.latitude} ${position.longitude}";
                                                      //   print(
                                                      //       "INI LATLONG BOLO ${lokasi}");
                                                      // });
                                                      // getAddressFromLongLat(
                                                      //     position);
                                                      // setState(() {
                                                      //   isLoading = false;
                                                      // });

                                                      _getCamerraPhoto();
                                                      Navigator.pop(context);
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             NewPostScreen(
                                                      //               kabupaten:
                                                      //                   kabupaten,
                                                      //               kecamatan:
                                                      //                   kecamatan,
                                                      //               provinsi:
                                                      //                   provinsi,
                                                      //               location:
                                                      //                   lokasi,
                                                      //               alamatLengkap:
                                                      //                   lokasiLengkap,
                                                      //             )));
                                                    },
                                                    child: Container(
                                                      width: mediaW / 3.4,
                                                      height: mediaH / 7,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .camera_alt_rounded,
                                                            size: mediaW / 7,
                                                            color: Colors.white,
                                                          ),
                                                          const Text(
                                                            'Ambil Foto',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    'Photo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      // backgroundColor: c.black,
                                      title: Text(
                                        'Pilih Sumber Upload',
                                        style: TextStyle(
                                            // color: c.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      content: const Text(''),
                                      actions: <Widget>[
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    // isLoading = true;
                                                  });
                                                  // Position position =
                                                  //     await _getGeoLocationPosition();
                                                  // setState(() {
                                                  //   lokasi =
                                                  //       "${position.latitude} ${position.longitude}";
                                                  //   print(
                                                  //       "INI LATLONG BOLO ${lokasi}");
                                                  // });
                                                  // getAddressFromLongLat(
                                                  //     position);
                                                  setState(() {
                                                    // isLoading = false;
                                                  });
                                                  Navigator.pop(context);
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             NewPostScreen(
                                                  //               kabupaten:
                                                  //                   kabupaten,
                                                  //               kecamatan:
                                                  //                   kecamatan,
                                                  //               provinsi:
                                                  //                   provinsi,
                                                  //               location: lokasi,
                                                  //               alamatLengkap:
                                                  //                   lokasiLengkap,
                                                  //             )));
                                                },
                                                child: Container(
                                                  width: mediaW / 3.4,
                                                  height: mediaH / 7,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.image,
                                                        size: mediaW / 7,
                                                        color: Colors.white,
                                                      ),
                                                      const Text(
                                                        'Pilih Dari Galeri',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: mediaW / 20,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  // setState(() {
                                                  //   isLoading = true;
                                                  // });
                                                  // Position position =
                                                  //     await _getGeoLocationPosition();
                                                  // setState(() {
                                                  //   lokasi =
                                                  //       "${position.latitude} ${position.longitude}";
                                                  //   print(
                                                  //       "INI LATLONG BOLO ${lokasi}");
                                                  // });
                                                  // getAddressFromLongLat(
                                                  //     position);
                                                  // setState(() {
                                                  //   isLoading = false;
                                                  // });

                                                  _getCamerraPhoto();
                                                  Navigator.pop(context);
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             NewPostScreen(
                                                  //               kabupaten:
                                                  //                   kabupaten,
                                                  //               kecamatan:
                                                  //                   kecamatan,
                                                  //               provinsi:
                                                  //                   provinsi,
                                                  //               location:
                                                  //                   lokasi,
                                                  //               alamatLengkap:
                                                  //                   lokasiLengkap,
                                                  //             )));
                                                },
                                                child: Container(
                                                  width: mediaW / 3.4,
                                                  height: mediaH / 7,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .camera_alt_rounded,
                                                        size: mediaW / 7,
                                                        color: Colors.white,
                                                      ),
                                                      const Text(
                                                        'Ambil Foto',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: IW_Image(
                                mediaH: mediaH,
                                mediaW: mediaW,
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _fullname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input your fullname';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: "Deskripsi",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                      ),
                      const SizedBox(height: 30.0),
                      // const Text(
                      //   'Detail Laporan',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 14.0,
                      //   ),
                      // ),
                      // const SizedBox(height: 5.0),
                      // TextFormField(
                      //   controller: _description,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please input your Description';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 20),
                      //     hintText: "input detail",
                      //     fillColor: Colors.white,
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(color: Colors.grey),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(color: Colors.grey),
                      //     ),
                      //     errorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(color: Colors.red),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.text,
                      //   maxLines: null,
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // const Text(
                      //   'NIK',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 14.0,
                      //   ),
                      // ),
                      // const SizedBox(height: 5.0),
                      // TextFormField(
                      //   controller: _phonenumber,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please input your phone number';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 20),
                      //     hintText: "input nik",
                      //     fillColor: Colors.white,
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(color: Colors.grey),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(color: Colors.grey),
                      //     ),
                      //     errorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(color: Colors.red),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.number,
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: TextButton(
                  onPressed: _isLoading
                      ? () {
                          CircularProgressIndicator(
                            value: 12,
                          );
                        }
                      : () {
                          if (_formKey.currentState!.validate()) {
                            createContact();
                          }
                        },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: const Text(
                    'Upload Lelang',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget IW_AddImage(
//     {required double mediaH, required double mediaW, File? image}) {
//   return DottedBorder(
//     borderType: BorderType.RRect,
//     radius: const Radius.circular(8),
//     padding: const EdgeInsets.all(12),
//     color: Colors.black,
//     child: ClipRRect(
//       borderRadius: const BorderRadius.all(Radius.circular(8)),
//       child: SizedBox(
//         height: mediaH / 3.5,
//         width: mediaW,
//         child: const Center(
//           child: Text(
//             "Tambah Foto",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 12,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget IW_Image({
  required double mediaH,
  required double mediaW,
  // required File image,
  // required int index
}) {
  return Container(
    margin: EdgeInsets.only(right: mediaH / 190),
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      padding: const EdgeInsets.all(12),
      color: Color.fromARGB(255, 0, 0, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: SizedBox(
          height: mediaH / 3.5,
          width: mediaW,
          child: Center(
            child: Text("Upload Foto"),
            // child: Image.file(
            //   File(image.path),
            //   fit: BoxFit.contain,
            //   height: mediaH / 3.5,
            //   width: mediaW,
            // ),
          ),
        ),
      ),
    ),
  );
}
