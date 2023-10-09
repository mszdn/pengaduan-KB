import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WAvatar_Render extends StatefulWidget {
  String? imageProfileUrl;
  double? radius;
  bool isLive;

  double maxRadius;
  double iconSize;
  Color iconColor;
  void Function()? onLive;

  WAvatar_Render(
      {super.key,
      this.imageProfileUrl,
      this.iconSize = 8,
      this.maxRadius = 50,
      this.radius = 20,
      this.isLive = false,
      this.iconColor = const Color.fromRGBO(171, 29, 69, 1),
      this.onLive});

  @override
  State<WAvatar_Render> createState() => WAvatar_RenderState();
}

class WAvatar_RenderState extends State<WAvatar_Render> {
  @override
  Widget build(BuildContext context) {
    double mediaH = MediaQuery.of(context).size.height;
    return (widget.imageProfileUrl != null)
        ? GestureDetector(
            onTap: widget.isLive ? widget.onLive : () {},
            child: CircleAvatar(
              radius: widget.maxRadius,
              backgroundImage: NetworkImage(widget.imageProfileUrl!),
              backgroundColor: widget.isLive ? Colors.amber : Colors.white,
            ),
          )
        : GestureDetector(
            onTap: widget.isLive ? widget.onLive : () {},
            child: CircleAvatar(
              // radius: 50,
              maxRadius: widget.maxRadius,
              backgroundColor: widget.isLive ? Colors.amber : Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 48,
                child: Icon(Icons.person_rounded,
                    color: widget.iconColor, size: mediaH / widget.iconSize),
              ),
            ),
          );
  }
}
