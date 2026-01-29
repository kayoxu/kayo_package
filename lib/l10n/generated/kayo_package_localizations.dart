import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'kayo_package_localizations_ar.dart';
import 'kayo_package_localizations_bn.dart';
import 'kayo_package_localizations_de.dart';
import 'kayo_package_localizations_en.dart';
import 'kayo_package_localizations_es.dart';
import 'kayo_package_localizations_fr.dart';
import 'kayo_package_localizations_hi.dart';
import 'kayo_package_localizations_id.dart';
import 'kayo_package_localizations_it.dart';
import 'kayo_package_localizations_ja.dart';
import 'kayo_package_localizations_ko.dart';
import 'kayo_package_localizations_ms.dart';
import 'kayo_package_localizations_nl.dart';
import 'kayo_package_localizations_pl.dart';
import 'kayo_package_localizations_pt.dart';
import 'kayo_package_localizations_ru.dart';
import 'kayo_package_localizations_sv.dart';
import 'kayo_package_localizations_th.dart';
import 'kayo_package_localizations_tr.dart';
import 'kayo_package_localizations_uk.dart';
import 'kayo_package_localizations_vi.dart';
import 'kayo_package_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of KayoPackageLocalizations
/// returned by `KayoPackageLocalizations.of(context)`.
///
/// Applications need to include `KayoPackageLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/kayo_package_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: KayoPackageLocalizations.localizationsDelegates,
///   supportedLocales: KayoPackageLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the KayoPackageLocalizations.supportedLocales
/// property.
abstract class KayoPackageLocalizations {
  KayoPackageLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static KayoPackageLocalizations? of(BuildContext context) {
    return Localizations.of<KayoPackageLocalizations>(
        context, KayoPackageLocalizations);
  }

  static const LocalizationsDelegate<KayoPackageLocalizations> delegate =
      _KayoPackageLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sv'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @month1.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get month1;

  /// No description provided for @month2.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get month2;

  /// No description provided for @month3.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get month3;

  /// No description provided for @month4.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get month4;

  /// No description provided for @month5.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get month5;

  /// No description provided for @month6.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get month6;

  /// No description provided for @month7.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get month7;

  /// No description provided for @month8.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get month8;

  /// No description provided for @month9.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get month9;

  /// No description provided for @month10.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get month10;

  /// No description provided for @month11.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get month11;

  /// No description provided for @month12.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get month12;

  /// No description provided for @monthShort1.
  ///
  /// In en, this message translates to:
  /// **'Jan.'**
  String get monthShort1;

  /// No description provided for @monthShort2.
  ///
  /// In en, this message translates to:
  /// **'Feb.'**
  String get monthShort2;

  /// No description provided for @monthShort3.
  ///
  /// In en, this message translates to:
  /// **'Mar.'**
  String get monthShort3;

  /// No description provided for @monthShort4.
  ///
  /// In en, this message translates to:
  /// **'Apr.'**
  String get monthShort4;

  /// No description provided for @monthShort5.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthShort5;

  /// No description provided for @monthShort6.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthShort6;

  /// No description provided for @monthShort7.
  ///
  /// In en, this message translates to:
  /// **'Jul.'**
  String get monthShort7;

  /// No description provided for @monthShort8.
  ///
  /// In en, this message translates to:
  /// **'Aug.'**
  String get monthShort8;

  /// No description provided for @monthShort9.
  ///
  /// In en, this message translates to:
  /// **'Sep.'**
  String get monthShort9;

  /// No description provided for @monthShort10.
  ///
  /// In en, this message translates to:
  /// **'Oct.'**
  String get monthShort10;

  /// No description provided for @monthShort11.
  ///
  /// In en, this message translates to:
  /// **'Nov.'**
  String get monthShort11;

  /// No description provided for @monthShort12.
  ///
  /// In en, this message translates to:
  /// **'Dec.'**
  String get monthShort12;

  /// No description provided for @week1.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get week1;

  /// No description provided for @week2.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get week2;

  /// No description provided for @week3.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get week3;

  /// No description provided for @week4.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get week4;

  /// No description provided for @week5.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get week5;

  /// No description provided for @week6.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get week6;

  /// No description provided for @week7.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get week7;

  /// No description provided for @weekShort1.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekShort1;

  /// No description provided for @weekShort2.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekShort2;

  /// No description provided for @weekShort3.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekShort3;

  /// No description provided for @weekShort4.
  ///
  /// In en, this message translates to:
  /// **'Thur'**
  String get weekShort4;

  /// No description provided for @weekShort5.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekShort5;

  /// No description provided for @weekShort6.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekShort6;

  /// No description provided for @weekShort7.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekShort7;

  /// No description provided for @selectTimeText.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTimeText;

  /// No description provided for @selectTimeRangeText.
  ///
  /// In en, this message translates to:
  /// **'Select Time Range'**
  String get selectTimeRangeText;

  /// No description provided for @startTimeText.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTimeText;

  /// No description provided for @endTimeText.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTimeText;

  /// No description provided for @endTimeGreaterStartTimeText.
  ///
  /// In en, this message translates to:
  /// **'The end time cannot be earlier than the start time'**
  String get endTimeGreaterStartTimeText;

  /// No description provided for @noMessagesToStartNewChat.
  ///
  /// In en, this message translates to:
  /// **'Current chat is empty, cannot start a new chat'**
  String get noMessagesToStartNewChat;

  /// No description provided for @startNewChatFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create new chat'**
  String get startNewChatFailed;

  /// No description provided for @deleteSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Session'**
  String get deleteSessionTitle;

  /// No description provided for @deleteSessionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this session?'**
  String get deleteSessionConfirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete session'**
  String get deleteSessionFailed;

  /// No description provided for @loadSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load session'**
  String get loadSessionFailed;

  /// No description provided for @newChat.
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get newChat;

  /// No description provided for @chatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get chatHistory;

  /// No description provided for @mine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get mine;

  /// No description provided for @startNewChatHint.
  ///
  /// In en, this message translates to:
  /// **'Start a new chat!'**
  String get startNewChatHint;

  /// No description provided for @startNewChatHintInput.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get startNewChatHintInput;

  /// No description provided for @sendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message'**
  String get sendFailed;

  /// No description provided for @session.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get session;

  /// No description provided for @userLoginExit.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get userLoginExit;

  /// No description provided for @multipleChoices.
  ///
  /// In en, this message translates to:
  /// **'Multiple choices'**
  String get multipleChoices;

  /// No description provided for @nullText.
  ///
  /// In en, this message translates to:
  /// **'null'**
  String get nullText;

  /// No description provided for @loadingText.
  ///
  /// In en, this message translates to:
  /// **'loading...'**
  String get loadingText;

  /// No description provided for @pleaseSelect.
  ///
  /// In en, this message translates to:
  /// **'Please Select'**
  String get pleaseSelect;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'MM-dd-yyyy HH:mm'**
  String get dateFormat;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @selectNavigationMap.
  ///
  /// In en, this message translates to:
  /// **'Select navigation map'**
  String get selectNavigationMap;

  /// No description provided for @appleMap.
  ///
  /// In en, this message translates to:
  /// **'Apple Map'**
  String get appleMap;

  /// No description provided for @googleMap.
  ///
  /// In en, this message translates to:
  /// **'Google Map'**
  String get googleMap;

  /// No description provided for @baiduMap.
  ///
  /// In en, this message translates to:
  /// **'Baidu Map'**
  String get baiduMap;

  /// No description provided for @gaodeMap.
  ///
  /// In en, this message translates to:
  /// **'Gaode Map'**
  String get gaodeMap;

  /// No description provided for @tencentMap.
  ///
  /// In en, this message translates to:
  /// **'QQ Map'**
  String get tencentMap;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @inputLicensePlate.
  ///
  /// In en, this message translates to:
  /// **'Please enter license plate number'**
  String get inputLicensePlate;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @province.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// No description provided for @userAgreementTitle.
  ///
  /// In en, this message translates to:
  /// **'《User Agreement》'**
  String get userAgreementTitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'《Privacy Policy》'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyOverview.
  ///
  /// In en, this message translates to:
  /// **'Software Service Agreement and Privacy Policy Overview'**
  String get privacyOverview;

  /// No description provided for @privacyData.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support! We attach great importance to your personal information and privacy protection. To better protect your personal rights and interests, before using our products, please read all terms in {userTitle} and {privacyTitle} carefully, especially:\n 1. Rules regarding our collection/storage/use/sharing/protection of your personal information, and your user rights;\n 2. Our limitations of liability and disclaimer clauses;\n 3. Other important clauses marked in color or bold.\nIf you have any questions about the above agreement, please contact us via customer service or email at 40286206@qq.com. Your clicking \"Agree and Continue\" indicates that you have read and agreed to the entire content of the above agreement. Please read and fully understand the relevant terms, especially the bolded ones, to understand your rights. Clicking \"Agree\" means you have carefully read and agreed to this {userTitle} and {privacyTitle}, and we will do our best to protect your legitimate rights and interests and continue to provide quality products and services. Clicking \"Disagree\" may result in your inability to continue using our products and services.'**
  String privacyData(String userTitle, String privacyTitle);

  /// No description provided for @disagree.
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get disagree;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @pageError.
  ///
  /// In en, this message translates to:
  /// **'Page Error'**
  String get pageError;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @noImages.
  ///
  /// In en, this message translates to:
  /// **'No images available'**
  String get noImages;
}

class _KayoPackageLocalizationsDelegate
    extends LocalizationsDelegate<KayoPackageLocalizations> {
  const _KayoPackageLocalizationsDelegate();

  @override
  Future<KayoPackageLocalizations> load(Locale locale) {
    return SynchronousFuture<KayoPackageLocalizations>(
        lookupKayoPackageLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bn',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'it',
        'ja',
        'ko',
        'ms',
        'nl',
        'pl',
        'pt',
        'ru',
        'sv',
        'th',
        'tr',
        'uk',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_KayoPackageLocalizationsDelegate old) => false;
}

KayoPackageLocalizations lookupKayoPackageLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return KayoPackageLocalizationsAr();
    case 'bn':
      return KayoPackageLocalizationsBn();
    case 'de':
      return KayoPackageLocalizationsDe();
    case 'en':
      return KayoPackageLocalizationsEn();
    case 'es':
      return KayoPackageLocalizationsEs();
    case 'fr':
      return KayoPackageLocalizationsFr();
    case 'hi':
      return KayoPackageLocalizationsHi();
    case 'id':
      return KayoPackageLocalizationsId();
    case 'it':
      return KayoPackageLocalizationsIt();
    case 'ja':
      return KayoPackageLocalizationsJa();
    case 'ko':
      return KayoPackageLocalizationsKo();
    case 'ms':
      return KayoPackageLocalizationsMs();
    case 'nl':
      return KayoPackageLocalizationsNl();
    case 'pl':
      return KayoPackageLocalizationsPl();
    case 'pt':
      return KayoPackageLocalizationsPt();
    case 'ru':
      return KayoPackageLocalizationsRu();
    case 'sv':
      return KayoPackageLocalizationsSv();
    case 'th':
      return KayoPackageLocalizationsTh();
    case 'tr':
      return KayoPackageLocalizationsTr();
    case 'uk':
      return KayoPackageLocalizationsUk();
    case 'vi':
      return KayoPackageLocalizationsVi();
    case 'zh':
      return KayoPackageLocalizationsZh();
  }

  throw FlutterError(
      'KayoPackageLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
