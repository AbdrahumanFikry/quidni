import 'package:demo/providers/item.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/itemsProvider.dart';
import '../providers/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShareItemScreen extends StatefulWidget {
  @override
  _ShareItemScreenState createState() => _ShareItemScreenState();
}

class _ShareItemScreenState extends State<ShareItemScreen> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final _descFocus = FocusNode();
  bool isLoading = false;
  String image;
  File _storedImage;
  String dropdownValue = 'Clothes';
  List<String> items = <String>[
    'Clothes',
    'Mobile & Tablet',
    'Electronics',
    'Games',
    'Cars',
    'Tools',
    'Home',
    'Books'
  ];

  @override
  void dispose() {
    _descFocus.dispose();
    super.dispose();
  }

  var _editedItem = Item(
      id: 'c1',
      catId: 'Clothes',
      title: '',
      description: '',
      image:
          'https://image.shutterstock.com/image-vector/shopping-cart-icon-flat-design-260nw-570153007.jpg',
      date: '',
      userId: '');

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text('Take from camera'),
                  textColor: Theme.of(context).accentColor,
                  onPressed: _takePicture,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.photo),
                  label: Text('Choose from gallery'),
                  textColor: Theme.of(context).accentColor,
                  onPressed: _choosePicture,
                ),
              ],
            ),
          );
        });
  }

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = imageFile;
    });
  }

  Future<void> _choosePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = imageFile;
    });
//    uploadImage();
  }

  Future<void> _saveForm() async {
    setState(() {
      isLoading = true;
    });
    _formState.currentState.save();
    uploadImage();
    try {
      await Provider.of<Items>(context).addItem(_editedItem,dropdownValue);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong check internet connection'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'))
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  Future<Null> uploadImage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('${user.email}/${user.email}_profilePicture.jpg');
    final StorageUploadTask task = ref.putFile(_storedImage);
    final downloadUrl = (await task.onComplete).ref.getDownloadURL();
    image = downloadUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context).userId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Share Item',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).accentColor),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formState,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_descFocus),
                      onSaved: (val) {
                        _editedItem = Item(
                            id: _editedItem.id,
                            catId: _editedItem.catId,
                            title: val,
                            description: _editedItem.description,
                            image: _editedItem.image,
                            date: DateTime.now().toString(),
                            userId: auth);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.newline,
                      maxLines: 5,
                      focusNode: _descFocus,
                      onSaved: (val) {
                        _editedItem = Item(
                            id: _editedItem.id,
                            catId: _editedItem.catId,
                            title: _editedItem.title,
                            description: val,
                            image: _editedItem.image,
                            userId: _editedItem.userId,
                            date: DateTime.now().toString());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Choose the category ...',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        _editedItem = Item(
                            id: _editedItem.id,
                            catId: newValue,
                            title: _editedItem.title,
                            description: _editedItem.description,
                            image: _editedItem.image,
                            userId: _editedItem.userId,
                            date: DateTime.now().toString());
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: _storedImage != null
                                ? Image.file(
                                    _storedImage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Text(
                                    'No Image Taken',
                                    textAlign: TextAlign.center,
                                  ),
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: FlatButton.icon(
                              icon: Icon(Icons.add),
                              label: Text('add image'),
                              textColor: Theme.of(context).primaryColor,
                              onPressed: _showModalSheet,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: _saveForm,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
