class TextFormatting {
  static String formatDateTime(DateTime dateTime) {
    List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Ahad'
    ];

    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    // Mendapatkan nama hari
    String dayName = days[dateTime.weekday - 1];

    // Mendapatkan nama bulan
    String monthName = months[dateTime.month - 1];

    // Memformat tanggal
    String formattedDate =
        '$dayName, ${dateTime.day} $monthName ${dateTime.year}';

    return formattedDate;
  }

  static String formatTime(String time) {
    return time.substring(0, 5);
  }

  static String formatDateTimeMonth3(DateTime dateTime) {
    List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Ahad'
    ];

    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];

    // Mendapatkan nama hari
    String dayName = days[dateTime.weekday - 1];

    // Mendapatkan nama bulan
    String monthName = months[dateTime.month - 1];

    // Memformat tanggal
    String formattedDate =
        '$dayName, ${dateTime.day} $monthName ${dateTime.year}';

    return formattedDate;
  }

  static String formatDateTimeWithHours(DateTime dateTime) {
    const Map<int, String> daysOfWeek = {
      1: "Senin",
      2: "Selasa",
      3: "Rabu",
      4: "Kamis",
      5: "Jumat",
      6: "Sabtu",
      7: "Minggu"
    };

    const Map<int, String> monthsOfYear = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "Mei",
      6: "Jun",
      7: "Jul",
      8: "Agu",
      9: "Sep",
      10: "Okt",
      11: "Nov",
      12: "Des"
    };
    String dayOfWeek = daysOfWeek[dateTime.weekday] ?? '';
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = monthsOfYear[dateTime.month] ?? '';
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$dayOfWeek, $day $month, $hour:$minute";
  }

  static String formatDateTimeWithHoursNoDayName(DateTime dateTime) {
    const Map<int, String> monthsOfYear = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "Mei",
      6: "Jun",
      7: "Jul",
      8: "Agu",
      9: "Sep",
      10: "Okt",
      11: "Nov",
      12: "Des"
    };
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = monthsOfYear[dateTime.month] ?? '';
    String year = dateTime.year.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$day $month $year, $hour:$minute";
  }
}
