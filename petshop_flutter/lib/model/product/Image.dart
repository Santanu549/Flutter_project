class Image {
  String? alt;
  String? date_created;
  String? date_modified;
  int? id;
  String? name;
  int? position;
  String? src;

  Image({
    this.alt,
    this.date_created,
    this.date_modified,
    this.id,
    this.name,
    this.position,
    this.src,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      alt: json['alt'],
      date_created: json['date_created'],
      date_modified: json['date_modified'],
      id: json['id'],
      name: json['name'],
      position: json['position'],
      src: json['src'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alt'] = this.alt;
    data['date_created'] = this.date_created;
    data['date_modified'] = this.date_modified;
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['src'] = this.src;
    return data;
  }
}
