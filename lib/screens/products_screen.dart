import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:paras_tech_test/provider/fav_provider.dart';
import 'package:paras_tech_test/screens/favscreen.dart';
import 'package:paras_tech_test/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductListingScreen extends ConsumerStatefulWidget {
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends ConsumerState<ProductListingScreen> {
  late Future<Product> futureProducts;
  // List<dynamic> products = [];


  @override
  void initState() {
    super.initState();
    // fetchData();
     fetchProducts();
    print("the xx ");
  }

  // Future<void> fetchData() async {
  //   final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  //   if (response.statusCode == 200) {
  //         print("the list is ${response.body}");
  //
  //     setState(() {
  //       products = json.decode(response.body);
  //       print("the pro ${products}");
  //
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

 fetchProducts() async {
    var response =
    await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {

      dynamic responseData = Product.fromJson(jsonDecode(response.body));
      print('responsedara ${responseData}');
      return responseData.products;
    } else {
      print("error occured");
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = FavoriteProvider.of(context);
    // final words = provider.items;

    // debugPrint("the fav list is ${words}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(onPressed: (){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => FavScreen(),
    ),
    );

    }, icon: Icon(Icons.favorite)),

        ],
      ),
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          debugPrint("snapshot ${snapshot.data}");
          List<Products> items = snapshot!.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: items.length,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(items![index].thumbnail.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          SizedBox(width: 10,),
                          Expanded(child: Text(items[index].description.toString())),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                          Text(items[index].price.toString()),
                          SizedBox(width: 5,),
                          Text('Brand',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 5,),
                          Expanded(
                              flex: 1,
                              child: Text(items[index].brand.toString())),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                          Text(items[index].title.toString()),
                          SizedBox(width: 5,),
                          Text('Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 5,),
                          Expanded(
                              flex: 1,
                              child: Text(items[index].category.toString())),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Rating',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                          Text(items[index].rating.toString()),
                          SizedBox(width: 5,),
                          Text('Discount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 5,),
                          Expanded(
                              flex: 1,
                              child: Text(items[index].discountPercentage.toString())),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.teal.shade300)),
                            child: Text("Add to favorite",style: TextStyle(color: Colors.black),),
                            onPressed: (){
                              ref.read(listFavProvider.notifier).addToFav(items[index]);

                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text('Added to Favorite'),
                                duration: Duration(seconds: 1),
                                // action: SnackBarAction(
                                //   label: 'ACTION',
                                //   onPressed: () { },
                                // ),
                              ));

                            },
                          ),
                        ],
                      ),




                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
