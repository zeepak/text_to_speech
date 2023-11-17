// selection_functions.dart

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:tts/constant/color.dart';

import '../Data/data.dart';

void showLanguageBottomSheet(BuildContext context, Function(String) onLanguageSelected) {
  showModalBottomSheet(
    backgroundColor: black_900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
           ListTile(
            title: Text('Select Language', style: TextStyle(fontFamily: 'SemiBold' ,fontSize: 18, color: white)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: supportedLanguages.length,
              itemBuilder: (context, index) {
                final language = supportedLanguages[index];
                final languageCode = language['code']!;
                return ListTile(
                  leading: _getLanguageIcon(languageCode),
                  title: Text(language['name']!, style: TextStyle(fontFamily: 'Regular', fontSize: 16, color: white),),
                  onTap: () {
                    onLanguageSelected(languageCode); // Callback to notify the selected language
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

Widget? _getLanguageIcon(String languageCode) {
  switch (languageCode) {
      case 'ar-eg':
    return CountryFlag.fromCountryCode("EG", height: 30, width: 42);
  case 'ar-sa':
    return CountryFlag.fromCountryCode("SA", height: 30, width: 42);
  case 'bg-bg':
    return CountryFlag.fromCountryCode("BG", height: 30, width: 42);
  case 'ca-es':
    return CountryFlag.fromCountryCode("ES", height: 30, width: 42);
  case 'zh-cn':
    return CountryFlag.fromCountryCode("CN", height: 30, width: 42);
  case 'zh-hk':
    return CountryFlag.fromCountryCode("HK", height: 30, width: 42);
  case 'zh-tw':
    return CountryFlag.fromCountryCode("TW", height: 30, width: 42);
  case 'hr-hr':
    return CountryFlag.fromCountryCode("HR", height: 30, width: 42);
  case 'cs-cz':
    return CountryFlag.fromCountryCode("CZ", height: 30, width: 42);
  case 'da-dk':
    return CountryFlag.fromCountryCode("DK", height: 30, width: 42);
  case 'nl-be':
    return CountryFlag.fromCountryCode("BE", height: 30, width: 42);
  case 'nl-nl':
    return CountryFlag.fromCountryCode("NL", height: 30, width: 42);
  case 'en-au':
    return CountryFlag.fromCountryCode("AU", height: 30, width: 42);
  case 'en-ca':
    return CountryFlag.fromCountryCode("CA", height: 30, width: 42);
  case 'en-gb':
    return CountryFlag.fromCountryCode("GB", height: 30, width: 42);
  case 'en-in':
    return CountryFlag.fromCountryCode("IN", height: 30, width: 42);
  case 'en-ie':
    return CountryFlag.fromCountryCode("IE", height: 30, width: 42);
  case 'en-us':
    return CountryFlag.fromCountryCode("US", height: 30, width: 42);
  case 'fi-fi':
    return CountryFlag.fromCountryCode("FI", height: 30, width: 42);
  case 'fr-ca':
    return CountryFlag.fromCountryCode("CA", height: 30, width: 42);
  case 'fr-fr':
    return CountryFlag.fromCountryCode("FR", height: 30, width: 42);
  case 'fr-ch':
    return CountryFlag.fromCountryCode("CH", height: 30, width: 42);
  case 'de-at':
    return CountryFlag.fromCountryCode("AT", height: 30, width: 42);
  case 'de-de':
    return CountryFlag.fromCountryCode("DE", height: 30, width: 42);
  case 'de-ch':
    return CountryFlag.fromCountryCode("CH", height: 30, width: 42);
  case 'el-gr':
    return CountryFlag.fromCountryCode("GR", height: 30, width: 42);
  case 'he-il':
    return CountryFlag.fromCountryCode("IL", height: 30, width: 42);
  case 'hi-in':
    return CountryFlag.fromCountryCode("IN", height: 30, width: 42);
  case 'hu-hu':
    return CountryFlag.fromCountryCode("HU", height: 30, width: 42);
  case 'id-id':
    return CountryFlag.fromCountryCode("ID", height: 30, width: 42);
  case 'it-it':
    return CountryFlag.fromCountryCode("IT", height: 30, width: 42);
  case 'ja-jp':
    return CountryFlag.fromCountryCode("JP", height: 30, width: 42);
  case 'ko-kr':
    return CountryFlag.fromCountryCode("KR", height: 30, width: 42);
  case 'ms-my':
    return CountryFlag.fromCountryCode("MY", height: 30, width: 42);
  case 'nb-no':
    return CountryFlag.fromCountryCode("NO", height: 30, width: 42);
  case 'pl-pl':
    return CountryFlag.fromCountryCode("PL", height: 30, width: 42);
  case 'pt-br':
    return CountryFlag.fromCountryCode("BR", height: 30, width: 42);
  case 'pt-pt':
    return CountryFlag.fromCountryCode("PT", height: 30, width: 42);
  case 'ro-ro':
    return CountryFlag.fromCountryCode("RO", height: 30, width: 42);
  case 'ru-ru':
    return CountryFlag.fromCountryCode("RU", height: 30, width: 42);
  case 'sk-sk':
    return CountryFlag.fromCountryCode("SK", height: 30, width: 42);
  case 'sl-si':
    return CountryFlag.fromCountryCode("SI", height: 30, width: 42);
  case 'es-mx':
    return CountryFlag.fromCountryCode("MX", height: 30, width: 42);
  case 'es-es':
    return CountryFlag.fromCountryCode("ES", height: 30, width: 42);
  case 'sv-se':
    return CountryFlag.fromCountryCode("SE", height: 30, width: 42);
  case 'ta-in':
    return CountryFlag.fromCountryCode("IN", height: 30, width: 42);
  case 'th-th':
    return CountryFlag.fromCountryCode("TH", height: 30, width: 42);
  case 'tr-tr':
    return CountryFlag.fromCountryCode("TR", height: 30, width: 42);
  case 'vi-vn':
    return CountryFlag.fromCountryCode("VN", height: 30, width: 42);
    
    
    default:
      return null; // Return null if no specific icon is found
  }
}

void showVoiceBottomSheet(BuildContext context, Function(String) onVoiceSelected) {
  showModalBottomSheet(
    backgroundColor: black_900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
           ListTile(
            title: Text('Select Voice', style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: white)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: supportedvoice.length,
              itemBuilder: (context, index) {
                final voice = supportedvoice[index];
                final isNormalFontWeight = voice['name']!.endsWith(')');
                final _ismale = voice['name']!.endsWith('(Male)');
                final _isfemale = voice['name']!.endsWith('(Female)');
                return ListTile(
                  leading: _ismale
                      ? Image.asset('assets/icons/male.png', height: 30, width: 30)
                      : _isfemale
                          ? Image.asset('assets/icons/female.png', height: 30, width: 30)
                          : null,
                  title: Text(
                    voice['name']!,
                    style: TextStyle(
                      fontFamily: isNormalFontWeight? 'Regular' : 'Medium', 
                      fontSize: isNormalFontWeight? 16 : 17,
                      color: white
                    ),
                  ),
                  onTap: isNormalFontWeight
                      ? () {
                          onVoiceSelected(voice['code']!); // Callback to notify the selected voice
                          Navigator.pop(context);
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

void showFormatBottomSheet(BuildContext context, Function(String) onFormatSelected) {
  showModalBottomSheet(
     backgroundColor: black_900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          ListTile(
            title: Text('Select Format', style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: white)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: supportedformat.length,
              itemBuilder: (context, index) {
                final format = supportedformat[index];
                return ListTile(
                  leading: Image.asset('assets/icons/format.png', height: 30, width: 30,),
                  title: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      format['name']!,
                      style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 16,
                        color: white,
                      ),
                    ),
                  ),
                  onTap: 
                       () {
                          onFormatSelected(format['code']!); 
                          Navigator.pop(context);
                        }
                      
                );
              },
            ),
          ),
        ],
      );
    },
  );
}