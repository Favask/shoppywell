import 'package:equatable/equatable.dart';

class AppBanner extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String ctaText;
  final String ctaLink;
  final String backgroundColor;
  final String textColor;
  final bool isActive;

  const AppBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.ctaText,
    required this.ctaLink,
    required this.backgroundColor,
    required this.textColor,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        imageUrl,
        ctaText,
        ctaLink,
        backgroundColor,
        textColor,
        isActive,
      ];
} 