import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String buttonName;
  double width;
  final Function()? onTapFunction;
  CustomButton(
      {Key? key,
        required this.buttonName,
        required this.onTapFunction,
        required this.width
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapFunction,
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: width,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(172, 239, 208, 1),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Text(
            buttonName,
            style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 32, 63, 1)
            ),
          ),

        ),
      );
    }
  }

