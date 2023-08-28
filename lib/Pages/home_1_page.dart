import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel/Data/data.dart';
import 'package:pixel/Pages/category_page.dart';
import 'package:pixel/Pages/search_page.dart';
import 'package:pixel/Services/Utils/function.dart';
import 'package:pixel/Widgets/category_tile.dart';
import '../Model/category_model.dart';
import '../Widgets/wallpaper_grid.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  PexelsApi pexelsApi = PexelsApi();
  List<CategoryModel> category = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    category = getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Pixel",
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            fontSize: 35,
            color: Color(0xff3b3b3b),
          ),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(
                                  searchQuery: searchController.text,
                                ),
                              ),
                            );
                          },
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
                //flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                  categoryName: category[index].categoryName),
                            ));
                      },
                      child: Container(
                        child: CategoryTile(
                            imageUrl: category[index].imageUrl,
                            title: category[index].categoryName),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: FutureBuilder(
                  future: pexelsApi.getCuratedWallpapers(),
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
                      return MasonryGridView.count(
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
