import 'package:intl/intl.dart';

double computeSensorData(dataValues) {
  if (dataValues.length > 1) {
    var sum = 0.0;
    for (var value in dataValues) {
      sum += value as double;
    }

    return sum / dataValues.length;
  }

  return dataValues[0];
}

List<double> computeChartData(
    int index, List? bpmData, List? tempData, List? humData) {
  switch (index) {
    case 0:
      if (!isListAvailable(bpmData)) {
        return [0.0];
      }

      return bpmData!.map((e) => e as double).toList();
    case 1:
      if (!isListAvailable(tempData)) {
        return [0.0];
      }

      return tempData!.map((e) => e as double).toList();
    case 2:
      if (!isListAvailable(humData)) {
        return [0.0];
      }

      return humData!.map((e) => e as double).toList();
    default:
      return [0.0];
  }
}

List<double> computeSingleChartData(List? data) {
  if (!isListAvailable(data)) {
    return [0.0];
  }

  return data!.map((e) => e as double).toList();
}

String selectedDataToPreview(int index) {
  switch (index) {
    case 0:
      return 'Heart rate';
    case 1:
      return 'Temperature';
    case 2:
      return 'Humidity';
    default:
      return '';
  }
}

List<DateTime> getLastSevenDays() {
  return [
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 4)),
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now().subtract(const Duration(days: 6)),
    DateTime.now().subtract(const Duration(days: 7)),
  ];
}

List<String> getLastSevenDaysShifted() {
  return [
    computeCurrentDate(DateTime.now().subtract(const Duration(hours: 3))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 1))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 2))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 3))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 4))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 5))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 6))),
    computeCurrentDate(
        DateTime.now().subtract(const Duration(hours: 3, days: 7))),
  ];
}

String computeCurrentDate(date) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  String formattedTime = DateFormat('HH:mm:ss').format(date);
  return "${formattedDate}T${formattedTime}Z";
}

List<bool> switchActivityRadioButtons(int selected) {
  switch (selected) {
    case 0:
      return [true, false, false, false, false];
    case 1:
      return [false, true, false, false, false];
    case 2:
      return [false, false, true, false, false];
    case 3:
      return [false, false, false, true, false];
    case 4:
      return [false, false, false, false, true];
    default:
      return [false, false, false, false, false];
  }
}

List<bool> determineSwitchButtonsOnLoad(String? activity) {
  switch (activity) {
    case "CYCLING":
      return [true, false, false, false, false];
    case "WALKING":
      return [false, true, false, false, false];
    case "RUNNING":
      return [false, false, true, false, false];
    case "JOGGING":
      return [false, false, false, true, false];
    case "SEDENTARY":
      return [false, false, false, false, true];
    default:
      return [false, false, false, false, false];
  }
}

bool isListAvailable(List? data) {
  if (data == null) {
    return false;
  } else {
    if (data.isEmpty) {
      return false;
    }
  }

  return true;
}
