import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class MovieDetailsClass extends StatelessWidget {
  final String imdbId;
  final String apiKey;

  MovieDetailsClass(this.imdbId, this.apiKey);

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
      backgroundColor: Colors.black,
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
            return Center(
              child: Stack(
                children: <Widget>[
                  Image.network(
                    data['Poster'], // Placeholder for movie poster
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 40.0),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200, // Adjust the height of the poster image
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: NetworkImage(data['Poster']), // Movie poster image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          '${data['Title']}',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              '${data['Genre']}',
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),

                        Row(
                            children: [
                              RatingBar.builder(
                                initialRating: double.parse(data['imdbRating']),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ]
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '${data['Year']}',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '${data['Plot']}',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}