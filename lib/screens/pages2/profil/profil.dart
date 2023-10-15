import 'dart:io';

import 'package:adumas/core/cache/network.dart';
import 'package:adumas/widgets/WAvatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SnackBar sBar(
      {required String text,
      Color textColor = Colors.black,
      Color bgColor = Colors.white}) {
    return SnackBar(
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double mediaW = MediaQuery.of(context).size.width;
    double mediaH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.abc,
            color: Colors.yellow.shade600,
          )
        ],
        title: Center(
          child: Text(
            "Profil",
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.yellow.shade600,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: mediaH / 9,
          ),
          Center(
            child: Stack(
              children: [
                WAvatar_Render(
                  iconSize: 10,
                  iconColor: Color.fromRGBO(0, 0, 0, 0.541),
                  maxRadius: 70,
                  radius: 70,
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaH / 19,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "${sessionManager.nName}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.class_,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Role",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "${sessionManager.nLevel}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nomer Hp",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "${sessionManager.nPhoneNumber}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
