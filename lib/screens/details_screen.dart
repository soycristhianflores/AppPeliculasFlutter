import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments as Movie; 
    print(movie.title);

    return Scaffold(
      body:CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie),
                _Overview(movie),
                _Overview(movie),
                CastingCard(movie.id),
              ]
            )
          )
        ],
      )
    );
  }
}

//----------------------------------///

class _CustomAppBar extends StatelessWidget {

  final Movie movies;

  const _CustomAppBar(this.movies);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child:Text(movies.title,style: TextStyle(fontSize: 16)),
          padding: EdgeInsets.only(bottom:10),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movies.fullBackDropPath),
          fit: BoxFit.cover,
        ) ,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  

  @override
  Widget build(BuildContext context) {

  final size =  MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.only(top:20),
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Row(
        children:[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPorterImg),
                height: 140,
                width: 94,
            )
          ),
          SizedBox(width:20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 200,),
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title, style: Theme.of(context).textTheme.headline5,overflow: TextOverflow.ellipsis,maxLines: 2),
              Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis,maxLines: 2,),

              Row(
                children:[
                  Icon(Icons.star_outline,size:20,color:Colors.grey),
                  Text(movie.voteAverage,style: Theme.of(context).textTheme.caption)

                ]
              )
          ],)

          ),

        ]
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        
        ),
    );
  }
}