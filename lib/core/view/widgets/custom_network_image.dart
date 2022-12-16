import 'package:flutter/material.dart';

import '../../resources/app_assets.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CustomNetworkImage({
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: image,
      width: width,
      height: height,
      placeholder: AppImages.placeholder,
      fit: fit,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (_, __, ___) => Image.asset(
        AppImages.placeholder,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
