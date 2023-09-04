import 'package:flutter/material.dart';
import '../../../icons/custom_icons.dart';
import 'IconButtonFooter.dart';
import 'icon_footer.dart';

class FooterMobile extends StatelessWidget {
  const FooterMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const IconButtonFooter(
            iconUser: Custom.facebookicon, 
            size: 40,
          ),
          const IconButtonFooter(
            iconUser: Custom.instagramicon, 
            size: 40,
          ),
          const IconButtonFooter(
            iconUser: Custom.whatsappicon, 
            size: 40,
          ),
          const IconButtonFooter(
            iconUser: Custom.tiktokicon, 
            size: 40,
          ),
          const SizedBox(height: 20),
          Container(
            color: const Color(0xffECC9DD),
            width: double.infinity,
            height: 400,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconFooter(
                  icon: Custom.deliveryicon, 
                  descripcion: "Envíos Inmediatos"
                ),
                IconFooter(
                  icon: Custom.keyicon, 
                  descripcion: "Compra segura"
                ),
                IconFooter(
                  icon: Custom.cardicon, 
                  descripcion: "Pago en línea"
                ),
                IconFooter(
                  icon: Custom.shopicon, 
                  descripcion: "Recoge en tu tienda",
                ),

                Text(
                    "© 2023 eDreams Team - Todos los derechos reservados",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
