import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Category_Block.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(FetchCategoriesEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Category and Subcategory App'),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoadedState) {
            final categories = state.categories;
            // Implement your UI to display categories and subcategories here
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // Build your category and subcategory widgets here
                return ListTile(
                  title: Text(categories[index]['category_name']),
                  // Add logic to display subcategories if available
                );
              },
            );
          } else if (state is CategoryErrorState) {
            return Center(child: Text(state.error));
          } else {
            return Container(); // Handle other states if needed
          }
        },
      ),
    );
  }
}