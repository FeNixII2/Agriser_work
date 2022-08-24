import 'package:http/http.dart' as http;

class ipinfoapi {
  static Future<String?> getIPAddress() async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      final respones = await http.get(url);

      return respones.statusCode == 200 ? respones.body : null;
    } catch (e) {
      return null;
    }
  }
}
