import 'package:kaarighar/employer/model/Category.dart';

class KaarigharUser {
  AadharCard? aadharCard;
  PanCard? panCard;
  PreferedCity? preferedCity;
  PreferedCity? preferedCitySecond;
  PreferedCity? currentLocation;
  String? avatar;
  bool? verified;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? referralCode;
  String? cuisineName;
  int? currentSalary;
  int? expectedSalary;
  String? role;
  Category? department;
  SubCategory? designation;
  List<Education>? education;
  String? createdAt;
  String? updatedAt;
  int? iV;

  KaarigharUser(
      {this.aadharCard,
        this.panCard,
        this.preferedCity,
        this.preferedCitySecond,
        this.currentLocation,
        this.avatar,
        this.verified,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.referralCode,
        this.cuisineName,
        this.currentSalary,
        this.expectedSalary,
        this.role,
        this.department,
        this.designation,
        this.education,
        this.createdAt,
        this.updatedAt,
        this.iV});

  KaarigharUser.fromJson(Map<String, dynamic> json) {
    aadharCard = json['aadharCard'] != null
        ? new AadharCard.fromJson(json['aadharCard'])
        : null;
    panCard =
    json['panCard'] != null ? new PanCard.fromJson(json['panCard']) : null;
    preferedCity = json['preferedCity'] != null
        ? new PreferedCity.fromJson(json['preferedCity'])
        : null;
    preferedCitySecond = json['preferedCitySecond'] != null
        ? new PreferedCity.fromJson(json['preferedCitySecond'])
        : null;
    currentLocation = json['current_location'] != null
        ? new PreferedCity.fromJson(json['current_location'])
        : null;
    avatar = json['avatar'];
    verified = json['verified'];
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    referralCode = json['referralCode'];
    cuisineName = json['cuisine_name'];
    currentSalary = json['currentSalary'];
    expectedSalary = json['expectedSalary'];
    role = json['role'];
    try {
      department = json['department'] != null
          ? new Category.fromJson(json['department'])
          : null;
      designation = json['designation'] != null
          ? new SubCategory.fromJson(json['designation'])
          : null;
    }
    catch(Ex){

    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aadharCard != null) {
      data['aadharCard'] = this.aadharCard!.toJson();
    }
    if (this.panCard != null) {
      data['panCard'] = this.panCard!.toJson();
    }
    if (this.preferedCity != null) {
      data['preferedCity'] = this.preferedCity!.toJson();
    }
    if (this.preferedCitySecond != null) {
      data['preferedCitySecond'] = this.preferedCitySecond!.toJson();
    }
    if (this.currentLocation != null) {
      data['current_location'] = this.currentLocation!.toJson();
    }
    data['avatar'] = this.avatar;
    data['verified'] = this.verified;
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['referralCode'] = this.referralCode;
    data['cuisine_name'] = this.cuisineName;
    data['currentSalary'] = this.currentSalary;
    data['expectedSalary'] = this.expectedSalary;
    data['role'] = this.role;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AadharCard {
  String? aadharNumber;
  String? aadharImage;

  AadharCard({this.aadharNumber, this.aadharImage});

  AadharCard.fromJson(Map<String, dynamic> json) {
    aadharNumber = json['aadharNumber'];
    aadharImage = json['aadharImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aadharNumber'] = this.aadharNumber;
    data['aadharImage'] = this.aadharImage;
    return data;
  }
}

class PanCard {
  String? panNumber;
  String? panImage;

  PanCard({this.panNumber, this.panImage});

  PanCard.fromJson(Map<String, dynamic> json) {
    panNumber = json['panNumber'];
    panImage = json['panImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['panNumber'] = this.panNumber;
    data['panImage'] = this.panImage;
    return data;
  }
}

class PreferedCity {
  String? city;
  String? state;

  PreferedCity({this.city, this.state});

  PreferedCity.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}



class Education {
  bool? current;
  String? sId;
  String? school;
  String? degree;
  String? fieldofstudy;
  String? from;
  String? to;
  String? description;

  Education(
      {this.current,
        this.sId,
        this.school,
        this.degree,
        this.fieldofstudy,
        this.from,
        this.to,
        this.description});

  Education.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    sId = json['_id'];
    school = json['school'];
    degree = json['degree'];
    fieldofstudy = json['fieldofstudy'];
    from = json['from'];
    to = json['to'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['_id'] = this.sId;
    data['school'] = this.school;
    data['degree'] = this.degree;
    data['fieldofstudy'] = this.fieldofstudy;
    data['from'] = this.from;
    data['to'] = this.to;
    data['description'] = this.description;
    return data;
  }
}