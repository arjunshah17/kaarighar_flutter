class MarketPlace {
  String? sId;
  String? name;
  String? description;
  Recruiter? recruiter;
  int? price;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MarketPlace(
      {this.sId,
        this.name,
        this.description,
        this.recruiter,
        this.price,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.iV});

  MarketPlace.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    recruiter = json['recruiter'] != null
        ? new Recruiter.fromJson(json['recruiter'])
        : null;
    price = json['price'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.recruiter != null) {
      data['recruiter'] = this.recruiter!.toJson();
    }
    data['price'] = this.price;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
  List<Null>? address;

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