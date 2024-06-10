import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:view_movie/components/convert_date_format.dart';
import 'package:view_movie/components/my_text_design.dart';
import 'package:view_movie/models/popular_list.dart';
import 'package:view_movie/pages/details_page.dart';
import 'package:view_movie/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getPopularListData();
  }

  getPopularListData() async {
    resultsList = await RemoteService().getPopularList();
    if (resultsList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: [
              Tab(child: MyTextDesign(text: "Popular", fontSize: 22)),
              Tab(child: MyTextDesign(text: "Nowplaying", fontSize: 22)),
              Tab(child: MyTextDesign(text: "Up Coming", fontSize: 22)),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(top: 20),
          height: height,
          //padding: EdgeInsets.all(10),
          width: width,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                childAspectRatio: 3 / 4,
              ),
              itemCount: resultsList?.length,
              itemBuilder: ((context, index) {
                final result = resultsList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(result: result)
                      )
                    );
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // movie image
                        Container(
                          // height: height * 29 / 100,
                          constraints: BoxConstraints(
                            maxWidth: 150,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${result.posterPath}",
                                ),
                              ),
                              // release date
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    child: MyTextDesign(
                                        text: convertDateFormat(
                                            result.releaseDate.toString()),
                                        fontSize: 12,
                                        fontColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // movie name
                        Container(
                            constraints:
                                BoxConstraints(maxWidth: 150, minWidth: 150),
                            child: Center(
                                child: MyTextDesign(
                              text: result.title.toString(),
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                            )))
                      ],
                    ),
                  ),
                );
              })),
        )),
      ),
    );
  }
}
