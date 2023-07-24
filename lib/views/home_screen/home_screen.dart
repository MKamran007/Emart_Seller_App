import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/dashboard_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: normalText(text: dashboard, color: fontGrey, size: 16.0),
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
              data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardButtoon(context, title: products, count: "${data.length}", icon: icProduct),
                        DashboardButtoon(context, title: orders, count: "60", icon: icOrder),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardButtoon(context, title: rating, count: "77", icon: icStar),
                        DashboardButtoon(context, title: totalSales, count: "60", icon: icOrder),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    10.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(data.length, (index) => data[index]['p_wishlist'] == 0 ? const SizedBox() : ListTile(
                        onTap: (){
                          Get.to(()=>ProductDetails(
                            data: data[index],
                          ));
                        },
                        leading: Image.network(data[index]['p_image'][0], width: 100, height: 100, fit: BoxFit.cover,),
                        title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                        subtitle: normalText(text: "\$${data[index]['p_price']}", color: darkGrey),
                      )),
                    )
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}
