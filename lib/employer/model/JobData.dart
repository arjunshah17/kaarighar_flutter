import 'package:kaarighar/employer/model/KaarigharUser.dart';

class JobData {
  Location? location;
  List<KaarigharUser>? candidate;
  String? sId;
  String? name;
  String? noRole;
  String? description;
  Department? department;
  Department? designation;
  String? slug;
  Recruiter? recruiter;
  String? createdAt;
  String? updatedAt;
  int? iV;

  JobData(
      {this.location,
        this.candidate,
        this.sId,
        this.name,
        this.noRole,
        this.description,
        this.department,
        this.designation,
        this.slug,
        this.recruiter,
        this.createdAt,
        this.updatedAt,
        this.iV});

  JobData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['candidate'] != null) {
      candidate = <KaarigharUser>[];
      json['candidate'].forEach((v) {
        candidate!.add(new KaarigharUser.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    noRole = json['noRole'].toString();
    description = json['description'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    designation = json['designation'] != null
        ? new Department.fromJson(json['designation'])
        : null;
    slug = json['slug'];
    recruiter = json['recruiter'] != null
        ? new Recruiter.fromJson(json['recruiter'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.candidate != null) {
      data['candidate'] = this.candidate!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['noRole'] = this.noRole;
    data['description'] = this.description;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    data['slug'] = this.slug;
    if (this.recruiter != null) {
      data['recruiter'] = this.recruiter!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? latitude;

  Location(
      {this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.latitude});

  Location.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Candidate {
  AadharCard? aadharCard;
  PanCard? panCard;
  PreferedCity? preferedCity;
  PreferedCity? preferedCitySecond;
  PreferedCity? currentLocation;
  String? avatar;
  List<Null>? skills;
  bool? verified;
  Null? referrer;
  List<String>? appliedJobs;
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
  List<Education>? education;
  String? createdAt;
  String? updatedAt;
  int? iV;



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
    data['referrer'] = this.referrer;
    data['appliedJobs'] = this.appliedJobs;
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

    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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

class Department {
  String? sId;
  String? title;
  String? slug;

  Department({this.sId, this.title, this.slug});

  Department.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    return data;
  }
}

class Recruiter {
  Company? company;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  List<Address>? address;

  Recruiter(
      {this.company,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.address});

  Recruiter.fromJson(Map<String, dynamic> json) {
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  String? companyName;
  String? companyRegNo;
  String? companyAddress;
  String? companyContact;

  Company(
      {this.companyName,
        this.companyRegNo,
        this.companyAddress,
        this.companyContact});

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyRegNo = json['companyRegNo'];
    companyAddress = json['companyAddress'];
    companyContact = json['companyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['companyRegNo'] = this.companyRegNo;
    data['companyAddress'] = this.companyAddress;
    data['companyContact'] = this.companyContact;
    return data;
  }
}

class Address {
  String? sId;
  String? addressType;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? latitude;

  Address(
      {this.sId,
        this.addressType,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.latitude});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressType = json['addressType'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['addressType'] = this.addressType;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    return data;
  }
}