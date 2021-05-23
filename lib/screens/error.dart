import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: NetworkImage(
            'https://sayingimages.com/wp-content/uploads/yes-cleaning-meme.jpg'),
      ),
    );
  }
}
