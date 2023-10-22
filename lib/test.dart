import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieList(),
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String apiKey = "3710fd57"; // Replace with your actual API key
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
        title: Text('Movie Search App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                suffixIcon: IconButton(
                  onPressed: () {
                    fetchMovies(searchController.text);
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          if (isLoading)
            CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
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
                          builder: (context) => MovieDetails(movies[index]['imdbID'], apiKey),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  final String imdbId;
  final String apiKey;

  MovieDetails(this.imdbId, this.apiKey);

  Future<Map<String, dynamic>> fetchMovieDetails(String imdbId) async {
    final response = await http.get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&i=$imdbId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: FutureBuilder(
        future: fetchMovieDetails(imdbId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading movie details'),
            );
          } else {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(data['Poster']),
                  ),
                  SizedBox(height: 20),
                  Text('Title: ${data['Title']}'),
                  SizedBox(height: 10),
                  Text('Year: ${data['Year']}'),
                  SizedBox(height: 10),
                  Text('Genre: ${data['Genre']}'),
                  SizedBox(height: 10),
                  Text('Plot: ${data['Plot']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
