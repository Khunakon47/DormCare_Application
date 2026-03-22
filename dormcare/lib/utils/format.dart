// import 'package:dormcare/utils/constants.dart';

// Date / Time formatters
// รวม logic การ format วันที่และเวลาทั้งหมดไว้ที่เดียว
// แทนที่ logic ที่กระจายอยู่ใน RepairModel, AlertModel,
// AlertOwnerModel, RepairOwnerModel, RepairDetailTenantScreen, AlertDetailTenantScreen

class AppFormat {
  AppFormat._();

  // Month names (short)
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  // Month names (full)
  static const _monthsFull = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// "9 Jan 2025"
  static String date(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';

  /// "09:30"
  static String time(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  /// "9 Jan 2025  ·  09:30"
  static String dateTime(DateTime d) => '${date(d)}  ·  ${time(d)}';

  /// "January 2025"  (ใช้ใน Bills)
  static String monthYear(DateTime d) =>
      '${_monthsFull[d.month - 1]} ${d.year}';

  /// Smart display: ถ้าวันนี้ → "09:30", เมื่อวาน → "Yesterday", อื่นๆ → "9 Jan"
  static String smart(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);

    if (diff.inHours < 24) return time(d);

    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dDay = DateTime(d.year, d.month, d.day);
    if (dDay == yesterday) return 'Yesterday';

    return '${d.day} ${_months[d.month - 1]}';
  }
}
