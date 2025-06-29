import '../../domain/entities/app_banner.dart';

class AppBannerModel extends AppBanner {
  const AppBannerModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    required super.ctaText,
    required super.ctaLink,
    required super.backgroundColor,
    required super.textColor,
    required super.isActive,
  });

  factory AppBannerModel.fromJson(Map<String, dynamic> json) {
    return AppBannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      ctaText: json['ctaText'] as String,
      ctaLink: json['ctaLink'] as String,
      backgroundColor: json['backgroundColor'] as String,
      textColor: json['textColor'] as String,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'ctaText': ctaText,
      'ctaLink': ctaLink,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
      'isActive': isActive,
    };
  }
} 