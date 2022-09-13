import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> dialong(BuildContext context, String message) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: Text(message, style: GoogleFonts.mitr(fontSize: 18)),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("ตกลง",
                            style: GoogleFonts.mitr(fontSize: 18))),
                  ),
                ],
              )
            ],
          ));
}
