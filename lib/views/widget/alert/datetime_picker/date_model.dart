import 'date_format.dart';
import 'i18n_model.dart';

import 'datetime_util.dart';

//interface for picker data model
abstract class BasePickerModel {
  //a getter method for left column data, return null to end list
  String? leftStringAtIndex(int index);

  //a getter method for middle column data, return null to end list
  String? middleStringAtIndex(int index);

  //a getter method for right column data, return null to end list
  String? rightStringAtIndex(int index);

  String? rightStringAtIndex01(int index);

  //set selected left index
  void setLeftIndex(int index);

  //set selected middle index
  void setMiddleIndex(int index);

  //set selected right index
  void setRightIndex(int index);

  void setRightIndex01(int index);

  //return current left index
  int? currentLeftIndex();

  //return current middle index
  int? currentMiddleIndex();

  //return current right index
  int? currentRightIndex();

  int? currentRightIndex01();

  //return final time
  DateTime? finalTime();

  //return left divider string
  String? leftDivider();

  //return right divider string
  String? rightDivider();

  String? rightDivider01();

  //layout proportions for 3 columns
  List<int>? layoutProportions();
}

//a base class for picker data model
class CommonPickerModel extends BasePickerModel {
  late List<String> leftList;
  late List<String> middleList;
  late List<String> rightList;
  late List<String> rightList01;
  DateTime? currentTime;
  int? _currentLeftIndex;
  int? _currentMiddleIndex;
  int? _currentRightIndex;
  int? _currentRightIndex01;

  LocaleType locale;

  CommonPickerModel({this.currentTime, locale})
      : this.locale = locale ?? LocaleType.zh;

  @override
  String? leftStringAtIndex(int index) {
    return null;
  }

  @override
  String? middleStringAtIndex(int index) {
    return null;
  }

  @override
  String? rightStringAtIndex(int index) {
    return null;
  }

  @override
  String? rightStringAtIndex01(int index) {
    return null;
  }

  @override
  int? currentLeftIndex() {
    return _currentLeftIndex;
  }

  @override
  int? currentMiddleIndex() {
    return _currentMiddleIndex;
  }

  @override
  int? currentRightIndex() {
    return _currentRightIndex;
  }

  @override
  int? currentRightIndex01() {
    return _currentRightIndex01;
  }

  @override
  void setLeftIndex(int index) {
    _currentLeftIndex = index;
  }

  @override
  void setMiddleIndex(int index) {
    _currentMiddleIndex = index;
  }

  @override
  void setRightIndex(int index) {
    _currentRightIndex = index;
  }

  @override
  void setRightIndex01(int index) {
    _currentRightIndex01 = index;
  }

  @override
  String? leftDivider() {
    return "";
  }

  @override
  String? rightDivider() {
    return "";
  }

  @override
  String? rightDivider01() {
    return "";
  }

  @override
  List<int>? layoutProportions() {
    return [1, 1, 1];
  }

  @override
  DateTime? finalTime() {
    return null;
  }
}

//a date picker model
class DatePickerModel extends CommonPickerModel {
  DateTime? maxTime;
  DateTime? minTime;
  String? formatType;

  DatePickerModel(
      {DateTime? currentTime,
      DateTime? maxTime,
      DateTime? minTime,
      String? formatType,
      LocaleType? locale})
      : super(locale: locale) {
    this.maxTime = maxTime ?? DateTime(2049, 12, 31);
    this.minTime = minTime ?? DateTime(1970, 1, 1);
    this.formatType = formatType;

    currentTime = currentTime ?? DateTime.now();
    if (currentTime != null) {
      if (currentTime.compareTo(this.maxTime!) > 0) {
        currentTime = this.maxTime;
      } else if (currentTime.compareTo(this.minTime!) < 0) {
        currentTime = this.minTime;
      }
    }
    this.currentTime = currentTime;

    _fillLeftLists();
    _fillMiddleLists();
    _fillRightLists();
    int minMonth = _minMonthOfCurrentYear();
    int minDay = _minDayOfCurrentMonth();
    _currentLeftIndex = this.currentTime!.year - this.minTime!.year;
    _currentMiddleIndex = this.currentTime!.month - minMonth;
    _currentRightIndex = this.currentTime!.day - minDay;
  }

  void _fillLeftLists() {
    this.leftList =
        List.generate(maxTime!.year - minTime!.year + 1, (int index) {
      // print('LEFT LIST... ${minTime.year + index}${_localeYear()}');
      return '${minTime!.year + index}${_localeYear()}';
    });
  }

  int _maxMonthOfCurrentYear() {
    return currentTime!.year == maxTime!.year ? maxTime!.month : 12;
  }

  int _minMonthOfCurrentYear() {
    return currentTime!.year == minTime!.year ? minTime!.month : 1;
  }

  int _maxDayOfCurrentMonth() {
    int dayCount = calcDateCount(currentTime!.year, currentTime!.month);
    return currentTime!.year == maxTime!.year &&
            currentTime!.month == maxTime!.month
        ? maxTime!.day
        : dayCount;
  }

  int _minDayOfCurrentMonth() {
    return currentTime!.year == minTime!.year &&
            currentTime!.month == minTime!.month
        ? minTime!.day
        : 1;
  }

  void _fillMiddleLists() {
    int minMonth = _minMonthOfCurrentYear();
    int maxMonth = _maxMonthOfCurrentYear();

    this.middleList = List.generate(maxMonth - minMonth + 1, (int index) {
      return '${_localeMonth(minMonth + index)}';
    });
  }

  void _fillRightLists() {
    int maxDay = _maxDayOfCurrentMonth();
    int minDay = _minDayOfCurrentMonth();
    this.rightList = List.generate(maxDay - minDay + 1, (int index) {
      return '${minDay + index}${_localeDay()}';
    });
  }

  @override
  List<int> layoutProportions() {
    return this.formatType == ym ? [1, 1] : [1, 1, 1];
  }

  @override
  void setLeftIndex(int index) {
    super.setLeftIndex(index);
    //adjust middle
    int destYear = index + minTime!.year;
    int minMonth = _minMonthOfCurrentYear();
    DateTime newTime;
    //change date time
    if (currentTime!.month == 2 && currentTime!.day == 29) {
      newTime = currentTime!.isUtc
          ? DateTime.utc(
              destYear,
              currentTime!.month,
              calcDateCount(destYear, 2),
            )
          : DateTime(
              destYear,
              currentTime!.month,
              calcDateCount(destYear, 2),
            );
    } else {
      newTime = currentTime!.isUtc
          ? DateTime.utc(
              destYear,
              currentTime!.month,
              currentTime!.day,
            )
          : DateTime(
              destYear,
              currentTime!.month,
              currentTime!.day,
            );
    }
    //min/max check
    if (newTime.isAfter(maxTime!)) {
      currentTime = maxTime;
    } else if (newTime.isBefore(minTime!)) {
      currentTime = minTime;
    } else {
      currentTime = newTime;
    }

    _fillMiddleLists();
    _fillRightLists();
    minMonth = _minMonthOfCurrentYear();
    int minDay = _minDayOfCurrentMonth();
    _currentMiddleIndex = currentTime!.month - minMonth;
    _currentRightIndex = currentTime!.day - minDay;
  }

  @override
  void setMiddleIndex(int index) {
    super.setMiddleIndex(index);
    //adjust right
    int minMonth = _minMonthOfCurrentYear();
    int destMonth = minMonth + index;
    DateTime newTime;
    //change date time
    int dayCount = calcDateCount(currentTime!.year, destMonth);
    newTime = currentTime!.isUtc
        ? DateTime.utc(
            currentTime!.year,
            destMonth,
            currentTime!.day <= dayCount ? currentTime!.day : dayCount,
          )
        : DateTime(
            currentTime!.year,
            destMonth,
            currentTime!.day <= dayCount ? currentTime!.day : dayCount,
          );
    //min/max check
    if (newTime.isAfter(maxTime!)) {
      currentTime = maxTime;
    } else if (newTime.isBefore(minTime!)) {
      currentTime = minTime;
    } else {
      currentTime = newTime;
    }

    _fillRightLists();
    int minDay = _minDayOfCurrentMonth();
    _currentRightIndex = currentTime!.day - minDay;
  }

  @override
  void setRightIndex(int index) {
    super.setRightIndex(index);
    int minDay = _minDayOfCurrentMonth();
    currentTime = currentTime!.isUtc
        ? DateTime.utc(
            currentTime!.year,
            currentTime!.month,
            minDay + index,
          )
        : DateTime(
            currentTime!.year,
            currentTime!.month,
            minDay + index,
          );
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < leftList.length) {
      return leftList[index];
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < middleList.length) {
      return middleList[index];
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < rightList.length) {
      return rightList[index];
    } else {
      return null;
    }
  }

  String _localeYear() {
    if (locale == LocaleType.zh) {
      return '年';
    } else if (locale == LocaleType.ko) {
      return '년';
    } else {
      return '';
    }
  }

  String _localeMonth(int month) {
    if (locale == LocaleType.zh) {
      return '$month月';
    } else if (locale == LocaleType.ko) {
      return '$month월';
    } else {
      List monthStrings = i18nObjInLocale(locale)!['monthLong'];
      return monthStrings[month - 1];
    }
  }

  String _localeDay() {
    if (locale == LocaleType.zh) {
      return '日';
    } else if (locale == LocaleType.ko) {
      return '일';
    } else {
      return '';
    }
  }

  @override
  DateTime? finalTime() {
    return currentTime;
  }
}

//a time picker model
class TimePickerModel extends CommonPickerModel {
  TimePickerModel({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();

    _currentLeftIndex = this.currentTime!.hour;
    _currentMiddleIndex = this.currentTime!.minute;
    _currentRightIndex = this.currentTime!.second;
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return ":";
  }

  @override
  String rightDivider() {
    return ":";
  }

  @override
  DateTime finalTime() {
    return currentTime!.isUtc
        ? DateTime.utc(
            currentTime!.year,
            currentTime!.month,
            currentTime!.day,
            _currentLeftIndex ?? 0,
            _currentMiddleIndex ?? 0,
            _currentRightIndex ?? 0)
        : DateTime(
            currentTime!.year,
            currentTime!.month,
            currentTime!.day,
            _currentLeftIndex ?? 0,
            _currentMiddleIndex ?? 0,
            _currentRightIndex ?? 0);
  }
}

//a date&time picker model
class DateTimePickerModel extends CommonPickerModel {
  DateTime? maxTime;
  DateTime? minTime;

  DateTimePickerModel(
      {DateTime? currentTime,
      DateTime? maxTime,
      DateTime? minTime,
      LocaleType? locale})
      : super(locale: locale) {
    if (maxTime == null) maxTime = DateTime(2040, 1, 1);
    if (minTime == null) minTime = DateTime(2018, 1, 1);

    this.currentTime = currentTime ?? DateTime.now();
    _currentLeftIndex = 0;
    _currentMiddleIndex = this.currentTime!.hour;
    _currentRightIndex = this.currentTime!.minute;
    _currentRightIndex01 = this.currentTime!.second;

    this.maxTime = maxTime;
    this.minTime = minTime;
  }

  @override
  String? leftStringAtIndex(int index) {
    DateTime dateTime = currentTime!.add(Duration(days: index));

    print(
        'flutter DateTimePickerModel  index: ${index} ----    currentTime: ${currentTime} ----   dateTime: ${dateTime}');

    if (dateTime.isBefore(DateTime(
            maxTime!.year, maxTime!.month, maxTime!.day, 23, 59, 60)) &&
        dateTime.isAfter(DateTime(
            minTime!.year, minTime!.month, minTime!.day - 1, 23, 59, 59))) {
      DateTime time = dateTime;
      return formatDate(time, [ymd], locale);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2) + i18nObjInLocale(locale)!['hour'].toString();
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2) + i18nObjInLocale(locale)!['minute'].toString();
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex01(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2) + i18nObjInLocale(locale)!['second'].toString();
    } else {
      return null;
    }
  }

  @override
  DateTime? finalTime() {
    DateTime time = currentTime!.add(Duration(days: _currentLeftIndex ?? 0));
    return currentTime!.isUtc
        ? DateTime.utc(
            time.year,
            time.month,
            time.day,
            _currentMiddleIndex ?? 0,
            _currentRightIndex ?? 0,
            _currentRightIndex01 ?? 0)
        : DateTime(time.year, time.month, time.day, _currentMiddleIndex ?? 0,
            _currentRightIndex ?? 0, _currentRightIndex01 ?? 0);
  }

  @override
  List<int> layoutProportions() {
    return [5, 2, 2, 2];
  }

  @override
  String rightDivider() {
    return '';
  }
}
