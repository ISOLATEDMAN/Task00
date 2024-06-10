part of 'product_bloc_bloc.dart';

 class ProductBlocState extends Equatable{
  const ProductBlocState();
  @override
  List<Object> get props => [];
}

class ProductBlocInitial extends ProductBlocState {}

class ProdLoaded extends ProductBlocState{
  List<String> cartProdId;
  ProdLoaded(this.cartProdId);
  @override
  List<Object> get props => [cartProdId];
}

class ProdError extends ProductBlocState{
  final String msg;
  const ProdError(this.msg);
  @override
  List<Object> get props => [msg];
}

class CartItemCount extends ProductBlocState {
  final int itemCount;

  CartItemCount(this.itemCount);

  @override
  List<Object> get props => [itemCount];

  int get count => itemCount;
}



