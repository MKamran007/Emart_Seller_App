import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/edit_product.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/text_style.dart';
import 'add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      backgroundColor: white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
          onPressed: () async{
          await controller.getCategories();
          controller.populateCategoriesList();
          Get.to(()=>const AddProduct());
          },
          child: const Icon(Icons.add)
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: normalText(text: products, color: fontGrey, size: 16.0),
        actions: [
          Center(child: normalText(text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()), color: fontGrey)),
          10.widthBox,
        ],
      ),
      body: StreamBuilder(
        stream: StoreServices.getProduct(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(white),
                ),
              );
            }else{
              var data = snapshot.data!.docs;
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      return Card(
                      child: ListTile(
                        onTap: (){
                          Get.to(()=> ProductDetails(
                            data: data[index],
                          ));
                        },
                        leading: Image.network(data[index]['p_image'][0], width: 100, height: 100, fit: BoxFit.cover,),
                        title: boldText(text: data[index]['p_name'], color: fontGrey),
                        subtitle: Row(
                          children: [
                            normalText(text: "\$${data[index]['p_price']}", color: darkGrey),
                            10.widthBox,
                            normalText(text: data[index]['is_featured'] == true ? "Featured" : '', color: green)
                          ],
                        ),
                        trailing: VxPopupMenu(
                            arrowSize: 0.0,
                            menuBuilder: ()=> Column(
                              children: List.generate(popupMenuTitles.length, (i) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(popupMenuIcons[i],
                                      color: data[index]['featured_id'] == currentUser!.uid && i == 0 ? green : darkGrey,
                                    ),
                                    10.widthBox,
                                    normalText(text: data[index]['featured_id'] == currentUser!.uid && i == 0 ? "Remove feature" : popupMenuTitles[i], color: darkGrey)
                                  ],
                                ).onTap(() {
                                  switch (i){
                                    case 0:
                                      if(data[index]['is_featured'] == true){
                                        controller.removeFeatured(data[index].id);
                                        VxToast.show(context, msg: "Removed");
                                      }else{
                                        controller.addFeatured(data[index].id);
                                        VxToast.show(context, msg: "Added");
                                      }
                                      break;
                                    case 1:
                                      controller.deleteProduct(data[index].id);
                                      VxToast.show(context, msg: "Product removed");
                                      break;
                                    case 2:
                                      Get.put(()=>const EditProduct());
                                      break;
                                  }
                                }),
                              )),
                            ).box.white.rounded.width(200).make(),
                            child: Icon(Icons.more_vert_rounded),
                            clickType: VxClickType.singleClick),
                      ),
                    );}),
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
