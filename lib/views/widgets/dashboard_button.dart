import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/text_style.dart';

Widget DashboardButtoon(context, {title, count, icon}){
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          boldText(text: title, size: 16.0),
          boldText(text: count, size: 20.0),
        ],
      )),
      Image.asset(icon, width: 40, color: white,),
    ],
  ).box.rounded.color(purpleColor).size(size.width * 0.4, 80).padding(const EdgeInsets.all(8)).make();
}