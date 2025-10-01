import 'dart:convert';

class ArticalModel {
String title;
String description;
String urlToImage;
  ArticalModel({
    required this.title,
    required this.description,
    required this.urlToImage,
  });
  

  ArticalModel copyWith({
    String? title,
    String? description,
    String? urlToImage,
  }) {
    return ArticalModel(
      title: title ?? this.title,
      description: description ?? this.description,
      urlToImage: urlToImage ?? this.urlToImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
    };
  }

  factory ArticalModel.fromMap(Map<String, dynamic> map) {
    return ArticalModel(
      title: map['title'] as String,
      description: map['description'] as String,
      urlToImage: map['urlToImage'] ?? "https://icdn.lenta.ru/images/2025/08/22/12/20250822125702621/share_cc8acb3be2d5f34252a35243fc97a7a5.jpg",
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticalModel.fromJson(String source) => ArticalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ArticalModel(title: $title, description: $description, urlToImage: $urlToImage)';

  @override
  bool operator ==(covariant ArticalModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.urlToImage == urlToImage;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ urlToImage.hashCode;
}