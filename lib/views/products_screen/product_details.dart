import 'package:emart_seller/const/const.dart';

import '../widgets/text_style.dart';
class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: darkGrey)
        ),
        title: boldText(text: "${data['p_name']}", size: 16.0, color: fontGrey),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 300,
                itemCount: data['p_image'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['p_image'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  title and details section
                 boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}", size: 16.0, color: fontGrey),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}", color: fontGrey),
                    ],
                  ),
                  //  ratting
                  VxRating(
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    isSelectable: false,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                    stepInt: false,
                  ),
                  10.heightBox,
                  boldText(text: "\$${data['p_price']}", color: red, size: 18.0),
                   Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  boldText(text: "Colors", color: fontGrey),
                            ),
                            Row(
                              children: List.generate(
                                data['p_colors'].length,
                                      (index) =>
                                      VxBox()
                                          .size(30, 30)
                                          .margin(
                                          const EdgeInsets.symmetric(horizontal: 8))
                                          .roundedFull
                                          .color(Color(data['p_colors'][index]))
                                          .make().onTap(() {
                                      }),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        // Quantity Row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                              boldText(text: "Quantity", color: fontGrey),
                            ),
                            normalText(text: "${data['p_quentity']}", color: fontGrey),
                          ],
                        ),
                      ],
                    ).box.white.padding(const EdgeInsets.all(8)).shadowSm.make(),
                  const Divider(),
                  20.heightBox,
                  //////Descriptions
                  boldText(text: "Descriptions", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: fontGrey),
                  10.heightBox,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
