import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';


class MovieSlder extends StatefulWidget {

  

  final List<Movie> movies;
  final String title;
  final Function onNextPage;

  const MovieSlder({
    Key key,
    this.movies,
    this.title,
    this.onNextPage,
    }) : super(key: key);

  @override
  State<MovieSlder> createState() => _MovieSlderState();
}

class _MovieSlderState extends State<MovieSlder> {


  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [

          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Text(this.widget.title,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) => _MovePoster(widget.movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovePoster extends StatelessWidget {

  final Movie movie;

  const _MovePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:130,
      height:190,
      margin: EdgeInsets.symmetric(horizontal:10,vertical:10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPorterImg),
                width:130,
                height:180,
                fit: BoxFit.cover,
                ),
            ),
          ),

          SizedBox(height:5),

          Text(
             movie.title,
             maxLines: 2,
             overflow: TextOverflow.ellipsis,
             textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}