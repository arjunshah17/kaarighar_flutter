class JobSeekerUser {
  AadharCard? aadharCard;
  PanCard? panCard;
  PreferedCity? preferedCity;
  PreferedCity? preferedCitySecond;
  PreferedCity? currentLocation;
  String? avatar;
  List<Null>? skills;
  bool? verified;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobileNumber;
  String? referralCode;
  String? cuisineName;
  int? currentSalary;
  int? expectedSalary;
  String? role;
  String? department;
  String? designation;
  List<Null>? address;
  List<Null>? experience;
  List<Null>? education;
  String? createdAt;
  String? updatedAt;
  int? iV;

  JobSeekerUser(
      {this.aadharCard,
        this.panCard,
        this.preferedCity,
        this.preferedCitySecond,
        this.currentLocation,
        this.avatar,
        this.skills,
        this.verified,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.mobileNumber,
        this.referralCode,
        this.cuisineName,
        this.currentSalary,
        this.expectedSalary,
        this.role,
        this.department,
        this.designation,
        this.address,
        this.experience,
        this.education,
        this.createdAt,
        this.updatedAt,
        this.iV});

  JobSeekerUser.fromJson(Map<String, dynamic> json) {
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
    password = json['password'];
    mobileNumber = json['mobileNumber'];
    referralCode = json['referralCode'];
    cuisineName = json['cuisine_name'];
    currentSalary = json['currentSalary'];
    expectedSalary = json['expectedSalary'];
    role = json['role'];
    department = json['department'];
    designation = json['designation'];


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
    data['password'] = this.password;
    data['mobileNumber'] = this.mobileNumber;
    data['referralCode'] = this.referralCode;
    data['cuisine_name'] = this.cuisineName;
    data['currentSalary'] = this.currentSalary;
    data['expectedSalary'] = this.expectedSalary;
    data['role'] = this.role;
    data['department'] = this.department;
    data['designation'] = this.designation;

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