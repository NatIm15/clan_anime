import 'package:clan_anime/UI/theme/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Next extends StatelessWidget {
  final String msg;
  final VoidCallback tap;

  const Next({
    Key? key,
    required this.tap,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: Container(
          width: 68,
          child: TextButton(
            onPressed: tap,
            child: Text(
              msg,
              style: GoogleFonts.raleway(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
          ),
        ));
  }
}
