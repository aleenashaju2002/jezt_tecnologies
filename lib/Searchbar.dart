import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jezt_tecnologies/MovieDetalis.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPage();
}

class SearchPage extends State<Search> {
  String apiKey = "3710fd57";
  List movies = [];
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchMovies(String title) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=$title'));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        movies = data['Search'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) {
                fetchMovies(value);
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        movies.clear();
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: movies[index]['Poster'] != 'N/A'
                ? Image.network(movies[index]['Poster'])
                : Image.asset('assets/placeholder.png'),
            title: Text(movies[index]['Title']),
            subtitle: Text(movies[index]['Year']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailsClass(movies[index]['imdbID'], apiKey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  final String movieId;
  final String apiKey;

  MovieDetails(this.movieId, this.apiKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: Center(
        child: Text('Movie ID: $movieId'),
      ),
    );
  }
}
