import 'package:flutter/material.dart';
import 'package:mspr/Feature/Home/home.dart';
import 'package:mspr/Feature/product/list.dart';
import 'package:mspr/models/product.dart';

class MenuWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const MenuWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 65,
                height: 65,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              switch (text) {
                case "Accueil":
                  return const Home();
                case "Contact":
                  return const ProductList();
                default:
                  return const ProductList();
              }
            }))
          },
        ));
  }
}
