import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/chat_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/text_style.dart';
import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: darkGrey)
        ),
        title: boldText(text: "${controller.senderName}", size: 16.0, color: fontGrey),
      ),
      body: Column(
        children: [
          Expanded(child: StreamBuilder(
            stream: StoreServices.getChatMessages(controller.chatDocId.toString()),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }else if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: "Send a message.....".text.color(fontGrey).make(),
                );
              }else{
                return  ListView(
                  children: snapshot.data!.docs.mapIndexed((currentValue, index){
                    var data = snapshot.data!.docs[index];
                    return Align(
                        alignment: data['uid']== currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                        child: chatBubble(data));
                  }).toList(),
                );
              }
            },
          )),
          10.heightBox,
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Enter Message",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: purpleColor)
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor)
                    ),
                  ),
                )),
                IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: purpleColor,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
