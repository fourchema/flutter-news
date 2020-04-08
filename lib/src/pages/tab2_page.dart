import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  
  final Category categoria;

  const Tab2Page({Key key, this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            
            _ListaCategorias(),

            if ( !newsService.isLoading)
              Expanded(
                child: ListaNoticias( newsService.getArticulosCategoriaSeleccionada )
              ),

            if ( newsService.isLoading )
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              )
            )


          ],
        )

      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final categories = Provider.of<NewsService>(context).categories;

  
  
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){

          final categoryName = categories[index].name;


          return Container(
            width: 105,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categoria: categories[index],),
                  SizedBox(height: 5,),
                  Text('${categoryName[0].toUpperCase()}${categoryName.substring(1)}')
                ],
              ),
         ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;

  const _CategoryButton({this.categoria});

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    
    return GestureDetector(
      onTap: (){
        print('${categoria.name}');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
            ? miTema.accentColor
            : Colors.black54
        )
      ),
    );
  }
}