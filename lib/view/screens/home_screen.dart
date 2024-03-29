import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaper_app/view/screens/categories_screens.dart';
import '../../controllers/api_operation.dart';
import '../../models/categories_model.dart';
import '../../models/wallpaper_models.dart';
import '../widgets/categories_box.dart';
import '../widgets/search_box.dart';
import '../widgets/wallpaper_box.dart';
import 'full_screen_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WallPaperModel> wallPaper = [];
  List<CategoryModel> categoryModelList = [];
  ApiOperation apiOperation = ApiOperation();
  TextEditingController _searchController = TextEditingController();

  getCategoryDetails() async {
    List<CategoryModel> categoryModelListt = await ApiOperation().getCategoriesList();
    setState(() {
      categoryModelList = categoryModelListt;
    });
  }

  getWallPaper() async {
    wallPaper = await apiOperation.getWallpaper();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    getWallPaper();
    getCategoryDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: const Text(
              "Wall Paper",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SearchBox(searchController: _searchController),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryModelList.length,
              itemBuilder: (context, index) => CategoriesBox(
                categoryImgSrc: categoryModelList[index].catImgUrl,
                categoryName: categoryModelList[index].catName,
              ),
            ),
          ),
          // Container(
          //   height: 70,
          //   margin: EdgeInsets.only(left: 20.0),
          //   width: MediaQuery.of(context).size.width,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: categoryModelList.length,
          //     itemBuilder: ((context, index) => CategoriesBox(
          //           categoryImgSrc: categoryModelList[index].catImgUrl,
          //           categoryName: categoryModelList[index].catName,
          //         )),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 12,
                ),
                itemCount: wallPaper.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: wallPaper[index].imgScr,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenView(
                              imgSrc: wallPaper[index].imgScr,
                            ),
                          ),
                        );
                      },
                      child: WallPaperWidget(
                        imgScr: wallPaper[index].imgScr,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
