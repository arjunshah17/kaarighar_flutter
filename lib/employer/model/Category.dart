class Category {
  String? sId;
  String? title;
  String? titleHi;
  String? titleOr;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category(
      {this.sId,
        this.title,
        this.titleHi,
        this.titleOr,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    titleHi = json['title_hi'];
    titleOr = json['title_or'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['title_hi'] = this.titleHi;
    data['title_or'] = this.titleOr;
    data['slug'] = this.slug;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SubCategory {
  String? sId;
  String? title;
  String? slug;
  Parent? parent;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategory(
      {this.sId,
        this.title,
        this.slug,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SubCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Parent {
  String? sId;
  String? title;

  Parent({this.sId, this.title});

  Parent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}