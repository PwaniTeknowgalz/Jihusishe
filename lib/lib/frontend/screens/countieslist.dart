import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jihusishe/lib/frontend/screens/policeofficers.dart';
import 'package:jihusishe/lib/utils/app_constants.dart';

class CountiesList extends StatelessWidget {
  const CountiesList({Key? key}) : super(key: key);
  static const countylist = [
    "Mombasa","Kwale","Kilifi","Tana River","Lamu", "Taita Taveta","Garissa","Wajir","Mandera","Marsabit",
    "Isiolo", "Meru","Tharaka-Nithi","Embu","Kitui","Machakos","Makueni","Nyandarua","Nyeri","Kirinyaga",
    "Murang/’a","Kiambu","Turkana","West Pokot","Samburu","Trans-Nzoia","Uasin Gishu","Elgeyo-Marakwet","Nandi",
    "Baringo","Laikipia","Nakuru","Narok","Kajiado","Kericho","Bomet","Kakamega","Vihiga","Bungoma",
    "Busia","Siaya","Kisumu","Homa Bay","Migori","Kisii","Nyamira","Nairobi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(children: [
          //Header
          Container(
            height: 94,
            width: Get.width,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(30),
              //     bottomRight: Radius.circular(30)),
              color: Color.fromRGBO(22, 29, 64, 1),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select your county",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    
                    ],
                  ),
                ),
                
                IconButton(
                    onPressed: () {
                    
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                //SizedBox(width: Get.width * .25),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239)),

                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Get.to(()=>Police()),
                    title: Text(countylist[index]),
                  );
                },
                itemCount: countylist.length),
          )
        ]),
      ),
    );
  }
}
