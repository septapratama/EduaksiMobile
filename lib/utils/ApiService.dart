import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl = "http://192.168.0.101:8000/api/mobile";
  // final String baseUrl = "https://eduaksi.amirzan.my.id/api/mobile";
  final String imgUrl = "http://192.168.0.101:8000/img/";
  final String fotoProfilUrl =
      "http://192.168.0.101:80/eduaksi/mobile/images/profil/";
  Future<Map<String, dynamic>> register(
      String email, String nama_lengkap, String kata_sandi, String kata_sandi_ulang) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'nama_lengkap': nama_lengkap,
          'password': kata_sandi,
          'password_confirm': kata_sandi_ulang,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }
  //Login
  Future<Map<String, dynamic>> login(
      String email, String kata_sandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': kata_sandi,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }
  //Send data google login
  Future<Map<String, dynamic>> loginGoogle(
      String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login/google'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }
  //lupa kata sandi
  Future<Map<String, dynamic>> lupaPassword(
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat lupa password : $e');
    }
  }
  //send otp
  Future<Map<String, dynamic>> sendOtp(
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat kirim otp : $e');
    }
  }
  //kirim ulang kode otp
  Future<Map<String, dynamic>> resendCodeOtp(
      String email, String kata_sandi, String no_hp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'kata_sandi': kata_sandi,
          'no_hp': no_hp,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat kirim ulang otp : $e');
    }
  }
  //get profile
  Future<Map<String, dynamic>> getProfile(
      String email, String kata_sandi, String no_hp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'kata_sandi': kata_sandi,
          'no_hp': no_hp,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat kirim ulang otp : $e');
    }
  }
  //update profile
  Future<Map<String, dynamic>> updateProfile(
      String email, String nama_lengkap, String no_hp, String kata_sandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'nama_lengkap': nama_lengkap,
          'no_hp': no_hp,
          'kata_sandi': kata_sandi,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
    }
  }
  Future<List<Map<String, dynamic>>> getKonsultasi() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/'));
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return responseData;
      } else {
        throw Exception(
            'Failed to get products. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }
  //get konsultasi detail
  Future<Map<String, dynamic>> getKonsultasiDetail(String idKonsultasi) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/konsultasi/$idKonsultasi'),
        headers: <String, String>{
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
    }
  }
}