import 'package:application_frontend/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleWidget extends StatefulWidget {
  final ArticleModel data;
  const ArticleWidget({super.key, required this.data});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Column(children: [Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: const Color(0xFF3252B9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/thumbnail/${widget.data.category}.png")
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width-150, child: Text(
                            widget.data.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            child: Image.asset(
                              "assets/dots_vertical_icon.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.data.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.data.pubDate,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7A7C82),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: GestureDetector(
                      child: const Text(
                        "링크 복사하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )
                      ),
                      onTapDown: (_)=>{
                        Clipboard.setData(ClipboardData(text: widget.data.link)),
                        setState(() {
                          isSelected = false;
                        })
                      }
                    )
                  ),
                ),
              ),
          ]
        )
      )
    ), const SizedBox(height: 10)]),
      onTap: ()=>launchUrl(Uri.parse(widget.data.link))
    );
  }
}
