import 'package:paypara/core/constants/enums/base_url_enum.dart';

class ApplicationConstants {
  static const appName = "PayPara";
  static getBaseURL(BaseURL url) {
    switch (url) {
      case BaseURL.URL:
        return "paypara.azurewebsites.net";
        break;
    }
  }

  static List<String> currencyList = ["$", "€", "₺"];

  static const RESPONSE_TIMEOUT = 25;
  static const socialWebSite = "";
  static const socialFacebook = "";
  static const socialInstagram = "";
  static const socialTwitter = "";
  static const socialYoutube = "";
  static const socialLinkedin = "";
}