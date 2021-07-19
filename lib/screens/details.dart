import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String img;
  final String name;
  final String description;
  final String price;
  final String type;

  const DetailScreen(
      {Key key, this.img, this.name, this.description, this.price, this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: "Image",
            child: Center(
              child: Image.network(
                img,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            height: size.height * 0.583,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.49,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            "Type: ${type}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: size.height * 0.065,
                                  width: size.width * 0.28,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.2),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "2",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      GestureDetector(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.2),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "\$ ${price}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: size.height * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.yellow.shade800,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "Add to Cart",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
