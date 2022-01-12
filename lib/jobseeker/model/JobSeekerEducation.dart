class JobSeekerEducation {
  bool? current;
  String? sId;
  String? school;
  String? degree;
  String? fieldofstudy;
  String? from;
  String? to;
  String? description;

  JobSeekerEducation(
      {this.current,
        this.sId,
        this.school,
        this.degree,
        this.fieldofstudy,
        this.from,
        this.to,
        this.description});

  JobSeekerEducation.fromJson(Map<String, dynamic> json) {
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