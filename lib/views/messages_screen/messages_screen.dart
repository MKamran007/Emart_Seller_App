import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: darkGrey,)
        ),
        title: boldText(text: message, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
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
                    var t= data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: (){
                        Get.to(()=> const ChatScreen(),
                        arguments: [
                          data[index]['sender_name'],
                          data[index]['fromId'],
                        ]
                        );
                      },
                      leading: const CircleAvatar(backgroundColor: purpleColor, child: Icon(Icons.person, color: white,),),
                      title: boldText(text: "${data[index]['sender_name']}", color: fontGrey),
                      subtitle: normalText(text: "${data[index]['last_msg']}", color: fontGrey),
                      trailing: normalText(text: time, color: fontGrey),
                    );
                  }),
                ),
              ),
            );
          }
          })
    );
  }
}
