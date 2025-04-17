import 'package:flutter/material.dart';

class FavoritesPage<T> extends StatelessWidget {
  final String appBarTitle;
  final List<T> items;
  final Widget Function(BuildContext context, List<T> items) itemBuilder;
  final Widget shimmerWidget;
  final bool isLoading;

  const FavoritesPage({
    Key? key,
    required this.appBarTitle,
    required this.items,
    required this.itemBuilder,
    required this.shimmerWidget,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: isLoading
          ? shimmerWidget
          : items.isEmpty
              ? Center(
                  child: Text(
                    "No favorite ${appBarTitle.toLowerCase()} found",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SingleChildScrollView(
                    child: itemBuilder(
                      context,
                      items,
                    ),
                  ),
                ),
    );
  }
}
