import 'package:flutter/material.dart';

import '../../widgets/favourite/search_bar_widget.dart';

class FavoritesPage<T> extends StatefulWidget {
  final String appBarTitle;
  final List<T> items;
  final Widget Function(BuildContext context, List<T> items) itemBuilder;
  final Widget shimmerWidget;
  final bool isLoading;
  final bool Function(T item, String query) searchPredicate;

  const FavoritesPage({
    Key? key,
    required this.appBarTitle,
    required this.items,
    required this.itemBuilder,
    required this.shimmerWidget,
    this.isLoading = false,
    required this.searchPredicate,
  }) : super(key: key);

  @override
  State<FavoritesPage<T>> createState() => _FavoritesPageState<T>();
}

class _FavoritesPageState<T> extends State<FavoritesPage<T>> {
  final TextEditingController searchController = TextEditingController();
  late List<T> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = List<T>.from(widget.items);
  }

  @override
  void didUpdateWidget(FavoritesPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      // Update filtered items when the original items list changes
      setState(() {
        _filterItems(searchController.text);
      });
    }
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = List<T>.from(widget.items);
      } else {
        filteredItems = widget.items.where((item) {
          // Use the provided searchPredicate function
          return widget.searchPredicate(item, query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.appBarTitle,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: widget.isLoading
          ? widget.shimmerWidget
          : widget.items.isEmpty
              ? Center(
                  child: Text(
                    "No favorite ${widget.appBarTitle.toLowerCase()} found",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      SearchBarWidget(
                        controller: searchController,
                        onChanged: _filterItems,
                      ),
                      SingleChildScrollView(
                        child: widget.itemBuilder(
                          context,
                          filteredItems,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
