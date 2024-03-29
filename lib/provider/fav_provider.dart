 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paras_tech_test/models/product.dart';

final listFavProvider =
StateNotifierProvider<FavoriteController, List<Products>>(
        (ref) {
      return FavoriteController();
    });

class FavoriteController extends StateNotifier<List<Products>> {
  FavoriteController() : super([]);



  void addToFav(Products item) {
    // data[index]['isFavorite'] = true;
    // final result =
    // data.where((element) => element['isFavorite'] == true).toList();

    state = [...state,item];
  }


  void clearAll(){
    state=[];
  }

  void removeFromFav(Products id) {
    state = state.where((element) => element != id).toList();
    }

}