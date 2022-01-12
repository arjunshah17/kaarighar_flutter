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