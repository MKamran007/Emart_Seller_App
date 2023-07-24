import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/auth_countroller.dart';
import 'package:emart_seller/views/widgets/text_style.dart';

import '../home_screen/home.dart';
import '../widgets/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: purpleColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(icLogo, width: 70, height: 70,).box.border(color: white).rounded.padding(const EdgeInsets.all(8.0)).make(),
                 10.widthBox,
                  boldText(text: appname, size: 20.0),
                ],
              ),
              40.heightBox,
              normalText(text: loginTo, size: 18.0, color: lightGrey),
              10.heightBox,
              Obx(
                ()=> Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: purpleColor,),
                        filled: true,
                        fillColor: textfieldGrey,
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    20.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: purpleColor,),
                        filled: true,
                        fillColor: textfieldGrey,
                        border: InputBorder.none,
                        hintText: passwordHint,
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword, color: purpleColor))),
                    20.heightBox,
                    SizedBox(
                    width: context.screenWidth - 100,
                      child: controller.isloading.value? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(purpleColor),
                        ),): OurButton(
                        title: login,
                        onPress: () async{
                          controller.isloading(true);
                          await controller.loginMethod(context: context).then((value){
                            if(value != null){
                              VxToast.show(context, msg: "Logged in");
                              controller.isloading(false);
                              Get.offAll(()=>const Home());
                            }else{
                              controller.isloading(false);
                            }
                          });
                        }
                      ),
                    ),
                  ],
                ).box.white.outerShadowMd.rounded.padding(const EdgeInsets.all(8.0)).make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey),),
              const Spacer(),
              Center(child: boldText(text: credit),),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
