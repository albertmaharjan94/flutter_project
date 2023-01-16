import 'package:flutter/material.dart';
import 'package:n_baz/viewmodels/category_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  String productCategory = "";
  void saveProduct(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("WIP")));
  }
  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  late CategoryViewModel _categoryViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
      getInit();
    });
    super.initState();
  }

  getInit() async {
    _ui.loadState(true);
    try{
      await _categoryViewModel.getCategories();
    }catch(e){
      print(e);
    }
    _ui.loadState(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Add a product"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [

                SizedBox(height: 10,),

                TextFormField(
                  controller: _productNameController,
                  // validator: ValidateProduct.username,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    border: InputBorder.none,
                    label: Text("Product Name"),
                    hintText: 'Enter product name',
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _productPriceController,
                  // validator: ValidateProduct.username,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    border: InputBorder.none,
                    label: Text("Product Price"),
                    hintText: 'Enter product price',
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _productDescriptionController,
                  // validator: ValidateProduct.username,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    border: InputBorder.none,
                    label: Text("Product Description"),
                    hintText: 'Enter product description',
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Add Image"),
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){},
                          icon: Icon(Icons.camera))
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blue)
                            )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 10)),
                      ),
                      onPressed: (){
                        saveProduct();
                      }, child: Text("Save", style: TextStyle(
                      fontSize: 20
                  ),)),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange) ,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.orange)
                            )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 10)),
                      ),
                      onPressed: (){
                          Navigator.of(context).pop();
                      }, child: Text("Back", style: TextStyle(
                      fontSize: 20
                  ),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
