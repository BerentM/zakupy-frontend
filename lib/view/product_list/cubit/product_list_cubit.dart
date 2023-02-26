import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/data/models/product_list.dart';
import 'package:zakupy_frontend/utils/logs.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final component = "ProductListCubit";
  ProductListCubit() : super(ProductListInitial());

  void loadData() async {
    logger.d("fetching data", component);
    var l = await ApiService().fetchProductList();
    emit(ProductListLoaded(l));
  }

  void reloadData() async {
    logger.d("reloading data", component);
    emit(ProductListInitial());
  }
}
