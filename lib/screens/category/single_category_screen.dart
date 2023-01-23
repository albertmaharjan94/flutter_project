import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../viewmodels/global_ui_viewmodel.dart';
import '../../viewmodels/single_category_viewmodel.dart';

class SingleCategoryScreen extends StatelessWidget {
  const SingleCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleCategoryViewModel>(create: (_) => SingleCategoryViewModel(), child: SingleCategoryBody());
  }
}

class SingleCategoryBody extends StatefulWidget {
  const SingleCategoryBody({Key? key}) : super(key: key);

  @override
  State<SingleCategoryBody> createState() => _SingleCategoryBodyState();
}

class _SingleCategoryBodyState extends State<SingleCategoryBody> {
  late SingleCategoryViewModel _singleCategoryViewModel;
  late GlobalUIViewModel _ui;
  String? categoryId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _singleCategoryViewModel = Provider.of<SingleCategoryViewModel>(context, listen: false);
      _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
      final args = ModalRoute.of(context)!.settings.arguments.toString();
      setState(() {
        categoryId = args;
      });
      print("ARGS :: " + args);
      getData(args);
    });
    super.initState();
  }

  Future<void> getData(String categoryId) async {
    _ui.loadState(true);
    try {
      await _singleCategoryViewModel.getProductByCategory(categoryId);
    } catch (e) {
      print(e);
    }
    _ui.loadState(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleCategoryViewModel>(builder: (context, singleCategoryVM, child) {
      return SafeArea(
        child: singleCategoryVM.category == null ? Text("Please wait") :
        Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.black54,
          ),
          body: RefreshIndicator(
            onRefresh: () => getData(categoryId.toString()),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (singleCategoryVM.category != null && singleCategoryVM.category!.imageUrl!=null)
                    Stack(
                      children: [
                        Image.network(
                          singleCategoryVM.category!.imageUrl.toString(),
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.white70),
                                child: Text(
                                  singleCategoryVM.category!.categoryName.toString() ,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        ...singleCategoryVM.products.map((e) => ProductCard(e))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget ProductCard(ProductModel e) {
    return InkWell(
      onTap: () {
        // print(e.id);
        Navigator.of(context).pushNamed("/single-product", arguments: e.id);
      },
      child: Container(
        width: 250,
        child: Card(
          elevation: 5,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    e.imageUrl.toString(),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/logo.png',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  )),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.productName.toString(),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          Text(
                            "Rs. "+e.productPrice.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.green),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
