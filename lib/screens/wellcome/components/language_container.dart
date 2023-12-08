import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:whats_app/core/colors/app_colors.dart';

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({super.key});


  showBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'App Language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: .5,
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                // activeColor: Coloors.greenDark,
                title: const Text('English'),
                subtitle: const Text(
                  "(Phone's language)",
                  style: TextStyle(
                    // color: context.theme.greyColor,
                  ),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                // activeColor: Coloors.greenDark,
                title: const Text('العربية'),
                subtitle: const Text(
                  "(Phone's language)",
                  style: TextStyle(
                  ),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                // activeColor: Coloors.greenDark,
                title: const Text('አማርኛ'),
                subtitle: const Text(
                  "Amharic",
                  style: TextStyle(
                  ),
                ),
              ),
            ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;

    return Center(
      child: GestureDetector(
        onTap: (){
          showBottomSheet(context);
        },
        child: Container(
          width: w / 2.9,
          height: 35,
          decoration: BoxDecoration(
            color: isDarkMode
            ? appBarColor
            : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.panorama_photosphere,size: 20,color: messageColor,),
              Text("English",style: TextStyle(color: messageColor),),
              Icon(Iconsax.arrow_down_14,size: 20,color: messageColor,),
            ],
          ),
        ),
      ),
    );
  }
}
