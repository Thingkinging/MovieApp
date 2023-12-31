import 'package:flutter/material.dart';
import 'package:movies/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath.toString();
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(16),
              height: height / 1.5,
              child: Image.network(path),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(movie.overview.toString()),
            ),
          ]),
        ),
      ),
    );
  }
}
