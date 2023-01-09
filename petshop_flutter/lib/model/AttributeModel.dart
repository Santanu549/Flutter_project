import 'package:pet_shop_flutter/model/product/Category.dart';

class AttributeModel {
  List<String>? brands;
  List<Category>? categories;
  List<Color>? colors;
  List<String>? pa_weight;
  List<String>? sizes;

  AttributeModel({
    this.brands,
    this.categories,
    this.colors,
    this.pa_weight,
    this.sizes,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      //brands: json['brands'] != null ? (json['brands'] as List).map((i) => Object.fromJson(i)).toList() : null,
      categories: json['categories'] != null ? (json['categories'] as List).map((i) => Category.fromJson(i)).toList() : null,
      colors: json['colors'] != null ? (json['colors'] as List).map((i) => Color.fromJson(i)).toList() : null,
      //pa_weight: json['pa_weight'] != null ? (json['pa_weight'] as List).map((i) => Object.fromJson(i)).toList() : null,
      //sizes: json['sizes'] != null ? (json['sizes'] as List).map((i) => Object.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brands != null) {
      //data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    if (this.pa_weight != null) {
      //data['pa_weight'] = this.pa_weight!.map((v) => v.toJson()).toList();
    }
    if (this.sizes != null) {
      //data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Color {
  int? count;
  String? description;
  String? filter;
  String? name;
  int? parent;
  String? slug;
  String? taxonomy;
  int? term_group;
  int? term_id;
  int? term_taxonomy_id;

  Color({
    this.count,
    this.description,
    this.filter,
    this.name,
    this.parent,
    this.slug,
    this.taxonomy,
    this.term_group,
    this.term_id,
    this.term_taxonomy_id,
  });

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      count: json['count'],
      description: json['description'],
      filter: json['filter'],
      name: json['name'],
      parent: json['parent'],
      slug: json['slug'],
      taxonomy: json['taxonomy'],
      term_group: json['term_group'],
      term_id: json['term_id'],
      term_taxonomy_id: json['term_taxonomy_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['description'] = this.description;
    data['filter'] = this.filter;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['slug'] = this.slug;
    data['taxonomy'] = this.taxonomy;
    data['term_group'] = this.term_group;
    data['term_id'] = this.term_id;
    data['term_taxonomy_id'] = this.term_taxonomy_id;
    return data;
  }
}
