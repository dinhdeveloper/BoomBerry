class NotificationItem {
  final String title;
  final String desc;
  final String time;

  NotificationItem({
    required this.title,
    required this.desc,
    required this.time,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    title: json['title'],
    desc: json['desc'],
    time: json['time']
  );
}

class NotificationDay {
  final String date;
  final List<NotificationItem> items;

  NotificationDay({required this.date, required this.items});

  factory NotificationDay.fromJson(Map<String, dynamic> json) => NotificationDay(
    date: json['date'],
    items: (json['items'] as List)
        .map((e) => NotificationItem.fromJson(e))
        .toList(),
  );
}
