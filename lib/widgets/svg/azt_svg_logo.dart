import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AztSvgLogo extends StatelessWidget {
  final String svgAsset;
  final String? logoText;
  final double? spaceBetweenLogoAndText;

  const AztSvgLogo({
    Key? key,
    required this.svgAsset,
    this.logoText = "",
    this.spaceBetweenLogoAndText = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgAsset,
          height: 40,
        ),
      ],
    );
  }
}

class AztSvgLogoText extends StatelessWidget {
  final String svgAsset;
  final String logoText;
  final double? spaceBetweenLogoAndText;

  const AztSvgLogoText({
    Key? key,
    required this.svgAsset,
    required this.logoText,
    this.spaceBetweenLogoAndText = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: 40,
          ),
          SizedBox(width: spaceBetweenLogoAndText),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              logoText,
            ),
          )
        ],
      ),
    );
  }
}
