import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:mackupapp/product.dart';
import 'package:mackupapp/provider/GroceryBlocStore.dart';
import 'package:mackupapp/screens/details.dart';

Product product = Product();
const _cartBarHeight = 100.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = GroceryStoreBloc();
  void _verticalGesture(DragUpdateDetails details) {
    print(details.primaryDelta);
    if (details.primaryDelta < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return -_cartBarHeight;
    } else if (state == GroceryState.cart) {
      return -(size.height - 50 - _cartBarHeight / 2);
    }
  }

  double _getTopForBlackPanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return size.height - 50 - _cartBarHeight;
    } else if (state == GroceryState.cart) {
      return _cartBarHeight / 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: AppbarWidget(),
        ),
        body: AnimatedBuilder(
          animation: bloc,
          builder: (context, _) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: _getTopForWhitePanel(bloc.groceryState, size),
                        height: size.height - 50,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: ProductItem(),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: _getTopForBlackPanel(bloc.groceryState, size),
                        height: size.height,
                        child: GestureDetector(
                          onVerticalDragUpdate: _verticalGesture,
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}

class AppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Mackup"),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_basket,
          size: 30,
          color: Colors.yellow,
        )
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  // List<dynamic> data;
  Future<List<Product>> getMakeupData() async {
    http.Response response = await http.get(Uri.parse(
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));

    return productFromJson(response.body);
  }

  String img;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder<List<Product>>(
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
                itemCount: snapshot.data.length,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: "Image",
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (context, animation, _) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: DetailScreen(
                                        img: snapshot.data[index].imageLink,
                                        name: snapshot.data[index].name,
                                        price: snapshot.data[index].price,
                                        description:
                                            snapshot.data[index].description,
                                        type: snapshot.data[index].productType,
                                      ),
                                    );
                                  }));
                                },
                                child: Center(
                                  child: img == null
                                      ? Image.network(
                                          snapshot.data[index].imageLink,
                                          height: 150,
                                        )
                                      : Image.network(
                                          "https://d3t32hsnjxo7q6.cloudfront.net/i/c77ad2da76259cfd67a9a9432f635bfb_ra,w158,h184_pa,w158,h184.png",
                                          height: 150,
                                        ),
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data[index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              "\$ ${snapshot.data[index].price}",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.fit(1);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: getMakeupData(),
      ),
    );
  }
}
