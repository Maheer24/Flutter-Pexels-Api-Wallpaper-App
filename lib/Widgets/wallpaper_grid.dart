import 'package:flutter/material.dart';
import 'package:pixel/Pages/image_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WallpaperGrid extends StatelessWidget {
  String imageUrl;
  WallpaperGrid({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagePage(imageUrl: imageUrl),
                ),
              );
          },
          child: Hero(
            tag: imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // child: Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(imageUrl: imageUrl,fit: BoxFit.cover,placeholder: (context, url) => Center(child: CircularProgressIndicator(color:Color( 0xff1AFFFFFF),)),)
            ),
          ),
        ),
      ),
    );
  }
}
