import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/global_ui_viewmodel.dart';
import '../../viewmodels/single_product_viewmodel.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleProductViewModel>(create: (_) => SingleProductViewModel(), child: SingleProductBody());
  }
}

class SingleProductBody extends StatefulWidget {
  const SingleProductBody({Key? key}) : super(key: key);

  @override
  State<SingleProductBody> createState() => _SingleProductBodyState();
}

class _SingleProductBodyState extends State<SingleProductBody> {
  late SingleProductViewModel _singleProductViewModel;
  late GlobalUIViewModel _ui;
  String? productId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _singleProductViewModel = Provider.of<SingleProductViewModel>(context, listen: false);
      _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
      final args = ModalRoute.of(context)!.settings.arguments.toString();
      setState(() {
        productId = args;
      });
      print(args);
      getData(args);
    });
    super.initState();
  }

  Future<void> getData(String productId) async {
    _ui.loadState(true);
    try {
      await _singleProductViewModel.getProducts(productId);
    } catch (e) {}
    _ui.loadState(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductViewModel>(builder: (context, singleProductVM, child) {
      return singleProductVM.products == null
          ? Scaffold(
              body: Container(
                child: Text("Error"),
              ),
            )
          : singleProductVM.products!.id == null
              ? Scaffold(
                  body: Center(
                    child: Container(
                      child: Text("Please wait..."),
                    ),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black54,
                    actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],
                  ),
                  backgroundColor: Color(0xFFf5f5f4),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          singleProductVM.products!.imageUrl.toString(),
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Image.asset('assets/images/logo.png',
                              height: 400,
                              width: double.infinity,
                              fit: BoxFit.cover,);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(color: Colors.white70),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rs. " + singleProductVM.products!.productPrice.toString(),
                                  style: TextStyle(fontSize: 30, color: Colors.green, fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  singleProductVM.products!.productName.toString(),
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  singleProductVM.products!.productDescription.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
    });
  }
}
