import 'dart:convert';
import 'package:flutter/material.dart';
import 'SearchBar.dart'; // Assuming SearchBar.dart exists

class ListMovies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesState();
}

class _MoviesState extends State {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
            },
            icon: Icon(Icons.search, color: Colors.black),
          )
        ],
      ),
    );
  }
}
