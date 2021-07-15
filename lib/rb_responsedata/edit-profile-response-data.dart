// To parse this JSON data, do
//
//     final editProfileResponse = editProfileResponseFromJson(jsonString);

import 'dart:convert';

EditProfileResponse editProfileResponseFromJson(String str) => EditProfileResponse.fromJson(json.decode(str));

String editProfileResponseToJson(EditProfileResponse data) => json.encode(data.toJson());

class EditProfileResponse {
  EditProfileResponse({
    this.modified,
    this.values,
  });

  Modified modified;
  Values values;

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) => EditProfileResponse(
    modified: json["modified"] == null ? null : Modified.fromJson(json["modified"]),
    values: json["values"] == null ? null : Values.fromJson(json["values"]),
  );

  Map<String, dynamic> toJson() => {
    "modified": modified == null ? null : modified.toJson(),
    "values": values == null ? null : values.toJson(),
  };
}

class Modified {
  Modified({
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.age,
    this.designation,
    this.organization,
    this.district,
  });

  bool password;
  bool firstName;
  bool lastName;
  bool phone;
  bool gender;
  bool age;
  bool designation;
  bool organization;
  bool district;

  factory Modified.fromJson(Map<String, dynamic> json) => Modified(
    password: json["password"] == null ? null : json["password"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    phone: json["phone"] == null ? null : json["phone"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    designation: json["designation"] == null ? null : json["designation"],
    organization: json["organization"] == null ? null : json["organization"],
    district: json["district"] == null ? null : json["district"],
  );

  Map<String, dynamic> toJson() => {
    "password": password == null ? null : password,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "phone": phone == null ? null : phone,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "designation": designation == null ? null : designation,
    "organization": organization == null ? null : organization,
    "district": district == null ? null : district,
  };
}

class Values {
  Values({
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.age,
    this.designation,
    this.organization,
    this.district,
  });

  String firstName;
  String lastName;
  String phone;
  String gender;
  String age;
  String designation;
  String organization;
  String district;

  factory Values.fromJson(Map<String, dynamic> json) => Values(
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    phone: json["phone"] == null ? null : json["phone"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    designation: json["designation"] == null ? null : json["designation"],
    organization: json["organization"] == null ? null : json["organization"],
    district: json["district"] == null ? null : json["district"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "phone": phone == null ? null : phone,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "designation": designation == null ? null : designation,
    "organization": organization == null ? null : organization,
    "district": district == null ? null : district,
  };
}
