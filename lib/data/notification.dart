class NotificationData {
  int id;
  String title, body;
  int isRead;

  NotificationData({this.title, this.body, this.isRead});

  NotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['isRead'] = this.isRead;

    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['isRead'] = this.isRead;

    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  NotificationData.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    map['id'] = this.id;
    map['title'] = this.title;
    map['body'] = this.body;
    map['isRead'] = this.isRead;
  }
}
