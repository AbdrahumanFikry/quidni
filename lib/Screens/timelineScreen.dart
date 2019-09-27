import 'package:provider/provider.dart';
import '../widgets/shareItem.dart';
import 'package:flutter/material.dart';
import '../widgets/posts.dart';
import '../providers/itemsProvider.dart';

class TimeLineScreen extends StatefulWidget {
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Items>(context).fetchData(false).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Items>(context).items;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Qaidny',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.tune,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                ShareItem(
                    user: 'user', image: 'https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Post(
                          id: posts[index].id,
                          account: 'user',
                          date: posts[index].date,
                          image: posts[index].image,
                          desc: posts[index].description,
                          check: false,
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
