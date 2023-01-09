class OrderTracking {
  int? id;
  String? author;
  String? dateCreated;
  String? dateCreatedGmt;
  String? note;
  bool? customerNote;

  OrderTracking({this.id, this.author, this.dateCreated, this.dateCreatedGmt, this.note, this.customerNote});

  OrderTracking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    note = json['note'];
    customerNote = json['customer_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['note'] = this.note;
    data['customer_note'] = this.customerNote;

    return data;
  }
}

class Tracking {
  String? status;
  String? message;

  Tracking({this.status, this.message});

  factory Tracking.fromJson(dynamic json) {
    return Tracking(status: json['status'], message: json['message']);
  }

  @override
  String toString() {
    return '{${this.status},${this.message}';
  }
}
