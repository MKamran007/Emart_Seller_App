import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';

import '../widgets/text_style.dart';
import 'component/product_dropdown.dart';
import 'component/product_images.dart';
class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back,)
          ),
          title: boldText(text: "Add Products", size: 16.0,),
          actions: [
           controller.isLoader.value ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(white),),) : TextButton(onPressed: () async{
             controller.isLoader(true);
             await controller.uploadImages();
              await controller.uploadProduct(context);
              Get.back();
            }, child: normalText(text: "Save",)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(label: "eg BMW", hint: "Product Name", controller: controller.pnameController),
                10.heightBox,
                CustomTextField(label: "eg Nice Product", hint: "Description", isDesc: true, controller: controller.pdescController),
                10.heightBox,
                CustomTextField(label: "eg \$300", hint: "Price", controller: controller.ppriceController),
                10.heightBox,
                CustomTextField(label: "eg 30", hint: "Quantity", controller: controller.pquentityController),
                10.heightBox,
                productDropDown("Category", controller.categoryList, controller.categoryvalue, controller),
                10.heightBox,
                productDropDown("Subcategory", controller.subcategoryList,  controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(color: white,),
                boldText(text: "Choose Product Images",),
                10.heightBox,
                Obx(
                  ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:List.generate(3, (index) => controller.pImageList[index] != null ? Image.file(controller.pImageList[index], width: 100, height: 100, fit: BoxFit.cover,).onTap(() {
                      controller.pickImage(index, context);
                    })
                        :  productImages(label: "${index + 1}").onTap(() {
                      controller.pickImage(index, context);
                    }),),
                  ),
                ),
                10.heightBox,
                normalText(text: "First image will be your display image", color: lightGrey),
                10.heightBox,
                const Divider(color: white,),
                boldText(text: "Choose Product Colors",),
                10.heightBox,
                Obx(
                  ()=> Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(10, (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox().color(Vx.randomPrimaryColor).roundedFull.size(40, 40).make().onTap(() {
                          controller.selectedColorIndex.value = index;
                        }),
                       controller.selectedColorIndex.value == index ? const Icon(Icons.done, color: white,) : const SizedBox(),
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
