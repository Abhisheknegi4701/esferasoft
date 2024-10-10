
class AppConstants {
  static const String appName = 'ESFERASOFT';
  static const double appVersion = 1;
  static const baseUrl = "http://esferasoft.com";
  //static const baseUrl = "http://15.206.75.152:3000";
  static const getConfig = "$baseUrl/user/getConfig";

  static const String themeDark = 'Dark';
  static const String themeLight = 'Light';

  static const Map<int, String> priority= {
    0: "Low",
    1: "Medium",
    2: "High"
  };

  static const Map<int, String> status= {
    -1: "All",
    0: "Pending",
    1: "Completed",
  };

  static const headers = {
    "User-Agent":
    "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Mobile Safari/537.36",
  };

}

Map<String, String> getHeaders(String? token) {
  final headers = {
    // "accept": " */*",
    // "Content-type": "application/json",
    "Authorization": " Bearer ${token ?? 'e'}"
  };
  return headers;
}
