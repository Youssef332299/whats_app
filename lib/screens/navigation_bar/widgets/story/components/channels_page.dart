import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../core/text/text_style.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage ({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    return Column(
      children: [
        const Divider(
          thickness: 1,
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(text: "Channels", size: 20),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 28,
                  )),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: w / 22,
            ),
            Text(
              "Stay updated on topics that matter to you. find\nchannels to follow bellow",
              style:
              TextStyle(fontSize: 15, color: Colors.grey.shade400),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 20, bottom: 20),
          child: SizedBox(
            width: double.infinity,
            height: h / 5.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      width: w / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                          Border.all(color: Colors.grey.shade300)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: messageColor,
                            // backgroundImage: AssetImage(Images.splashLight,),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 2,
                                  top: 43,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: isDarkMode
                                        ? Coloors.backgroundDark
                                        : Colors.white,
                                    child: const Icon(
                                      Icons.verified,
                                      color: messageColor,
                                      size: 24,
                                      weight: 20,
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //     right: 0,
                                //     top: 41,
                                //     child: Icon(
                                //       Icons.verified,
                                //       color: green,
                                //       size: 24,
                                //       weight: 20,
                                //     )),
                              ],
                            ),
                          ),
                          Text(
                            "WhatsApp",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade400,
                                fontSize: 15),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              height: 25,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.greenAccent.shade100),
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: const Text(
                                "Follow",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: messageColor,
                                    fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 15,),
            InkWell(
              onTap: (){},
              child: Container(
                height: 41,
                width: 135,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: messageColor),
                child: const Text(
                  "Explore more",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
