DateTime dt = DateTime.now();
get year => dt.year;
get month => dt.month;
get day => dt.day;
get hour => dt.hour;
var currentDay = dt.weekday;
DateTime firstDayOfWeek = dt.subtract(Duration(days: currentDay - 1));

class GetDayOfWeek {
  String getThisMonday() {
    var monday =
        "${firstDayOfWeek.year}${firstDayOfWeek.month}${firstDayOfWeek.day}";
    if (firstDayOfWeek.month < 10) {
      monday =
          "${firstDayOfWeek.year}0${firstDayOfWeek.month}${firstDayOfWeek.day}";
      if (firstDayOfWeek.day < 10) {
        monday =
            "${firstDayOfWeek.year}0${firstDayOfWeek.month}0${firstDayOfWeek.day}";
      }
    } else if (firstDayOfWeek.day < 10) {
      monday =
          "${firstDayOfWeek.year}${firstDayOfWeek.month}0${firstDayOfWeek.day}";
    }
    return monday;
  }

  String getThisTuesday() {
    int tuesdayYear = firstDayOfWeek.year,
        tuesdayMonth = firstDayOfWeek.month,
        tuesdayDay = firstDayOfWeek.day + 1;
    String tuesday;
    if (firstDayOfWeek.month == 12 && firstDayOfWeek.day == 31) {
      tuesdayYear = firstDayOfWeek.year + 1;
      tuesdayMonth = 1;
      tuesdayDay = 1;
    } else if (firstDayOfWeek.year % 4 == 0 &&
        firstDayOfWeek.month == 2 &&
        firstDayOfWeek.day == 29) {
      tuesdayMonth = 3;
      tuesdayDay = 1;
    } else if (firstDayOfWeek.month == 1 ||
        firstDayOfWeek.month == 3 ||
        firstDayOfWeek.month == 5 ||
        firstDayOfWeek.month == 7 ||
        firstDayOfWeek.month == 8 ||
        firstDayOfWeek.month == 10) {
      if (firstDayOfWeek.day == 31) {
        tuesdayMonth = firstDayOfWeek.month + 1;
        tuesdayDay = 1;
      }
    } else if (firstDayOfWeek.year % 4 != 0 &&
        firstDayOfWeek.month == 2 &&
        firstDayOfWeek.day == 28) {
      tuesdayMonth = 3;
      tuesdayDay = 1;
    } else if (firstDayOfWeek.day == 30) {
      tuesdayMonth = firstDayOfWeek.month + 1;
      tuesdayDay = 1;
    }
    tuesday = "$tuesdayYear$tuesdayMonth$tuesdayDay";
    if (tuesdayMonth < 10) {
      tuesday = "${tuesdayYear}0$tuesdayMonth$tuesdayDay";
      if (tuesdayDay < 10) {
        tuesday = "${tuesdayYear}0${tuesdayMonth}0$tuesdayDay";
      }
    } else if (tuesdayDay < 10) {
      tuesday = "$tuesdayYear${tuesdayMonth}0$tuesdayDay";
    }
    return tuesday;
  }

  String getThisWednesday() {
    String yesterday = getThisTuesday();
    String yyyy = yesterday.substring(0, 4);
    String mm = yesterday.substring(4, 6);
    String dd = yesterday.substring(6, 8);
    int yesterdayYear = int.parse(yyyy);
    int yesterdayMonth = int.parse(mm);
    int yesterdayDay = int.parse(dd);

    int wednesdayYear = yesterdayYear,
        wednesdayMonth = yesterdayMonth,
        wednesdayDay = yesterdayDay + 1;
    String wednesday;
    if (yesterdayMonth == 12 && yesterdayDay == 31) {
      wednesdayYear = yesterdayYear + 1;
      wednesdayMonth = 1;
      wednesdayDay = 1;
    } else if (yesterdayYear % 4 == 0 &&
        yesterdayMonth == 2 &&
        yesterdayDay == 29) {
      wednesdayMonth = 3;
      wednesdayDay = 1;
    } else if (yesterdayMonth == 1 ||
        yesterdayMonth == 3 ||
        yesterdayMonth == 5 ||
        yesterdayMonth == 7 ||
        yesterdayMonth == 8 ||
        yesterdayMonth == 10) {
      if (yesterdayDay == 31) {
        wednesdayMonth = yesterdayMonth + 1;
        wednesdayDay = 1;
      }
    } else if (yesterdayYear % 4 != 0 &&
        yesterdayMonth == 2 &&
        yesterdayDay == 28) {
      wednesdayMonth = 3;
      wednesdayDay = 1;
    } else if (yesterdayDay == 30) {
      wednesdayMonth = yesterdayMonth + 1;
      wednesdayDay = 1;
    }
    wednesday = "$wednesdayYear$wednesdayMonth$wednesdayDay";
    if (wednesdayMonth < 10) {
      wednesday = "${wednesdayYear}0$wednesdayMonth$wednesdayDay";
      if (wednesdayDay < 10) {
        wednesday = "${wednesdayYear}0${wednesdayMonth}0$wednesdayDay";
      }
    } else if (wednesdayDay < 10) {
      wednesday = "$wednesdayYear${wednesdayMonth}0$wednesdayDay";
    }
    return wednesday;
  }

  String getThisThursday() {
    String yesterday = getThisWednesday();
    String yyyy = yesterday.substring(0, 4);
    String mm = yesterday.substring(4, 6);
    String dd = yesterday.substring(6, 8);
    int yesterdayYear = int.parse(yyyy);
    int yesterdayMonth = int.parse(mm);
    int yesterdayDay = int.parse(dd);

    int thrusdayYear = yesterdayYear,
        thrusdayMonth = yesterdayMonth,
        thrusdayDay = yesterdayDay + 1;
    String thrusday;
    if (yesterdayMonth == 12 && yesterdayDay == 31) {
      thrusdayYear = yesterdayYear + 1;
      thrusdayMonth = 1;
      thrusdayDay = 1;
    } else if (yesterdayYear % 4 == 0 &&
        yesterdayMonth == 2 &&
        yesterdayDay == 29) {
      thrusdayMonth = 3;
      thrusdayDay = 1;
    } else if (yesterdayMonth == 1 ||
        yesterdayMonth == 3 ||
        yesterdayMonth == 5 ||
        yesterdayMonth == 7 ||
        yesterdayMonth == 8 ||
        yesterdayMonth == 10) {
      if (yesterdayDay == 31) {
        thrusdayMonth = yesterdayMonth + 1;
        thrusdayDay = 1;
      }
    } else if (yesterdayYear % 4 != 0 &&
        yesterdayMonth == 2 &&
        yesterdayDay == 28) {
      thrusdayMonth = 3;
      thrusdayDay = 1;
    } else if (yesterdayDay == 30) {
      thrusdayMonth = yesterdayMonth + 1;
      thrusdayDay = 1;
    }
    thrusday = "$thrusdayYear$thrusdayMonth$thrusdayDay";
    if (thrusdayMonth < 10) {
      thrusday = "${thrusdayYear}0$thrusdayMonth$thrusdayDay";
      if (thrusdayDay < 10) {
        thrusday = "${thrusdayYear}0${thrusdayMonth}0$thrusdayDay";
      }
    } else if (thrusdayDay < 10) {
      thrusday = "$thrusdayYear${thrusdayMonth}0$thrusdayDay";
    }
    return thrusday;
  }

  String getThisFriday() {
    String yesterday = getThisThursday();
    String yyyy = yesterday.substring(0, 4);
    String mm = yesterday.substring(4, 6);
    String dd = yesterday.substring(6, 8);
    int yesterdayYear = int.parse(yyyy);
    int yesterdayMonth = int.parse(mm);
    int yesterdayDay = int.parse(dd);

    int fridayYear = yesterdayYear,
        fridayMonth = yesterdayMonth,
        fridayDay = yesterdayDay + 1;
    String friday;
    if (yesterdayMonth == 12 && yesterdayDay == 31) {
      fridayYear = yesterdayYear + 1;
      fridayMonth = 1;
      fridayDay = 1;
    } else if (yesterdayYear % 4 == 0 &&
        yesterdayMonth == 2 &&
        yesterdayDay == 29) {
      fridayMonth = 3;
      fridayDay = 1;
    } else if (yesterdayMonth == 1 ||
        yesterdayMonth == 3 ||
        yesterdayMonth == 5 ||
        yesterdayMonth == 7 ||
        yesterdayMonth == 8 ||
        yesterdayMonth == 10) {
      if (yesterdayDay == 31) {
        fridayMonth = yesterdayMonth + 1;
        fridayDay = 1;
      }
    } else if (yesterdayYear % 4 != 0 &&
        yesterdayMonth == 2 &&
        yesterdayDay == 28) {
      fridayMonth = 3;
      fridayDay = 1;
    } else if (yesterdayDay == 30) {
      fridayMonth = yesterdayMonth + 1;
      fridayDay = 1;
    }
    friday = "$fridayYear$fridayMonth$fridayDay";
    if (fridayMonth < 10) {
      friday = "${fridayYear}0$fridayMonth$fridayDay";
      if (fridayDay < 10) {
        friday = "${fridayYear}0${fridayMonth}0$fridayDay";
      }
    } else if (fridayDay < 10) {
      friday = "$fridayYear${fridayMonth}0$fridayDay";
    }
    return friday;
  }

  int getRequiredYear(selectedIndex) {
    int year;
    String stringYear;
    switch (selectedIndex) {
      case 0:
        year = firstDayOfWeek.year;
        return year;
      case 1:
        stringYear = getThisTuesday().substring(0, 4);
        year = int.parse(stringYear);
        return year;
      case 2:
        stringYear = getThisWednesday().substring(0, 4);
        year = int.parse(stringYear);
        return year;
      case 3:
        stringYear = getThisThursday().substring(0, 4);
        year = int.parse(stringYear);
        return year;
      case 4:
        stringYear = getThisFriday().substring(0, 4);
        year = int.parse(stringYear);
        return year;
      default:
        return 0; //index의 최대가 4이므로, 발생하지 않을 예외입니다.
    }
  }

  int getRequiredMonth(selectedIndex) {
    int month;
    String stringMonth;
    switch (selectedIndex) {
      case 0:
        month = firstDayOfWeek.month;
        return month;
      case 1:
        stringMonth = getThisTuesday().substring(4, 6);
        month = int.parse(stringMonth);
        return month;
      case 2:
        stringMonth = getThisWednesday().substring(4, 6);
        month = int.parse(stringMonth);
        return month;
      case 3:
        stringMonth = getThisThursday().substring(4, 6);
        month = int.parse(stringMonth);
        return month;
      case 4:
        stringMonth = getThisFriday().substring(4, 6);
        month = int.parse(stringMonth);
        return month;
      default:
        return 0; //index의 최대가 4이므로, 발생하지 않을 예외입니다.
    }
  }

  int getRequiredDay(selectedIndex) {
    int day;
    String stringDay;
    switch (selectedIndex) {
      case 0:
        day = firstDayOfWeek.day;
        return day;
      case 1:
        stringDay = getThisTuesday().substring(6, 8);
        day = int.parse(stringDay);
        return day;
      case 2:
        stringDay = getThisWednesday().substring(6, 8);
        day = int.parse(stringDay);
        return day;
      case 3:
        stringDay = getThisThursday().substring(6, 8);
        day = int.parse(stringDay);
        return day;
      case 4:
        stringDay = getThisFriday().substring(6, 8);
        day = int.parse(stringDay);
        return day;
      default:
        return 0; //index의 최대가 4이므로, 발생하지 않을 예외입니다.
    }
  }
}
