class RepairReportModel {
  final String reportId;
  final String roomNumber;
  final String title;
  final String description;
  final String status; // pending, fixing, done
  final DateTime date;

  RepairReportModel({
    required this.reportId,
    required this.roomNumber,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });

  factory RepairReportModel.fromJson(Map<String, dynamic> json) {
    return RepairReportModel(
      reportId: json['reportId'],
      roomNumber: json['roomNumber'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'roomNumber': roomNumber,
      'title': title,
      'description': description,
      'status': status,
      'date': date.toIso8601String(),
    };
  }
}
