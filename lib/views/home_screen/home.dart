import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/orders_screen/orders_screen.dart';
import 'package:emart_seller/views/products_screen/product_screen.dart';
import 'package:emart_seller/views/profile_screen/profile_screen.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home, size: 28,), label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProduct, width: 24, color: darkGrey,), label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrder, width: 24, color: darkGrey,), label: orders),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSetting, width: 24, color: darkGrey,), label: setting),
    ];

    var navScreens = [const HomeScreen(), const ProductsScreen(), const OrdersScreen(), const ProfileScreen()];
    return Scaffold(
      bottomNavigationBar: Obx(
          ()=> BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
              backgroundColor: white,
            currentIndex: controller.navIndex.value,
            unselectedItemColor: darkGrey,
            items: bottomNavbar
        ),
      ),
      body: Column(
        children: [
          Obx(()=> Expanded(child: navScreens.elementAt(controller.navIndex.value))),
        ],
      )
    );
  }
}
