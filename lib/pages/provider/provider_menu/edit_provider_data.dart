import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Edit_provider_data extends StatefulWidget {
  const Edit_provider_data({Key? key}) : super(key: key);

  @override
  State<Edit_provider_data> createState() => _Edit_provider_dataState();
}

class _Edit_provider_dataState extends State<Edit_provider_data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        title: Text("ข้อมูลของผู้ให้บริการ"),
        // centerTitle: true,
      ),
    );
  }
}
