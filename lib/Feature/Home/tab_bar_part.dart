import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mspr/Core/sharedPref.dart';
import 'package:mspr/models/user.dart';

class TabBarPart extends StatelessWidget {
  const TabBarPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    SharedPref sharedPref = SharedPref();
    // User currentUser = User.fromMap(sharedPref.read("currentUser") as Map);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: buidBar(),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder(
              // Discussion tab
              future: sharedPref.read("currentUser"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    User usr = User.fromMap(snapshot.data!);
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "COMPTE",
                          ),
                          const SizedBox(height: 10.0),
                          Card(
                            elevation: 0.5,
                            margin: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 0,
                            ),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  child: ProfileListItem(
                                    icon: Icons.verified_user,
                                    text: "Nom : ${usr.name}",
                                  ),
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordChange()));
                                  },
                                ),
                                _buildDivider(),
                                InkWell(
                                  child: ProfileListItem(
                                    icon: Icons.email,
                                    text: 'Email : ${usr.email}',
                                    hasNavigated: false,
                                  ),
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationList()));
                                  },
                                ),
                                /*_buildDivider(),
                                InkWell(
                                  child: const ProfileListItem(
                                    icon: LineAwesomeIcons.wallet,
                                    text: 'Mon porte feuille',
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Wallet()));
                                  },
                                ),
                                /*SwitchListTile(
                      activeColor: AppColor.primary,
                      value: true,
                      title: Text("Private Account"),
                      onChanged: (val) {},
                    ),*/
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "NOTIFICATIONS",
                            style: headerStyle,
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 0,
                            ),
                            child: Column(
                              children: <Widget>[
                                SwitchListTile(
                                  activeColor: AppColor.purple,
                                  value: true,
                                  title: const Text(
                                    "Notifications reçu",
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                  ),
                                  onChanged: (val) {},
                                ),
                                _buildDivider(),
                                const SwitchListTile(
                                  activeColor: AppColor.purple,
                                  value: false,
                                  title: Text(
                                    "Nouvelles newsletter",
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                  ),
                                  onChanged: null,
                                ),
                                _buildDivider(),
                                SwitchListTile(
                                  activeColor: AppColor.purple,
                                  value: true,
                                  title: const Text(
                                    "Nos offres",
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                  ),
                                  onChanged: (val) {},
                                ),
                                _buildDivider(),
                                const SwitchListTile(
                                  activeColor: AppColor.purple,
                                  value: true,
                                  title: Text(
                                    "Nouvelles mise à jour",
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                  ),
                                  onChanged: null,
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {}
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
            FutureBuilder(
              // BEGIN TAB FOR CITY CHAT
              future: sharedPref.read("currentUser"),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.hasData) {
                  return Expanded(
                      child: Center(
                    child: OutlinedButton(
                      child: const Text('One'),
                      onPressed: () {
                        DefaultTabController.of(context).animateTo(0);
                      },
                    ),
                  ));
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }

  PreferredSizeWidget? buidBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: SafeArea(
        child: Column(
          children: const <Widget>[
            TabBar(labelColor: Colors.black, tabs: [
              Tab(text: 'Informations'),
              Tab(text: 'Mes commandes'),
            ]),
          ],
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final bool hasNavigated;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text = "",
    this.hasNavigated = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
        color: Colors.white10,
      ),
      child: Row(children: <Widget>[
        Icon(
          icon,
          size: 25,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        const Spacer(),
        if (hasNavigated)
          const Icon(
            Icons.arrow_right,
            size: 20,
          ),
      ]),
    );
  }
}
