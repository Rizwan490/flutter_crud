class PersonModel {
  String? status;
  String? message;
  List<Record>? record;

  PersonModel({this.status, this.message, this.record});

  PersonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      record = <Record>[];
      json['record'].forEach((v) {
        record!.add(new Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.record != null) {
      data['record'] = this.record!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Record {
  int? id;
  String? name;
  String? surname;
  String? idNumber;
  String? mobile;
  String? email;
  String? birthDate;
  String? language;
  List<String>? interests;
  String? createdAt;
  String? updatedAt;

  Record(
      {this.id,
      this.name,
      this.surname,
      this.idNumber,
      this.mobile,
      this.email,
      this.birthDate,
      this.language,
      this.interests,
      this.createdAt,
      this.updatedAt});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    idNumber = json['id_number'];
    mobile = json['mobile'];
    email = json['email'];
    birthDate = json['birth_date'];
    language = json['language'];
    interests = json['interests'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['id_number'] = this.idNumber;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['birth_date'] = this.birthDate;
    data['language'] = this.language;
    data['interests'] = this.interests;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
