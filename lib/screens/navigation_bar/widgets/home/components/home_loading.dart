import 'package:flutter/material.dart';

import '../../../../../core/assets/images/images.dart';


class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
        child: ListView.builder(
          itemCount: 1,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade400,
                        backgroundImage: NetworkImage(Images.profileImage),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              width: width / 1.7,
                              height: height / 30,
                              child: const Text(
                                "whats app user",
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black12),
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              width: width / 1.7,
                              height: height / 40,
                              child: const Text(
                                "Hello my friend",
                                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black12),
                              )),
                        ],
                      ),
                      // SizedBox(width: w * .3,),
                      Container(
                          alignment: Alignment.centerRight,
                          width: width * .2,)
                    ],
                  ),
                ),
              ),
    );
  }
}
