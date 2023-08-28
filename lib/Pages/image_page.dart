import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePage extends StatefulWidget {
  String imageUrl;
  ImagePage({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  var filePath;

  displayDialog() {
    showDialog(
      context: context,
      builder: (context) {
        Future<void> closeDialog() async {
          await Future.delayed(
            Duration(seconds: 3),
          );
          Navigator.pop(context);
        }

        closeDialog();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Row(
                children: [
                  Text(
                    "Wallpaper downloaded successfully",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Colors.black45,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  save() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio().get(
        widget.imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
      );
      print(result);
      displayDialog();
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: widget.imageUrl,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // button 1
                    GestureDetector(
                      onTap: () {
                        save();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        decoration: BoxDecoration(
                          color: const Color(0x33000000),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white60,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Download",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // button 2
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.045,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
