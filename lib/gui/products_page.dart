import 'package:aumetass1/gui/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/product.dart';
import '../services/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productId: product.id)));},
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
          BoxShadow(
            offset: Offset(2.0,2.0),
            color: Colors.black12,
          )
        ]),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(product.name, style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product.photoUrl,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5,),

              Text('\$${product.description}'),
              SizedBox(height: 5,),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent[200]) ,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productId: product.id)));
                  },
                  child: Text('SEND A MESSAGE'),
                ),
              ),
              SizedBox(height: 5,),

            ],
          ),
        ),
      ),
    );
  }
}


class ProductGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Grid',)
        ,leading:Container(),backgroundColor: Colors.white,),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
       // padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Consumer(
          builder: (context, watch, child) {
            final productState = watch(productsProvider);

            return productState.when(
              data: (products) {
                final pagingController = PagingController<int, Product>(firstPageKey: 0);

                // Load the first 5 products initially
                pagingController.appendPage(products.take(5).toList(), 0);

                pagingController.addPageRequestListener((pageKey) {
                  final offset = pageKey * 5*2;

                  // Fetch the next page of products
                  final nextPageProducts = products.skip(offset).take(0).toList();

                  pagingController.appendPage(nextPageProducts, pageKey + 5);
                });

                return PagedGridView<int, Product>(
                  pagingController: pagingController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 10.0,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                    itemBuilder: (context, product, index) => ProductItem(product: product),
                  ),
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (_, __) => Text('Error loading products'),
            );
          },
        ),
      ),
    );
  }
}


