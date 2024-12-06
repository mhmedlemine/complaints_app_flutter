class Endpoints {
  Endpoints._();

  // base url
  static const String mainUrl = "http://192.168.81.45:8000";
  static const String baseUrl = "http://192.168.81.45:8000/api";
  // static const String baseUrl = "http://64.226.96.44/api";

  // receiveTimeout
  static const int receiveTimeout = 45000;

  // connectTimeout
  static const int connectionTimeout = 60000;

  // booking endpoints
  static const String login = baseUrl + "/login";
  static const String getPosts = baseUrl + "/complaints";
  static const String addEntreprise = baseUrl + "/addEntreprise";
  static const String addMerchant = baseUrl + "/addMerchant";
  static const String addConsumer = baseUrl + "/addConsumer";
  static const String addCheckup = baseUrl + "/addCheckup";
  static const String getMyEntreprises = baseUrl + "/my-entreprises";
  static const String getMyCheckups = baseUrl + "/my-checkups";
  static const String getMySummons = baseUrl + "/my-summons";
  static const String getInfractions = baseUrl + "/getInfractions";
  static const String getEntrepriseByLocation = baseUrl + "/getClosestShop";
  static const String getEntrepriseCode = baseUrl + "/getEntrepriseCode";
  static const String getMerchants = baseUrl + "/getMerchants";
  static const String searchMerchant = baseUrl + "/entreprises/merchants/search";
  static const String searchConsumer = baseUrl + "/complaints/consumers/search";
  static const String getMoughataas = baseUrl + "/getMoughataas";

  // CHECKUPS
  static const String startCheckup = baseUrl + "/checkups/start";
  static String saveCheckup(checkupId) => baseUrl + "/checkups/$checkupId/progress";
  static String submitCheckup(checkupId) => baseUrl + "/checkups/$checkupId/submit";
  static String cancelCheckup(checkupId) => baseUrl + "/checkups/$checkupId/cancel";
  static String submitComplaint = baseUrl + "/complaints/submit";

}