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
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/500x750'), // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black54,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Movie Title',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Plot: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          'IMDB Rating: 7.5',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          'Genre: Action',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Year: 2023',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
