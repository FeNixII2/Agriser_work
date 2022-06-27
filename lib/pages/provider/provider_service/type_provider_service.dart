import 'package:agriser_work/pages/provider/provider_service/add_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/allmethod.dart';

class Type_provider_service extends StatefulWidget {
  const Type_provider_service({Key? key}) : super(key: key);

  @override
  State<Type_provider_service> createState() => _Type_provider_serviceState();
}

class _Type_provider_serviceState extends State<Type_provider_service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: RaisedButton(
                    child: Text("รถเกี่ยวข้าว"),
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service());
                      Navigator.push(context, route);
                    },
                  ),
                ),
              ],
            ),
            Allmethod().Space(),
          ],
        ),
      ),
    );
  }
}
