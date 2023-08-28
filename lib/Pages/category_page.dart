import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel/Services/Utils/function.dart';
import '../Model/category_model.dart';
import '../Widgets/wallpaper_grid.dart';

class CategoryPage extends StatefulWidget {
  String categoryName;
  CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController searchController = TextEditingController();
  PexelsApi pexelsApi = PexelsApi();
  List<CategoryModel> category = [];

  @override
  void initState() {
    // TODO: implement initState
    pexelsApi.getSearchWallpapers(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey.shade500,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: pexelsApi.getSearchWallpapers(widget.categoryName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.hasError) {
                      // ignore: avoid_print
                      print(snapshot.error);
                      return const Center(
                        child: Text("No results found"),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 5, left: 10),
                                child: Text(
                                  "${snapshot.data!.photos!.length} search results for ${widget.categoryName}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: MasonryGridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              itemCount: snapshot.data!.photos!.length,
                              itemBuilder: (context, index) {
                                return WallpaperGrid(
                                  imageUrl: snapshot
                                      .data!.photos![index].src!.portrait
                                      .toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("No results found"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
