import '../Models/Font.dart';

class themeService {


  String getFontFamilyFromAppFont(AppFont appFont) {
    switch (appFont) {
      case AppFont.roboto:
        return 'Roboto';
      case AppFont.openDyslexic:
        return 'OpenDyslexic'; // Replace with actual font family name
      case AppFont.dinAlternate:
        return 'DINAlternate'; // Replace with actual font family name
    }
  }
}