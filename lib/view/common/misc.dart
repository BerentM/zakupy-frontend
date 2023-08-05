import 'package:zakupy_frontend/data/models/product_list.dart';

List<dynamic> filterList(String searchedString, List<dynamic> inputList) {
  if (searchedString.isEmpty) {
    return inputList;
  } else {
    var productOutput = inputList
        .where((value) =>
            value.product!.toLowerCase().contains(searchedString.toLowerCase()))
        .toList();
    var sourceOutput = inputList
        .where((value) =>
            value.source!.toLowerCase().contains(searchedString.toLowerCase()))
        .toList();
    return <dynamic>{...productOutput, ...sourceOutput}.toList();
  }
}
