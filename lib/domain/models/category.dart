import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final int productCount;
  final String? imageUrl;
  final String? bannerImageUrl;
  final String? tagline;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
    this.imageUrl,
    this.bannerImageUrl,
    this.tagline,
  });
}
