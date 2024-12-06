
class Fact {
  Status? status;
  String? sId;
  String? user;
  String? text;
  String? type;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Fact(
      {this.status,
        this.sId,
        this.user,
        this.text,
        this.type,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Fact.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    sId = json['_id'];
    user = json['user'];
    text = json['text'];
    type = json['type'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['text'] = this.text;
    data['type'] = this.type;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Status {
  Null? verified;
  int? sentCount;

  Status({this.verified, this.sentCount});

  Status.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    sentCount = json['sentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['sentCount'] = this.sentCount;
    return data;
  }
}
