import 'package:flutter/material.dart';
import 'package:view_movie/components/convert_date_format.dart';
import 'package:view_movie/components/my_text_design.dart';
import 'package:view_movie/models/movie_cast_list.dart';
import 'package:view_movie/models/popular_list.dart';
import 'package:view_movie/services/remote_service.dart';

class DetailsPage extends StatefulWidget {
  Results result;
  DetailsPage({super.key, required this.result});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getMovieCastListData();
  }

  getMovieCastListData() async {
    castList =
        await RemoteService().getMovieCastList(widget.result.id.toString());
    if (castList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        leading: BackButton(
          color: Theme.of(context).colorScheme.primary,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/original${widget.result.backdropPath.toString()}"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.25), BlendMode.modulate)),
          ),
          child: Container(
            width: width,
            height: height,
            margin: EdgeInsets.fromLTRB(10, height * 1 / 7, 10, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // image
                    Container(
                      width: width * 30 / 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            "https://image.tmdb.org/t/p/w500${widget.result.posterPath}"),
                      ),
                    ),
                    SizedBox(width: 20),
                    // movie info
                    Expanded(
                      child: Container(
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // movie name
                            MyTextDesign(
                              text: widget.result.title.toString(),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            // movie release date
                            MyTextDesign(
                                text:
                                    "Xuất bản:   ${convertDateFormat(widget.result.releaseDate.toString())}",
                                fontSize: 12),
                                // movie genre
                            MyTextDesign(
                                text: "Thể loại:   ABCXYZ", fontSize: 12),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // text 'cast'
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: MyTextDesign(text: "Cast", fontSize: 16, fontWeight: FontWeight.bold,))),
                // cast list
                Container(
                  height: height * 29 / 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: castList?.length,
                      itemBuilder: ((context, index) {
                        final cast = castList![index];
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          height: height * 20 / 100,
                          constraints: BoxConstraints(maxWidth: width * 29 / 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${cast.profilePath}",
                                  errorBuilder: (context, error, stackTract) {
                                    return Image.asset("assets/image_load_failed.jpg");
                                  },
                                ),
                              ),
                              MyTextDesign(text: cast.originalName.toString(), fontSize: 11, textOverflow: TextOverflow.ellipsis, maxLines: 1,),
                              MyTextDesign(text: cast.character.toString(), fontSize: 9, textOverflow: TextOverflow.ellipsis, maxLines: 1,),
                            ],
                          ),
                        );
                      })),
                ),
                // text 'overview'
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: MyTextDesign(text: "Overview", fontSize: 16, fontWeight: FontWeight.bold,))),
                // description
                Center(
                  child: MyTextDesign(text: widget.result.overview.toString(), fontSize: 14)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
