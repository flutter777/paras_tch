
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paras_tech_test/provider/fav_provider.dart';

import '../models/product.dart';
class FavScreen extends ConsumerStatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<FavScreen> {
  @override
  Widget build(BuildContext context,) {
    List<Products> list=  ref.watch(listFavProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Text("clear all"),
          onPressed: (){
            ref.read(listFavProvider.notifier).clearAll();
          }),
      appBar: AppBar(
        title: Text('Favorite screen'),
      ),
      body: list.isEmpty?Center(child: Text('No favorites Added')): ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
            shadowColor: Colors.blue,
            elevation: 2,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(15.0)
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              style: ListTileStyle.drawer,
              trailing: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.red.shade300)),
                child: Text("Remove From Favorite", style: TextStyle(
                    color: Colors.black),),
                onPressed: () {
                  ref.read(listFavProvider.notifier).removeFromFav(list[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Removed'),
                        duration: Duration(seconds: 1),
                        // action: SnackBarAction(
                        //   label: 'ACTION',
                        //   onPressed: () { },
                        // ),
                      ));
                  // provider.toggleFavorite(snapshot.data![index]);

                },
              ),
              title: Text(list[index].id.toString(), style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),),
              subtitle: Text('${list![index].title
                ..toString()}', style: TextStyle(color: Colors.blue),),
              leading: Hero(
                tag: list![index].thumbnail.toString(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                  child: Image.network(
                    list[index].thumbnail!.toString(),
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         ProductDetailScreen(
                //             product: items),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
