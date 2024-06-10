import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  CollectionReference Cart = FirebaseFirestore.instance.collection('addedcart');
  ProductBlocBloc() : super(ProductBlocInitial()) {
    on<AddtoCartEvent>(_onaddtocart);
    on<SuccesfuladdEvent>(_onSucces);
    

  }
  Future<void> _onaddtocart(AddtoCartEvent event,Emitter<ProductBlocState>emit)async{
    try{
      await Cart.add({
        "name":event.Prodname,
        "price":event.Price,
      }
      );
      emit(ProdLoaded([]));

    }catch(e){
      emit(ProdError(e.toString()));
    }
  }
  Future<void> _onSucces(SuccesfuladdEvent event,Emitter<ProductBlocState>emit)async{
try {
      final cartSnapshot = await Cart.get();
      final cartProdIds = cartSnapshot.docs.map((doc) => doc.id).toList();
      emit(ProdLoaded(cartProdIds));
      _emitCartItemCount();
    } catch (e) {
      emit(ProdError(e.toString()));
    }
  }
  void _emitCartItemCount() async {
    final cartSnapshot = await Cart.get();
    final itemCount = cartSnapshot.docs.length;
    add(CartItemCount(itemCount) as ProductBlocEvent); 
  }
}
