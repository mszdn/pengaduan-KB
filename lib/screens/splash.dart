import 'package:adumas/constant/Hroute.dart';
import 'package:adumas/core/cache/network.dart';
import 'package:adumas/screens/pages/createpost.dart';
import 'package:adumas/screens/pages/home.dart';
import 'package:adumas/screens/pages2/createPost.dart';
import 'package:adumas/screens/pages2/home.dart';
import 'package:adumas/screens/pages2/postingan.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/HColor.dart' as c;
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userMail;

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userMail = prefs.getString('usermail');
    });
  }

  // void onSession() async {
  //   Future.delayed(
  //     const Duration(seconds: 3),
  //     () async {
  //       //LOGINNYA DISINI
  //       sessionManager.nToken == null
  //           ? Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(builder: (_) => const LoginScreen()),
  //               (route) => false)
  //           : Navigator.pushAndRemoveUntil(
  //               context,
  //               // MaterialPageRoute(builder: (_) => const HomeScreen()),
  //               //POSTINGAN
  //               // MaterialPageRoute(builder: (_) =>  Create()),

  //               MaterialPageRoute(builder: (_) =>  Postinganlelang()),
  //               (route) => false);
  //     },
  //   );
  // }
  void onSession() async {
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }
    if (await Permission.phone.isDenied) {
      await Permission.phone.request();
    }
    if (await Permission.storage.isDenied) await Permission.storage.request();
    if (await Permission.camera.isDenied) await Permission.camera.request();

    Future.delayed(const Duration(seconds: 3), () {
      sessionManager.getPref().then((value) {
        if (value == null || value == false) {
          print("signin false");
          Navigator.pushAndRemoveUntil(context,
              MyRoute(builder: (_) => const LoginScreen()), (route) => false);
        } else if (value != null) {
          print("signin true");
          if (mounted) {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => WNavigationBar(
            //               userId: value,
            //             )),
            //     (route) => false);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Postinganlelang()),
                (route) => false);
          }
        }
      });
    });
  }

  @override
  void initState() {
    checkUser();
    onSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaH = MediaQuery.of(context).size.height;
    var mediaW = MediaQuery.of(context).size.width;
    return Container(
      color: c.white,
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("assets/icon/LogoLelanginRm.png"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
