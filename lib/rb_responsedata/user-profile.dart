// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    this.login,
    this.avatar,
    this.avatarUrl,
    this.email,
    this.url,
    this.meta,
    this.rating,
    this.totalCourses,
    this.profileUrl,
  });

  int id;
  String login;
  String avatar;
  String avatarUrl;
  String email;
  String url;
  Meta meta;
  Rating rating;
  int totalCourses;
  String profileUrl;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"] == null ? null : json["id"],
    login: json["login"] == null ? null : json["login"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
    email: json["email"] == null ? null : json["email"],
    url: json["url"] == null ? null : json["url"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    totalCourses: json["total_courses"] == null ? null : json["total_courses"],
    profileUrl: json["profile_url"] == null ? null : json["profile_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "login": login == null ? null : login,
    "avatar": avatar == null ? null : avatar,
    "avatar_url": avatarUrl == null ? null : avatarUrl,
    "email": email == null ? null : email,
    "url": url == null ? null : url,
    "meta": meta == null ? null : meta.toJson(),
    "rating": rating == null ? null : rating.toJson(),
    "total_courses": totalCourses == null ? null : totalCourses,
    "profile_url": profileUrl == null ? null : profileUrl,
  };
}

class Meta {
  Meta({
    this.facebook,
    this.twitter,
    this.instagram,
    this.googlePlus,
    this.position,
    this.description,
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.age,
    this.designation,
    this.organization,
    this.district,
  });

  String facebook;
  String twitter;
  String instagram;
  String googlePlus;
  String position;
  String description;
  String firstName;
  String lastName;
  String phone;
  String gender;
  String age;
  String designation;
  String organization;
  String district;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    facebook: json["facebook"] == null ? null : json["facebook"],
    twitter: json["twitter"] == null ? null : json["twitter"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    googlePlus: json["google-plus"] == null ? null : json["google-plus"],
    position: json["position"] == null ? null : json["position"],
    description: json["description"] == null ? null : json["description"],
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
    "facebook": facebook == null ? null : facebook,
    "twitter": twitter == null ? null : twitter,
    "instagram": instagram == null ? null : instagram,
    "google-plus": googlePlus == null ? null : googlePlus,
    "position": position == null ? null : position,
    "description": description == null ? null : description,
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

class Rating {
  Rating({
    this.total,
    this.average,
    this.totalMarks,
    this.percent,
  });

  int total;
  int average;
  String totalMarks;
  int percent;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    total: json["total"] == null ? null : json["total"],
    average: json["average"] == null ? null : json["average"],
    totalMarks: json["total_marks"] == null ? null : json["total_marks"],
    percent: json["percent"] == null ? null : json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "average": average == null ? null : average,
    "total_marks": totalMarks == null ? null : totalMarks,
    "percent": percent == null ? null : percent,
  };
}
