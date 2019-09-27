import '../widgets/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../widgets/shareItem.dart';
import '../widgets/accountHeader.dart';
import '../providers/itemsProvider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My account',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo.shade300, Colors.indigo.shade500]),
            ),
          ),
          ListView(
            children: <Widget>[
              Header(
                user: 'user',
                image: 'https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png',
              ),
              ShareItem(user: 'user', image: 'https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png'),
              StickyHeader(
                header: new Container(
                  height: 50.0,
                  color: Theme.of(context).accentColor,
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    'Your shares',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height - 160,
                  child: FutureBuilder(
                    future: Provider.of<Items>(context, listen: false)
                        .fetchData(true),
                    builder: (context, dataSnapShot) => dataSnapShot
                                .connectionState ==
                            ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<Items>(
                            builder: (context, items, _) => ListView.builder(
                              itemCount: items.items.length,
                              itemBuilder: (context, index) {
                                return items.items.length == 0
                                    ? Center(
                                        child: Text('No posts yet'),
                                      )
                                    : Post(
                                        id: items.items[index].id,
                                        account: 'user',
                                        date:
                                            items.items[index].date.toString(),
                                        image: items.items[index].image,
                                        desc: items.items[index].description,
                                        check: true,
                                      );
                              },
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
