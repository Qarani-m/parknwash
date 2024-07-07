import 'dart:convert';

class MiniNotification {
  final String title;
  final String subtitle;
  final String dateTime;
  final String id;
  final String type;

  MiniNotification({
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.id,
    required this.type
  });

  // Convert a MiniNotification to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'dateTime': dateTime,
      'type':type,
      "id":id
    };
  }

  // Create a MiniNotification from a map
  factory MiniNotification.fromMap(Map<String, dynamic> map) {
    return MiniNotification(
      title: map['title'],
      subtitle: map['subtitle'],
      dateTime: map['dateTime'], 
      id: map['id'],
      type: map['type']
    );
  }

  // Convert a MiniNotification to JSON
  String toJson() => json.encode(toMap());

  // Create a MiniNotification from JSON
  factory MiniNotification.fromJson(String source) =>
      MiniNotification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MiniNotification(title: $title, subtitle: $subtitle, dateTime: $dateTime )';
  }
}
