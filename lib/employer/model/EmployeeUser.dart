class EmployeeUser {
  String? avatar;
  bool? verified;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobileNumber;
  String? role;
  String? referralCode;
  Company? company;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EmployeeUser(
      {this.avatar,
        this.verified,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.mobileNumber,
        this.role,
        this.referralCode,
        this.company,
        this.createdAt,
        this.updatedAt,
        this.iV});

  EmployeeUser.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    verified = json['verified'];
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    mobileNumber = json['mobileNumber'];
    role = json['role'];
    referralCode = json['referralCode'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['verified'] = this.verified;
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobileNumber'] = this.mobileNumber;
    data['role'] = this.role;
    data['referralCode'] = this.referralCode;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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