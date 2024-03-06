import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';


class ProductDetailScreen extends StatelessWidget {
  List<Products> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: ListView.builder(
        itemCount: product.length,
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
                        Colors.blue.shade300)),
                child: Text("Add to favorite", style: TextStyle(
                    color: Colors.black),),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.blue,
                        content: Text('Added to Favorite'),
                        duration: Duration(seconds: 1),
                        // action: SnackBarAction(
                        //   label: 'ACTION',
                        //   onPressed: () { },
                        // ),
                      ));
                  // provider.toggleFavorite(snapshot.data![index]);

                },
              ),
              title: Text(product[index].id.toString(), style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),),
              subtitle: Text('${product![index].title
                ..toString()}', style: TextStyle(color: Colors.blue),),
              leading: Hero(
                tag: product![index].thumbnail.toString(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                  child: Image.network(
                    product[index].thumbnail!.toString(),
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
