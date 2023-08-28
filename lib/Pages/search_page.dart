import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel/Services/Utils/function.dart';

import '../Model/category_model.dart';
import '../Widgets/wallpaper_grid.dart';

class SearchPage extends StatefulWidget {
  String searchQuery;
  SearchPage({super.key, required this.searchQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  PexelsApi pexelsApi = PexelsApi();
  List<CategoryModel> category = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    pexelsApi.getSearchWallpapers(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey.shade500,
        ),
        // backgroundColor: Colors.deepOrange,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        hintText: "Search wallpaper",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        suffixIcon: InkWell(
                          child: Icon(Icons.search),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.014,
              ),
              Expanded(
                child: FutureBuilder(
                  future: pexelsApi.getSearchWallpapers(widget.searchQuery),
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
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, top: 5, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data!.photos!.length} search results for ${widget.searchQuery}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
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
