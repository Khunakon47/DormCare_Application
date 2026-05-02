class AppFormat {
  AppFormat._();

  static const _months = ['Jan', 'Feb','Mar', 'Apr','May','Jun', 'Jul','Aug', 'Sep','Oct','Nov','Dec'];
  static const _monthsFull = ['January','February', 'March', 'April', 'May','June', 'July','August','September','October','November','December'];

  // "9 Jan 2025"
  static String date(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

  // "09:30"
  static String time(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  // "9 Jan 2025  ·  09:30"
  static String dateTime(DateTime d) => '${date(d)}  ·  ${time(d)}';

  // "January 2025"
  static String monthYear(DateTime d) => '${_monthsFull[d.month - 1]} ${d.year}';

  // "5 February 2026"
  static String dateFull(DateTime d) => '${d.day} ${_monthsFull[d.month - 1]} ${d.year}';

  // Smart display: same day → "09:30", yesterday → "Yesterday", else → "9 Jan"
  static String smart(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);

    if (diff.inHours < 24) return time(d);

    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dDay = DateTime(d.year, d.month, d.day);
    if (dDay == yesterday) return 'Yesterday';

    return '${d.day} ${_months[d.month - 1]}';
  }

  // "—" for null DateTime
  static String dateOrDash(DateTime? d) => d == null ? '—' : date(d);

  // "—" for null/empty String
  static String strOrDash(String? s) => (s == null || s.trim().isEmpty) ? '—' : s;
}
