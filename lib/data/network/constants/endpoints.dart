class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://192.168.100.83:8000/api";

  // receiveTimeout
  static const int receiveTimeout = 45000;

  // connectTimeout
  static const int connectionTimeout = 60000;

  // booking endpoints
  static const String login = baseUrl + "/login";
  static const String getPosts = baseUrl + "/complaints";
}