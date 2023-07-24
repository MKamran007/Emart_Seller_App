import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/views/widgets/text_style.dart';

Widget productDropDown(hint,List<String> list, dropvalue, ProductsController controller){
  return Obx(
    ()=> DropdownButtonHideUnderline(
        child: DropdownButton(
          value: dropvalue.value == '' ? null : dropvalue.value,
          hint: normalText(text: "$hint", color: fontGrey),
          isExpanded: true,
          items: list.map((e){
            return DropdownMenuItem(
                child: e.toString().text.make(),
              value: e,
            );
          }).toList(),
          onChanged: (newValue){
            if(hint == "Category"){
              controller.subcategoryvalue.value = '';
              controller.populateSubCategories(newValue.toString());
            }
            dropvalue.value =newValue.toString();
          },
        )
    ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}