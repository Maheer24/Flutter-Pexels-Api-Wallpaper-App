import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTile extends StatelessWidget {
  String imageUrl, title;
  CategoryTile({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 40,
                width: 100,
              )),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black26,
              
            ),
            
            alignment: Alignment.center,
            height: 40,
            width: 100,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
