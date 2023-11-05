import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie.dart';
import 'package:movies/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result = '';
  HttpHelper? helper;
  int moviesCount = 0;
  List? movies;

  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');

  Future initialize() async {
    movies = [];
    movies = await helper?.getUpcoming();
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }

  Future search(text) async {
    movies = await helper?.findMovies(text);
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onSubmitted: (String text) {
                      search(text);
                    },
                  );
                } else {
                  setState(() {
                    visibleIcon = Icon(Icons.search);
                    searchBar = Text('Movies');
                  });
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: moviesCount == null ? 0 : moviesCount,
        itemBuilder: (BuildContext context, int position) {
          if (movies?[position].posterPath != null) {
            image = NetworkImage(iconBase + movies?[position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies?[position].title),
              subtitle: Text('Released: ' +
                  movies?[position].releaseDate +
                  ' - Vote: ' +
                  movies![position].voteAverage.toString()),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetail(movies?[position]),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
