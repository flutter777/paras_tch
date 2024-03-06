import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:paras_tech_test/provider/fav_provider.dart';
import 'package:paras_tech_test/screens/favscreen.dart';
import 'package:paras_tech_test/screens/login_google.dart';
import 'package:paras_tech_test/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductListingScreen extends ConsumerStatefulWidget {
   final User? user;

  const ProductListingScreen({super.key, required this.user});

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends ConsumerState<ProductListingScreen> {
  late Future<Product> futureProducts;
  // List<dynamic> products = [];

  Future<void> signOut() async{
     await FirebaseAuth.instance.signOut();
     Navigator.push(context, MaterialPageRoute(
         builder: (context)=>GoogleLoginPage()),
    );
  }


  @override
  void initState() {
    super.initState();
    // fetchData();
     fetchProducts();
    print("the xx ");
  }


 fetchProducts() async {
    var response =
    await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {

      dynamic responseData = Product.fromJson(jsonDecode(response.body));
      // print('responsedara ${responseData}');
      return responseData.products;
    } else {
      print("error occured");
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {

    return widget.user==null?const Scaffold(body: Center(child: Text("Nothong to show"),),): Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text( widget.user!.displayName.toString()),
              accountEmail: Text(widget.user!.email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    widget.user!.photoURL.toString()),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.user!.photoURL.toString(),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text(widget.user!.emailVerified.toString()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text(widget.user!.phoneNumber.toString()),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text(widget.user!.phoneNumber.toString()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () {signOut();},
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          IconButton(onPressed: (){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const FavScreen(),
    ),
    );

    }, icon: const Icon(Icons.favorite)),

        ],
      ),
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          debugPrint("snapshot ${snapshot.data}");
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot!.data.length,
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
                      Image.network(snapshot!.data![index].thumbnail.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          const SizedBox(width: 10,),
                          Expanded(child: Text(snapshot!.data[index].description.toString())),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          Text(snapshot!.data[index].price.toString()),
                          const SizedBox(width: 10,),
                          const Text('Brand',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(width: 10,),
                          Text(snapshot!.data[index].brand.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          Text(snapshot!.data[index].title.toString()),
                          const SizedBox(width: 10,),
                          const Text('Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(width: 10,),
                          Text(snapshot!.data[index].category.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Rating',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          Text(snapshot!.data[index].rating.toString()),
                          const SizedBox(width: 10,),
                          const Text('Discount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(width: 10,),
                          Text(snapshot!.data[index].discountPercentage.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.teal.shade300)),
                            child: const Text("Add to favorite",style: TextStyle(color: Colors.black),),
                            onPressed: (){
                              ref.read(listFavProvider.notifier).addToFav(snapshot!.data[index]);

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
          }
          else if (snapshot.connectionState==ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data==null) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
