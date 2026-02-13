import 'package:dormcare/component/custom_textbutton.dart';
import 'package:flutter/material.dart';

class ImagegalleryButton extends StatelessWidget {
  const ImagegalleryButton({
    super.key,
    required this.imagePath,
    required this.heroTag,
    this.bgColor = const [Colors.black],
    this.fgColor = Colors.white,
    this.icons = const {'leftIcon': Icon(Icons.arrow_left), 'rightIcon': Icon(Icons.arrow_right)},
  });

  final String imagePath;
  final List<String> heroTag;
  final List<Color> bgColor;
  final Color fgColor;
  final Map<String, dynamic> icons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            )
          ),

          // Left button
          Positioned(
            left: 8,
            child: CustomTextbutton(
              bgColor: bgColor,
              iconColor: fgColor,
              icon: icons['leftIcon'],
              iconSize: 40,
              floatingButton: true,
              mini: true,
              heroTag: heroTag.first,
            ),
          ),
          
          // Right button
          Positioned(
            right: 8,
            child: CustomTextbutton(
              bgColor: bgColor,
              iconColor: fgColor,
              icon: icons['rightIcon'],
              iconSize: 40,
              floatingButton: true,
              mini: true,
              heroTag: heroTag.last,
            ),
          ),
        ],
      ),
    );
  }
}