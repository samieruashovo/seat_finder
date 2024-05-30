class ApiEndPoints {
  // static final String baseUrl = 'http://10.0.2.2:8000/'; //emulator
  static final String baseUrl = 'http://192.168.0.102:8000/'; //physical device
}

class AuthEndPoints {
  static final String registerEmail = 'auth/users/';
  static final String loginEmail = 'auth/jwt/create/';
  static final String my_info = "auth/users/me/";
}
