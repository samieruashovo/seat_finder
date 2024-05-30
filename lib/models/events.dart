class Event {
  final int id;
  final String name;
  final String description;
  final String link;
  final String date;
  final String location;
  final String city;
  final int capacity;
  final bool isPrivate;
  final bool hasFee;
  final int? entryFee;
  final String host;
  final String tags;
  final String thumb;
  final String createdAt;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.date,
    required this.location,
    required this.city,
    required this.capacity,
    required this.isPrivate,
    required this.hasFee,
    this.entryFee,
    required this.host,
    required this.tags,
    required this.thumb,
    required this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      link: json['link'],
      date: json['date'],
      location: json['location'],
      city: json['city'],
      capacity: json['capacity'],
      isPrivate: json['isPrivate'],
      hasFee: json['hasFee'],
      entryFee: json['entryFee'],
      host: json['host'],
      tags: json['tags'],
      thumb: json['thumb'],
      createdAt: json['created_at'],
    );
  }
}
