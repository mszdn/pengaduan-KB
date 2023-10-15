import 'package:flutter/material.dart';

class SeeImage extends StatefulWidget {
  SeeImage({super.key, required this.image});
  final String image;
  @override
  State<SeeImage> createState() => _SeeImageState();
}

class _SeeImageState extends State<SeeImage> {
  @override
  Widget build(BuildContext context) {
    double mediaW = MediaQuery.of(context).size.width;
    double mediaH = MediaQuery.of(context).size.height;
    return Scaffold(
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
            "Preview Image",
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
      body: Center(
        child: InteractiveViewer(
          panEnabled: false, // Set it to false to prevent panning.
          boundaryMargin: EdgeInsets.all(80),
          minScale: 0.5,
          maxScale: 4,
          child: Container(
            height: mediaH,
            width: mediaW,
            child: Image.network(widget.image),
          ),
        ),
      ),
    );
  }
}
