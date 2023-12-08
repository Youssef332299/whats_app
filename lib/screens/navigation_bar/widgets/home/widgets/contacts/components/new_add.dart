import 'package:flutter/material.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class NewAdd extends StatelessWidget {
  const NewAdd({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return  SizedBox(
      height: h / 4.1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                const SizedBox(width: 15,),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: greenDark,
                  child: Icon(Icons.people,color: Colors.white,size: 26,),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                    width: w / 1.5,child: const Text("New group",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
              ],
            ),
          ),
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                const SizedBox(width: 15,),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: greenDark,
                  child: Icon(Icons.person_add_outlined,color: Colors.white,size: 25,),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                    width: w / 1.5,child: const Text("New contact",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
                IconButton(onPressed: (){},icon: Icon(Icons.qr_code_2,color: Colors.grey.shade400,),)
              ],
            ),
          ),
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                const SizedBox(width: 15,),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: greenDark,
                  child: Icon(Icons.groups,color: Colors.white,size: 26,),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                    width: w / 1.5,child: const Text("New community",style:
                TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 1.9),
            child: Text("Contacts on WhatsApp",style:
            TextStyle(fontWeight: FontWeight.w500, color: isDarkMode
                    ? Colors.white54
                    : Colors.grey.shade500),),
          ),
        ],
      ),
    );
  }
}
