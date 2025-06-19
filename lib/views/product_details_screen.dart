import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/productsModel/products_response.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title ?? ""),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.thumbnail ?? "",
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Title & Brand
            Text(product.title ?? "",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(product.brand ?? "",
                style: const TextStyle(fontSize: 16, color: Colors.grey)),

            const SizedBox(height: 12),

            /// Price and Discount
            Row(
              children: [
                Text("₹${product.price}",
                    style: const TextStyle(
                        fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text(
                  product.discountPercentage != null
                      ? "${product.discountPercentage!.toStringAsFixed(1)}% OFF"
                      : "No Discount",
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
              ],
            ),

            const SizedBox(height: 8),

            /// Rating and Stock
            Row(
              children: [
                Icon(Icons.star, color: Colors.orangeAccent, size: 20),
                Text("${product.rating}"),
                const SizedBox(width: 16),
                Text("Stock: ${product.stock}"),
              ],
            ),

            const Divider(height: 30),

            /// Description
            Text("Description",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(product.description ?? "", style: const TextStyle(fontSize: 16)),

            const Divider(height: 30),

            /// Reviews
            Text("Reviews",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            ...(product.reviews?.map((review) => Card(
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pinkAccent.shade100,
                      child: Text(review.reviewerName?[0] ?? ""),
                    ),
                    title: Text(review.reviewerName ?? "Anonymous"),
                    subtitle: Text(review.comment ?? "No comment provided"),
                    trailing: Text("⭐️ ${review.rating}"),
                  ),
                )) ?? []),

            const Divider(height: 30),

            /// Shipping & Return Info
            Text("Shipping: ${product.shippingInformation}"),
            Text("Warranty: ${product.warrantyInformation}"),
            Text("Return Policy: ${product.returnPolicy}", style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 20),

            /// Buy Now
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Buy Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
