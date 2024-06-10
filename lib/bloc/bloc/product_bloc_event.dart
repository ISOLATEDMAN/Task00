part of 'product_bloc_bloc.dart';

class ProductBlocEvent extends Equatable{
  const ProductBlocEvent();

  @override
  List<Object> get props => [];
}

class AddtoCartEvent extends ProductBlocEvent{
  final String ProdId;
  final String Prodname;
  final String Price;
  const AddtoCartEvent(this.ProdId,this.Prodname,this.Price,);
  @override
  List<Object> get props => [Prodname,Price];
}

class SuccesfuladdEvent extends ProductBlocEvent{
}


