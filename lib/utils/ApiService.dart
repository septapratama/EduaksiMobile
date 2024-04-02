import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class ApiService {
  // final String baseUrl = "http://172.17.202.137:8080/coba/mobile";
  // final String imgUrl = "http://172.17.202.137:8080/coba/mobile/images/";
  // final String fotoProfilUrl = "http://172.17.202.137:8080/coba/mobile/images/profil/";

  final String baseUrl = "http://192.168.0.101:80/eduaksi/mobile";
  final String imgUrl = "http://192.168.0.101:80/eduaksi/mobile/images/";
  final String fotoProfilUrl =
      "http://192.168.0.101:80/eduaksi/mobile/images/profil/";

  // ApiService(this.baseUrl);

  Future<Map<String, dynamic>> register(
      String nama_lengkap, String kata_sandi, String no_hp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama_lengkap': nama_lengkap,
          'kata_sandi': kata_sandi,
          'no_hp': no_hp,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Registration failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

}
