import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        margin: const EdgeInsets.only(top: 00, bottom: 10),
        width: double.infinity,
        height: 150,
        decoration: _cardBorders(),
        child: Stack(
          children: const [
            _BackGroundImage(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      );
}

class _BackGroundImage extends StatelessWidget {
  const _BackGroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: const SizedBox(
        width: double.infinity,
        height: 150,
        // decoration: const BoxDecoration(
        //   color: Colors.transparent,
        // ),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          image: AssetImage('assets/img/micro.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
