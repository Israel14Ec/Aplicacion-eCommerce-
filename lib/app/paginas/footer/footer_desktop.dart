import 'package:flutter/material.dart';
import '../../../icons/custom_icons.dart';
import 'IconButtonFooter.dart';
import 'icon_footer.dart';

class FooterDesktop extends StatelessWidget {
  const FooterDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButtonFooter(
                iconUser: Custom.facebookicon,
                size: 40,
              ),
              IconButtonFooter(
                iconUser: Custom.instagramicon,
                size: 40,
              ),
              IconButtonFooter(
                iconUser: Custom.whatsappicon,
                size: 40,
              ),
              IconButtonFooter(
                iconUser: Custom.tiktokicon,
                size: 40,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            color: const Color(0xffECC9DD),
            height: 200,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconFooter(
                      icon: Custom.deliveryicon,
                      descripcion: "Envíos Inmediatos",
                    ),
                    IconFooter(
                      icon: Custom.keyicon,
                      descripcion: "Compra segura",
                    ),
                    IconFooter(
                      icon: Custom.cardicon,
                      descripcion: "Pago en línea",
                    ),
                    IconFooter(
                      icon: Custom.shopicon,
                      descripcion: "Recoge en tu tienda",
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "© 2023 eDreams Team - Todos los derechos reservados",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
