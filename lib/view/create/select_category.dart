import 'package:bizhub_new/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/app_bar.dart';
import 'component/category_item.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllData();
    });
    super.initState();
  }

  getAllData() {
    final categories = Provider.of<CategoryViewModel>(context, listen: false);
    categories.getCategoriesList(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final category = Provider.of<CategoryViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: myAppBar(context: context, appBarTitle: 'Select Category'),
      bottomSheet: category.categoryId.isNotEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: size.height * 0.10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                    child: DeafultButton(
                      title: 'Continue',
                      onPress: () {
                        Navigator.pushNamed(context, RouteName.createPost);
                      },
                      // onPress: null,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      // body: categoryItem(size: size),
      body: Consumer<CategoryViewModel>(
        builder: (context, categoryViewModel, _) {
          if (categoryViewModel.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final category = categoryViewModel.categoryList;
            return GridView(
              padding: const EdgeInsets.only(
                bottom: 100,
                top: 20,
                left: 10,
                right: 10,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: List.generate(
                category.length,
                (index) {
                  return CategoryItem(category: category[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}