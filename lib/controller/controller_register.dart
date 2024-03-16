// controller_register.dart
class RegisterController {
  String evaluatePasswordStrength(String password) {
    if (password.length >= 8 &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Kuat';
    } else if (password.length >= 8 &&
        (password.contains(RegExp(r'[0-9]')) ||
            password.contains(RegExp(r'[a-zA-Z]')))) {
      return 'Sedang';
    } else {
      return 'Rendah';
    }
  }

  String validatePasswordMatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Kata sandi tidak sama';
    } else {
      return '';
    }
  }
}
