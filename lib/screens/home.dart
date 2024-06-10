import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task00/bloc/bloc/product_bloc_bloc.dart'; // import your bloc file here

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBlocBloc>().add(SuccesfuladdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: BlocBuilder<ProductBlocBloc, ProductBlocState>(
        builder: (context, state) {
          if (state is ProdError) {
            return Center(child: Text(state.msg));
          } else {
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Products').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Something went wrong"));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No products available'));
                      }

                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          bool isAdded = (state is ProdLoaded) && state.cartProdId.contains(document.id);
                          return ListTile(
                            title: Text(data['name']),
                            subtitle: Text('Price: \$${data['price']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (!isAdded) {
                                      context.read<ProductBlocBloc>().add(AddtoCartEvent(document.id, data['name'], data['price'].toString()));
                                    }
                                  },
                                  child: Icon(isAdded ? Icons.check : Icons.add),
                                ),
                                SizedBox(width: 40),
                                InkWell(
                                  onTap: () {
                                    showEditDialog(document.id, data['name'], data['price']);
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                SizedBox(width: 40),
                                InkWell(
                                  onTap: () {
                                    deleteProduct(document.id);
                                  },
                                  child: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogBox();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showDialogBox() {
    TextEditingController _name = TextEditingController();
    TextEditingController _price = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Items"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    helperText: "ENTER PRODUCT NAME",
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _price,
                  decoration: const InputDecoration(
                    helperText: "Enter price",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _name.text;
                String priceStr = _price.text;
                double? price = double.tryParse(priceStr);

                if (name.isNotEmpty && price != null) {
                  await addProduct(name, price);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid data'))
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addProduct(String name, double price) async {
    CollectionReference products = FirebaseFirestore.instance.collection('Products');
    await products.add({
      'name': name,
      'price': price,
    }).then((value) => print('Product Added'))
    .catchError((error) => print('Failed to add product: $error'));
  }

  Future<void> showEditDialog(String id, String currentName, double currentPrice) {
    TextEditingController _name = TextEditingController(text: currentName);
    TextEditingController _price = TextEditingController(text: currentPrice.toString());
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Item"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    helperText: "Enter product name",
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _price,
                  decoration: const InputDecoration(
                    helperText: "Enter price",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _name.text;
                String priceStr = _price.text;
                double? price = double.tryParse(priceStr);

                if (name.isNotEmpty && price != null) {
                  await editProduct(id, name, price);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid data'))
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> editProduct(String id, String name, double price) async {
    CollectionReference products = FirebaseFirestore.instance.collection('Products');
    await products.doc(id).update({
      'name': name,
      'price': price,
    }).then((value) => print('Product Updated'))
    .catchError((error) => print('Failed to update product: $error'));
  }

  Future<void> deleteProduct(String id) async {
    CollectionReference products = FirebaseFirestore.instance.collection('Products');
    await products.doc(id).delete().then((value) => print('Product Deleted'))
    .catchError((error) => print('Failed to delete product: $error'));
  }
}
