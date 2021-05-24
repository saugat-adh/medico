import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class AppointmentSwiper extends StatelessWidget {
  const AppointmentSwiper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF0F2F8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.28,
      //padding: EdgeInsets.only(bottom: 50),
      child: Swiper(
          itemCount: 1,
          itemWidth: MediaQuery.of(context).size.width - 0.3 * 130,
          layout: SwiperLayout.STACK,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                //
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      //shadowColor: Colors.black12,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      color: Color(0xFF4A3298),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(foregroundColor: Colors.white, backgroundColor: Colors.white, radius: 40,),
                                SizedBox(width: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name', style: TextStyle(color: Colors.white,fontSize: 30),),
                                    Text('Speciality', style: TextStyle(color: Colors.white,fontSize: 20),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
