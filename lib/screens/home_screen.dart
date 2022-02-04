import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context); //crea una instancia de moviesProvider
    
    return Scaffold(
      appBar: AppBar( 
        title: Center(child:  
        Text('Peliculas en Cines'),
        ),
        // actions: [
        //   IconButton(icon: Icon(Icons.search_outlined),
        //   onPressed: (){},
        //   )
        // ],
        //elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
            children:[
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              MovieSlder(
                movies:moviesProvider.popularMovies,
                title:'Populares',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ]
          )
        )
    );
  }
}