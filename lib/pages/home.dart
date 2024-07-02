import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart_app/pages/category_products.dart';
import '../services/database.dart';
import '../widget/support_widget.dart';

class Home extends StatefulWidget {
  final String email;
  const Home({Key? key, required this.email}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png",
  ];
  List CategoryName = ["Headphones", "Laptop", "Watch", "Tv"];

  String? name, image;

  ontheload() async {
    await getUserName();
    setState(() {});
  }

  Future<void> getUserName() async {
    DocumentSnapshot userDoc =
        await DatabaseMethods().getUserDetailsByEmail(widget.email);
    setState(() {
      name = userDoc['Name'];
      image = userDoc['Image'];
    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hey, ${name}",
                              style: AppWidget.boldTextFeildStyle(),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Products",
                          hintStyle: AppWidget.lightTextFeildStyle(),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        Row(
                          children: [
                            Text(
                              'see all',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0),
                            height: 100,
                            child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return CategoryTile(
                                  image: categories[index],
                                  name: CategoryName[index],
                                  userEmail: widget.email,
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Products',
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: CategoryName.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          image: categories[index],
                          name: CategoryName[index],
                          price: '\$100', // Replace with actual prices
                          detail:
                              'Product detail', // Replace with actual details
                          userEmail: widget.email,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String image, name, price, detail, userEmail;

  const ProductTile({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.detail,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProducts(
              category: name,
              userEmail: userEmail,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              name,
              style: AppWidget.semiboldTextFeildStyle(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Implement add to cart functionality
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name, userEmail;

  CategoryTile({
    Key? key,
    required this.image,
    required this.name,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProducts(
              category: name,
              userEmail: userEmail,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
