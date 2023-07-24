import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import '../widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: normalText(text: orders, color: fontGrey, size: 16.0),
        actions: [
          Center(child: normalText(text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()), color: fontGrey)),
          10.widthBox,
        ],
      ),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
            return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(white),
                  ),
                );
            }else{
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                     return ListTile(
                      onTap: (){
                        Get.to(()=> OrderDetails(
                          data: data[index],
                        ));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: boldText(text: "${data[index]['order_code']}", color: fontGrey),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, color: fontGrey,),
                              10.widthBox,
                              boldText(text: intl.DateFormat().add_yMd().format(time), color: fontGrey)
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.payment, color: fontGrey,),
                              10.widthBox,
                              boldText(text: unpaid, color: red)
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(text: "\$ ${data[index]['total_amount']}", color: purpleColor, size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();}),
                  ),
                ),
              );
             }
            }
      ),);
  }
}
