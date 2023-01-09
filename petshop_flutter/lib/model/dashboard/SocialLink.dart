class SocialLink {
  String? contact;
  String? copyright_text;
  String? facebook;
  String? instagram;
  String? privacy_policy;
  String? term_condition;
  String? twitter;
  String? whatsapp;

  SocialLink({
    this.contact,
    this.copyright_text,
    this.facebook,
    this.instagram,
    this.privacy_policy,
    this.term_condition,
    this.twitter,
    this.whatsapp,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      contact: json['contact'],
      copyright_text: json['copyright_text'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      privacy_policy: json['privacy_policy'],
      term_condition: json['term_condition'],
      twitter: json['twitter'],
      whatsapp: json['whatsapp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['copyright_text'] = this.copyright_text;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['privacy_policy'] = this.privacy_policy;
    data['term_condition'] = this.term_condition;
    data['twitter'] = this.twitter;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
