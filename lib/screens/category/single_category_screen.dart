import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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
      print(args);
      getData(args);
    });
    super.initState();
  }

  Future<void> getData(String productId) async {
    _ui.loadState(true);
    try {
      await _singleCategoryViewModel.getProductByCategory(productId);
    } catch (e) {}
    _ui.loadState(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
