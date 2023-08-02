import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final productDetailsState =
        watch(productDetailsProvider(productId)); // Watch the future

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
      ),
      body: productDetailsState.when(
        data: (productDetails) => buildProductDetails(productDetails.products),
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) =>
            Text('Error loading product details: $error'),
      ),
    );
  }

  Widget buildProductDetails(productDetails) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: productDetails.photoUrl,
                ),
                SizedBox(height: 15),
                Text(productDetails.description,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                    width: 350,
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 2,
                    )),
                SizedBox(height: 5),
                Text(
                  'Desterputer  Name',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 15),
                Text('${productDetails.description}'),
                SizedBox(height: 15),
                SizedBox(
                    width: 350,
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 2,
                    )),
                SizedBox(height: 5),
                Text(
                  'Sientific Name',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 15),
                Text('${productDetails.name}'),
                SizedBox(
                    width: 350,
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 2,
                    )),
                SizedBox(height: 5),
                Text(
                  'Ratial Price',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 15),
                Text('${productDetails.price}'),
                SizedBox(
                    width: 350,
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 2,
                    )),
                Container(width: 40, height: 170, color: Colors.white)
              ],
            ),
          ),
        ),
        Positioned(
          top: 600,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2.0, 2.0),
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 40)),
                Text(productDetails.price.toString() , style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
              SizedBox(width: 20,),
                ElevatedButton(
                    style:ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent[200]) ,
                    onPressed: (){}, child: Text("Add to cart"))
              ],
            ),
            width: 500,
            height: 200,
          ),
        )
      ],
    );
  }
}
