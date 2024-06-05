// ignore_for_file: constant_identifier_names

class ApiEndPoints {
  // static final String baseUrl = 'http://10.0.2.2:8000/'; //emulator
  static const String baseUrl = 'http://192.168.0.104:8000/'; //physical device
}

class AuthEndPoints {
  static const String registerEmail = 'auth/users/';
  static const String loginEmail = 'auth/jwt/create/';
  static const String my_info = "auth/users/me/";
  static const String my_events = "api/myevents/";
  static const String event_speaker_list = "apt/events/speakers/";
  static const String event_image_list = "api/events/images/";
  static const String register_event = "api/events/register/";
  // static final String interest_event = "api/events/interest/";
  static const String event_reg_list = "api/events/registerd/";
  static const String event_interested_list = "api/events/interested/";
}
