import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mdgnews2/presentation/screens/widgets/custom_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContainer extends StatelessWidget {
  final String imgUrl;
  final String newsHead;
  final String newsDes;
  final String newsUrl;
  final String content;

  const NewsContainer(
      {Key? key,
        required this.imgUrl,
        required this.newsHead,
        required this.newsDes,
        required this.newsUrl,
        required this.content
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromRGBO(0, 32, 63, 1),
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      // height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Color.fromRGBO(15, 32, 39, 1),
            Color.fromRGBO(32, 58, 67, 1),
            Color.fromRGBO(43, 83, 100, 1),
          ],
          tileMode: TileMode.mirror,
        )
      ),
      
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                key: UniqueKey(),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  alignment:Alignment.center,
                  imageUrl: imgUrl),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              newsHead,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(172, 239, 208, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 2,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                newsDes,
              style: const TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(172, 239, 208, 1),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 14,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(172, 239, 208, 1),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const Spacer(),
          CustomButton(
              buttonName: 'Read more',
              onTapFunction: () async{
                print("Going to $newsUrl");
                if(await canLaunchUrl(Uri.parse(newsUrl))) {
                  await launchUrl(Uri.parse(newsUrl));
                }
                },
              width: 150),

          const SizedBox(height: 30,)
        ],
      ),
    );
    ;
  }
}
