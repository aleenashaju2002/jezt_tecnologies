import 'package:flutter/material.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.network(
              'https://via.placeholder.com/500x700', // Placeholder for movie poster
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 16.0),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Movie Title',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Plot: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Text(
                        'IMDB Rating: 7.5',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        'Genre: Action, Thriller',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Year: 2023',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
