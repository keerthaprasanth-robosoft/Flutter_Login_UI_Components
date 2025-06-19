import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/productsModel/appSession.dart';
import 'package:flutter_test_project/models/productsModel/products_response.dart';
import 'package:flutter_test_project/components/colors.dart';
import 'package:flutter_test_project/components/text_styles.dart';

class ProductsListScreen extends StatefulWidget {
  final String category;
  const ProductsListScreen({
    super.key,
    required this.category,
  });

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  List<Product>? products;
  List<Product>? filteredProducts;
  String selectedPriority = 'all';

  @override
  void initState() {
    super.initState();
    products = AppSession().getProducts();
    if (widget.category != '') {
      products = products!
          .where((ticket) =>
              ticket.category?.toLowerCase() == widget.category.toLowerCase())
          .toList();
      filteredProducts = products;
    } else {
      filteredProducts = products;
    }
  }

  // Method to filter products based on priority
  void filterProducts(String priority) {
    setState(() {
      selectedPriority = priority;
      if (priority == 'all') {
        filteredProducts = products;
      } else {
        filteredProducts = products
            ?.where((ticket) => ticket.availabilityStatus == priority)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTS', style: AppTextStyles.headline),
        foregroundColor: AppColors.backgroundColor,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.gradientColor,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => filterProducts(value),
            icon: const Icon(Icons.filter_list),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    if (selectedPriority == 'all') ...[
                      const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 8),
                    ],
                    const Text('All'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Low Stock',
                child: Row(
                  children: [
                    if (selectedPriority == 'Low Stock') ...[
                      const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 8),
                    ],
                    const Text('Priority: Low Stock'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'In Stock',
                child: Row(
                  children: [
                    if (selectedPriority == 'In Stock') ...[
                      const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 8),
                    ],
                    const Text('Priority: In Stock'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Out of Stock',
                child: Row(
                  children: [
                    if (selectedPriority == 'Out of Stock') ...[
                      const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 8),
                    ],
                    const Text('Priority: Out of Stock'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: filteredProducts != null && filteredProducts!.isNotEmpty
          ? ListView.builder(
              itemCount: filteredProducts!.length,
              itemBuilder: (context, index) {
                final ticket = filteredProducts![index];
                return InkWell(
                  onTap: () {
                    //Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ChangeNotifierProvider(
                    //       create: (context) => ProductDetailsViewModel(),
                    //       child: ProductDetailsScreen(
                    //           ticketId: ticket.id.toString(),
                    //           ticketName: ticket.title ?? ""),
                    //     ),
                    //   ),
                    // );
                  },
                  child: Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ticket.title ?? "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(ticket.brand ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          Text(
                            _stripHtml(ticket.description ?? ""),
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Category: ${ticket.category?.capitalize() ?? 'N/A'}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'Priority: ${ticket.availabilityStatus?.capitalize() ?? 'Unknown'}',
                                style: TextStyle(
                                  color: _getAvailabilityColor(
                                      ticket.availabilityStatus),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : const Center(
              child: Text(
                'No Products found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  // Helper method to strip HTML tags
  String _stripHtml(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '').trim();
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

Color _getAvailabilityColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'in stock':
      return Colors.green;
    case 'low stock':
      return Colors.orange; // or Colors.yellow
    case 'out of stock':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
