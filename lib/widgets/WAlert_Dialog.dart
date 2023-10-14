import 'package:flutter/material.dart';

Dialog WDialong_ConfirmAlert(BuildContext context, String title,
    {description = '',
    confirm = 'Lanjut',
    cancel = 'Batal',
    bool isLoad = false,
    VoidCallback? onConfirm}) {
  double mediaW = MediaQuery.of(context).size.width;
  return Dialog(
    elevation: 0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(description),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            width: mediaW,
            height: 50,
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () async {
                onConfirm!();
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  confirm,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            width: mediaW,
            height: 50,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  cancel,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget WButton_Filled(void Function() onPressed, child, BuildContext context,
    {double width = 1,
    double height = 12,
    double fontSize = 18,
    double iconSize = 22,
    Color color = const Color(0xffffffff),
    bool isDisabled = false}) {
  double mediaW = MediaQuery.of(context).size.width;
  double mediaH = MediaQuery.of(context).size.height;
  return ElevatedButton(
    child: child,
    onPressed: isDisabled ? () {} : onPressed,
    style: ButtonStyle(
      visualDensity: VisualDensity.comfortable,
      elevation: MaterialStateProperty.all<double>(5),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediaW / 30),
      )),
      iconSize: MaterialStateProperty.all<double>(iconSize),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      backgroundColor:
          MaterialStateProperty.all<Color>(isDisabled ? Colors.black : color),
      fixedSize: MaterialStateProperty.all<Size?>(
          Size(mediaW / width, mediaH / height)),
    ),
  );
}
