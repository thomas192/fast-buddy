class Fast {
  int id;
  DateTime start;
  DateTime? end;

  Fast({required this.id, required this.start, required this.end});

  factory Fast.fromMap(Map<String, dynamic> map) {
    return Fast(
      id: map['id'],
      start: DateTime.parse(map['start']),
      end: map['end'] != null ? DateTime.parse(map['end']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start': start.toIso8601String(),
      'end': end?.toIso8601String(),
    };
  }
}
