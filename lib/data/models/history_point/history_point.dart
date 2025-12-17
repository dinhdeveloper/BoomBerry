class HistoryPoint {
  final String date;
  final List<HistoryItem> items;

  HistoryPoint({required this.date, required this.items});

  factory HistoryPoint.fromJson(Map<String, dynamic> json) {
    return HistoryPoint(
      date: json['date'],
      items: (json['items'] as List)
          .map((e) => HistoryItem.fromJson(e))
          .toList(),
    );
  }
}

class HistoryItem {
  final String title;
  final String desc;
  final String time;
  final String icon;
  final int color;

  HistoryItem({
    required this.title,
    required this.desc,
    required this.time,
    required this.icon,
    required this.color,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      title: json['title'],
      desc: json['desc'],
      time: json['time'],
      icon: json['icon'],
      color: int.parse(json['color']),
    );
  }
}
