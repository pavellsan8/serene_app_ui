import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/routes.dart';

class GenericPage<T> extends StatefulWidget {
  final Future<List<T>> Function() fetchData; // Function to fetch data
  final String image; // Image URL or asset path
  final String feature; // Feature name for the page
  final String subtitle; // Subtitle for the page
  final Widget Function(List<T>) itemBuilder; // Custom item builder
  final Widget Function()? loadingBuilder;

  const GenericPage({
    super.key,
    required this.fetchData,
    required this.image,
    required this.feature,
    required this.subtitle,
    required this.itemBuilder, // Accept the custom widget builder function
    this.loadingBuilder,
  });

  @override
  // ignore: library_private_types_in_public_api
  _GenericPageState<T> createState() => _GenericPageState<T>();
}

class _GenericPageState<T> extends State<GenericPage<T>> {
  late Future<List<T>> futureData; // Future variable to store fetched data

  @override
  void initState() {
    super.initState();
    futureData =
        widget.fetchData(); // Fetch data once when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<List<T>>(
        future: futureData, // Use the futureData which is set only once
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return widget.loadingBuilder?.call() ??
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureData =
                            widget.fetchData(); // Re-trigger data fetching
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          // If data is available, build your custom UI
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                futureData = widget.fetchData(); // Trigger refresh
              });
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.homePage,
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 32,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Sere',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.feature,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        left: 20,
                        right: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              widget.subtitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.itemBuilder(
                      snapshot.data!), // Use the passed itemBuilder function
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
