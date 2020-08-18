//import 'dart:math';
//
//import 'package:flutter/material.dart';
//import 'package:freelance_app/utils/screen_dimensions_helper.dart';
//import 'package:freelance_app/view/pages/chat/widgets.dart';
//import 'package:freelance_app/view/widgets/back_button.dart';
//
//class Chat extends StatelessWidget {
//  const Chat({Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      extendBodyBehindAppBar: true,
//      appBar: AppBar(
//        backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
//        centerTitle: false,
//        title: Text('Back'),
//        bottom: PreferredSize(
//          child: ChatActions(),
//          preferredSize: Size(Dimensions.width(100), Dimensions.height(5)),
//        ),
//        leading: CustomBackButton()
//      ),
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: ListView.builder(
//              padding:const EdgeInsets.symmetric(horizontal: 15),
//              itemCount: 10,
//              reverse: true,
//              shrinkWrap: true,
//              itemBuilder: (BuildContext context, int index) {
//                bool isSent = Random().nextBool();
//                if (isSent)
//                  return SentMessage(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Molestie est, amet, tincidunt in tristique dignissim molestie integer. Sit interdum cursus in pellentesque elit, morbi. Congue consectetur aliquet ullamcorper mauris ultricies fames.");
//                else
//                  return ReceivedMessage(message: 'Nice! Sorry for the spelling mistakes, the text was pretty old.');
//              },
//            ),
//          ),
//          SendMessageWidget()
//        ],
//      ),
//    );
//  }
//}

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:freelance_app/models/user.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/chat/widgets.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'call.dart';

import 'package:freelance_app/view/pages/chat/pickup/pickup_layout.dart';
import 'package:freelance_app/utils/call_util.dart';

var _scaffoldContext;
File _image;
bool cam = false;

class ChatScreen extends StatefulWidget {
  String recieverName, senderName;
  int recieverId, senderId;
  String image, senderImage;

//  "sender": widget.,
//  "reciever": widget.name,
//  "senderId": widget.,
//  "recieverId": widget.reciever,
//  "senderImage": widget.,

  ChatScreen(
      {this.recieverName,
      this.senderName,
      this.recieverId,
      this.senderId,
      this.image,
      this.senderImage});

  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  Map downloadedItem = {};
  var listMessage;
  bool _isComposingMessage = false;
  ScrollController listScrollController;
  String groupChatId;
  int peerId;
  int currentId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String transcription = '';
  List checkList = [];
  List downloaded = [];
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void initState() {
    //https://console.agora.io/invite?sign=
    // TODO: implement initState
    super.initState();
    _channelController.text =
        "YXBwSWQlM0Q5YTA5ZjM3NGQ3YzQ0Y2FjYTNmODU2MWYwNWIwMjgxZCUyNm5hbWUlM0RZYWh5YSUyNnRpbWVzdGFtcCUzRDE1OTM5ODM4MTglMjZjaGFubmVsJTNEZGVtbyUyNnRva2VuJTNE";
    peerId = widget.recieverId;
    currentId = widget.senderId;
    if (currentId.hashCode <= peerId.hashCode) {
      groupChatId = '$currentId-$peerId';
    } else {
      groupChatId = '$peerId-$currentId';
    }
    print(groupChatId);
  }

  ///agora
  ///
  Future<void> onJoin() async {
    print("pressed join");
    print("i'm join");
    print(_channelController.text);
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
//      await Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => CallPage(
//            channelName: _channelController.text,
//            role: _role,
//          ),
//        ),
//      );
    }
  }

  Future<bool> _handleCameraAndMic() async {
    PermissionStatus status = await Permission.microphone.request();
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (status == PermissionStatus.granted &&
        cameraStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  void _showSnackBar(message, {link}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: GestureDetector(
        child: Text(message),
      ),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
//    return new Scaffold(
//        key: _scaffoldKey,
//        appBar: new AppBar(
//          centerTitle: true,
//          title: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Container(
//                  child: ClipRRect(
//                    child: CachedNetworkImage(
//                        errorWidget: (context, url, error) => Image.asset(
//                          "assets/images/placeholder.jpg",
//                          fit: BoxFit.fill,
//                        ),
//                        placeholder: (context, url) => Image.asset(
//                          "assets/images/placeholder.jpg",
//                          fit: BoxFit.fill,
//                        ),
//                        fit: BoxFit.fill,
//                        imageUrl: widget.image),
//                    borderRadius: BorderRadius.circular(60),
//                  ),
//                  height: 40,
//                  width: 40,
//                ),
////            SizedBox(width:10),
//                FlatButton(
//                  child: Text(
//                    widget.recieverName,
//                    style:
//                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
//                  ),
//                  onPressed: () {
//
//                  },
//                  textColor: Colors.white,
//                )
//              ]),
//          elevation:
//          Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
//          actions: <Widget>[
//            Container(
//              margin: new EdgeInsets.symmetric(horizontal: 1.0),
//              child: new IconButton(
//                  icon: new Icon(
//                    Icons.photo_camera,
//                    color: Colors.white,
//                  ),
//                  onPressed: () async {
//                    _image = null;
//                    Navigator.of(context)
//                        .push(EditCoverOverlay())
//                        .whenComplete(() async {
//                      setState(() {});
//
//                      if (_image == null) {
//                        return;
//                      } else {
//                        int timestamp =
//                            new DateTime.now().millisecondsSinceEpoch;
//                        StorageReference storageReference = FirebaseStorage
//                            .instance
//                            .ref()
//                            .child("img_" + timestamp.toString() + ".jpg");
//
//                        StorageUploadTask uploadTask =
//                        storageReference.putFile(_image);
//                        var downloadUrl = await (await uploadTask.onComplete)
//                            .ref
//                            .getDownloadURL();
//
//                        onSendMessage(content: downloadUrl, type: 1);
//                      }
//                    });
//                  }),
//            ),
//          ],
////          backgroundColor: primaryColor,
//        ),
//        body: new Container(
//          child: new Column(
//            children: <Widget>[
//              Flexible(
//                child: StreamBuilder(
//                  stream: Firestore.instance
//                      .collection('messages')
//                      .document(groupChatId)
//                      .collection(groupChatId)
//                      .orderBy('timestamp', descending: true)
//                      .limit(20)
//                      .snapshots(),
//                  builder: (context, snapshot) {
//                    if (!snapshot.hasData) {
//                      return Center(
//                          child: CircularProgressIndicator(
////                              valueColor: AlwaysStoppedAnimation<Color>()
//                          ));
//                    } else {
//                      listMessage = snapshot.data.documents;
//                      return ListView.builder(
//                        padding: EdgeInsets.all(10.0),
//                        itemBuilder: (context, index) => buildItem(
//                            index,
//                            snapshot.data.documents[index],
//                            snapshot.data.documents[index].documentID,
//                            listMessage.length),
//                        itemCount: snapshot.data.documents.length,
//                        reverse: true,
//                        controller: listScrollController,
//                      );
//                    }
//                  },
//                ),
//              ),
//              new Divider(height: 1.0),
//              new Container(
//                decoration:
//                new BoxDecoration(color: Theme.of(context).cardColor),
//                child: _buildTextComposer(),
//              ),
//              new Builder(builder: (BuildContext context) {
//                _scaffoldContext = context;
//                return new Container(width: 0.0, height: 0.0);
//              })
//            ],
//          ),
//          decoration: Theme.of(context).platform == TargetPlatform.iOS
//              ? new BoxDecoration(
//              border: new Border(
//                  top: new BorderSide(
//                    color: Colors.grey[200],
//                  )))
//              : BoxDecoration(),
//        ));
    return PickupLayout(
        scaffold: Scaffold(
//      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          centerTitle: false,
          title: Text('Back'),
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      child: CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.fill,
                              ),
                          placeholder: (context, url) => Image.asset(
                                "assets/images/placeholder.png",
                                fit: BoxFit.fill,
                              ),
                          fit: BoxFit.fill,
                          imageUrl: widget.image),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.recieverName,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.videocam),
                        onPressed: () async => await _handleCameraAndMic()
                            ? CallUtils.dial(
                                from: new User(
                                  id: widget.senderId,
                                  name: widget.senderName,
                                ),
                                to: new User(
                                  id: widget.recieverId,
                                  name: widget.recieverName,
                                ),
                                context: context,
                              )
                            : {},
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            preferredSize: Size(Dimensions.width(100), Dimensions.height(5)),
          ),
          leading: CustomBackButton()),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
//                              valueColor: AlwaysStoppedAnimation<Color>()
                          ));
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => buildItem(
                        index,
                        snapshot.data.documents[index],
                        snapshot.data.documents[index].documentID,
                        listMessage.length),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
          ),
          new Divider(height: 1.0),
          _buildTextComposer()
        ],
      ),
    ));
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: primary,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              ShareMedia(
                icon: Icons.camera_alt,
                onPress: () {
                  print("camera");
                  _image = null;
                  Navigator.of(context)
                      .push(EditCoverOverlay())
                      .whenComplete(() async {
                    setState(() {});

                    if (_image == null) {
                      return;
                    } else {
                      int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      StorageReference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child("img_" + timestamp.toString() + ".jpg");

                      StorageUploadTask uploadTask =
                          storageReference.putFile(_image);
                      var downloadUrl = await (await uploadTask.onComplete)
                          .ref
                          .getDownloadURL();

                      onSendMessage(content: downloadUrl, type: 1);
                    }
                  });
                },
              ),
//              ShareMedia(
//                icon: Icons.mic,
//                onPress: () {},
//              ),
              ShareMedia(
                icon: Icons.attach_file,
                onPress: () async {
                  FlutterDocumentPickerParams params =
                      FlutterDocumentPickerParams();

                  final path =
                      await FlutterDocumentPicker.openDocument(params: params);
                  String extension = path.substring(
                    path.lastIndexOf('.') + 1,
                  );
                  print(extension);

                  int timestamp = new DateTime.now().millisecondsSinceEpoch;
                  StorageReference storageReference = FirebaseStorage.instance
                      .ref()
                      .child("file_" + timestamp.toString() + '.' + extension);
                  StorageUploadTask uploadTask =
                      storageReference.putFile(File(path));
                  var downloadUrl =
                      await (await uploadTask.onComplete).ref.getDownloadURL();

                  onSendMessage(content: downloadUrl, type: 3);
                },
              ),
              SizedBox(
                width: 10,
              ),

              Flexible(
                child: new TextField(
                  style: TextStyle(height: 1.2, color: Colors.black),
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              FlatButton(
                  onPressed: _isComposingMessage
                      ? () => _textMessageSubmitted(_textEditingController.text)
                      : null,
                  child: Text(
                    'SEND',
                    style: TextStyle(
                      color: _isComposingMessage ? primary : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
//              new Container(
//                margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                child: Theme.of(context).platform == TargetPlatform.iOS
//                    ? getIOSSendButton()
//                    : getDefaultSendButton(),
//              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    onSendMessage(content: text, type: 0);
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Container(
      margin: new EdgeInsets.symmetric(horizontal: 1.0),
      child: new IconButton(
        color: Theme.of(context).accentColor,
        onPressed: onPressed,
        icon: Icon(Icons.mic),
//        child: new Text(
//          label,
//          style: const TextStyle(color: Colors.white),
//        ),
      ));

  Widget buildItem(index, document, id, count) {
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(document['timestamp']));
    var dateString = f.format(date);
//    if (document['idFrom'] != currentId) {
//      Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .document(id)
//          .updateData({'status': 'read'});
//    }

    if (checkList.length < count) checkList.add(false);
    downloaded.add('');

    return document['type'] == 0
        // Text
        ?
//    Row(
//            mainAxisAlignment:

//            children: <Widget>[
//              Container(
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.end,
//                  children: <Widget>[
//                    Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            width: document['content'].length > 39
//                                ? MediaQuery.of(context).size.width * 0.7
//                                : null,
//                            child: Text(
//                              document['content'],
//                              style: TextStyle(
//                                color: Colors.black,
//                              ),
//                              textAlign: TextAlign.start,
//                            ),
//                          ),
//                        ]),
//                    SizedBox(
//                      width: 1.0,
//                    ),
//                    Row(
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: <Widget>[
//                          Text(
//                            dateString.toString().substring(
//                                  10,
//                                ),
//                            style:
//                                TextStyle(color: Colors.grey, fontSize: 10.0),
//                            textAlign: TextAlign.end,
//                          ),
//                          document['idFrom'] == currentId
//                              ? Icon(
//                                  Icons.check,
//                                  size: 14,
//                                  color: document['status'] == 'read'
//                                      ? Colors.blue
//                                      : Colors.grey,
//                                )
//                              : Container()
//                        ]),
//                  ],
//                ),
//                padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
//                decoration: BoxDecoration(
//                    color: document['idFrom'] == currentId
//                        ? Color.fromRGBO(218, 247, 199, 1.0)
//                        : Colors.white,
//                    borderRadius: BorderRadius.circular(8.0)),
//                margin: EdgeInsets.only(bottom: 10.0),
//              )
//            ],
//          )
        (document['idFrom'] == currentId
            ? SentMessage(message: document['content'])
            : ReceivedMessage(
                message: document['content'],
              ))
        : document['type'] == 1
            ?
            // Image
            Container(
                child: GestureDetector(
                    onTap: () {
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) =>
//                        imageViewPage(document['content'])));
                    },
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            'assets/images/placeholder.png',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fill,
                          ),
//                errorWidget:(context,url)=>
//                Icon(Icons.error),
                          imageUrl: document['content'],
                          width: 400.0,
                          height: 200.0,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
//                      Positioned(
//                          bottom: 5.0,
//                          right: 5.0,
//                          child: Text(
//                            dateString.toString().substring(10),
//                            style:
//                                TextStyle(color: Colors.grey, fontSize: 10.0),
//                          ))
                    ])),
                margin: EdgeInsets.only(
                  bottom: 10.0,
                  right: document['idFrom'] != currentId ? 50.0 : 0.0,
                  left: document['idFrom'] == currentId ? 50.0 : 0.0,
                ),
              )
            : Row(
                mainAxisAlignment: document['idFrom'] == currentId
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: <Widget>[
                    Container(
                      child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
//                          Icon(
//                            Icons.insert_drive_file,
//                            color: Colors.white,
//                          ),
                          downloadedItem.containsKey(document['content']) &&
                                  downloadedItem[document['content']] is String
                              ? IconButton(
                                  icon: Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    print(downloadedItem[document['content']]);
                                    OpenFile.open(
                                        downloadedItem[document['content']]);
                                  })
                              : downloadedItem
                                          .containsKey(document['content']) &&
                                      downloadedItem.containsKey(
                                              document['content']) ==
                                          true
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    )))
                                  : IconButton(
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        print('pressed');
//                                                                      if (downloaded[index]
//                                                                          .toString()
//                                                                          .isNotEmpty)
//                                                                        OpenFile.open(downloaded[index]);
//                                                                      else
                                        PermissionStatus status =
                                            await Permission.storage.request();
                                        if (status ==
                                            PermissionStatus.granted) {
                                          setState(() {
                                            downloadedItem[
                                                document['content']] = true;
                                          });

                                          var now = DateTime.now();

                                          http.Client client =
                                              new http.Client();
                                          var req = await client.get(
                                            Uri.parse(document['content']),
                                          );
                                          print(req.headers['content-type']
                                              .toString()
                                              .substring(req
                                                      .headers['content-type']
                                                      .lastIndexOf('/') +
                                                  1));
                                          var bytes = req.bodyBytes;
                                          Directory dir =
                                              await getApplicationDocumentsDirectory();
                                          String filePath =
                                              '${dir.path}/${now.toIso8601String()}.${req.headers['content-type'].toString().substring(req.headers['content-type'].lastIndexOf('/') + 1)}';
                                          print(filePath);
                                          File file = new File(
                                              '${dir.path}/${now.toIso8601String()}.${req.headers['content-type'].toString().substring(req.headers['content-type'].lastIndexOf('/') + 1)}');
                                          await file.writeAsBytes(bytes);
                                          setState(() {
                                            downloadedItem[
                                                document['content']] = filePath;
                                          });
                                          print(downloadedItem[
                                              document['content']]);
                                          OpenFile.open(downloadedItem[
                                              document['content']]);
                                        } else
                                          _showSnackBar(
                                              "Kindly give permissions to download");
                                      }),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            document['idFrom'] == currentId
                                ? 'File Sent'
                                : 'File Recieved',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                      width: 200.0,
                      decoration: BoxDecoration(
                          color: document['idFrom'] == currentId
                              ? primary
                              : Color.fromRGBO(165, 165, 165, 1),
                          borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                    )
                  ]);
    //Row(
    //                mainAxisAlignment: document['idFrom'] == currentId
    //                    ? MainAxisAlignment.end
    //                    : MainAxisAlignment.start,
    //                children: <Widget>[
    //                    Container(
    //                      child: Column(
    //                        children: <Widget>[
    //                          Row(
    //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                            children: <Widget>[
    //                              Text(
    //                                document['idFrom'] == currentId ? 'File Sent': 'File Recieved',
    //                                style: TextStyle(color: Colors.black),
    //                              ),
    //                              checkList[index]
    //                                  ? Center(
    //                                      child: CircularProgressIndicator(
    //                                          valueColor:
    //                                              AlwaysStoppedAnimation<Color>(
    //                                      globals.selectedColor,
    //                                    )))
    //                                  : IconButton(
    //                                      icon: Icon(
    //                                        Icons.file_download,
    //                                        color: downloaded[index]
    //                                                .toString()
    //                                                .isNotEmpty
    //                                            ? Colors.blue
    //                                            : Colors.black,
    //                                      ),
    //                                      onPressed: () {
    //                                        print('pressed');
    //                                        if (downloaded[index]
    //                                            .toString()
    //                                            .isNotEmpty)
    //                                          OpenFile.open(downloaded[index]);
    //                                        else
    //                                          setState(() {
    //                                            checkList[index] = true;
    //                                            print(index);
    //                                            print(checkList[index]);
    //                                          });
    //                                        AuthModel()
    //                                            .downloadFile(document['content'])
    //                                            .then((res) {
    //                                          print(res);
    //                                          setState(() {
    //                                            checkList[index] = false;
    //                                            if (res['status']) {
    //                                              downloaded[index] = res['link'];
    //                                            }
    //                                          });
    //                                          _showSnackBar(res['message'],
    //                                              link: res['link']);
    //                                        });
    //                                      })
    //                            ],
    //                          ),
    //                          Row(
    //                              mainAxisAlignment: MainAxisAlignment.end,
    //                              children: <Widget>[
    //                                Text(
    //                                  dateString.toString().substring(
    //                                        10,
    //                                      ),
    //                                  style: TextStyle(
    //                                      color: Colors.grey, fontSize: 10.0),
    //                                ),
    //                                document['idFrom'] == currentId
    //                                    ? Icon(
    //                                  Icons.check,
    //                                  size: 14,
    //                                  color: document['status'] == 'read'
    //                                      ? Colors.blue
    //                                      : Colors.grey,
    //                                )
    //                                    : Container()
    //                              ]),
    //                        ],
    //                      ),
  }

  void onSendMessage({String content, int type}) async {
    // type: 0 = text, 1 = image, 2 = file
    if (content.trim() != '') {
      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': currentId,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type,
            "status": "unread"
          },
        );
      });
      await Firestore.instance
          .collection("messages")
          .document(groupChatId)
          .setData({
        "sender": widget.senderName,
        "reciever": widget.recieverName,
        "senderId": widget.senderId,
        "recieverId": widget.recieverId,
        "senderImage": widget.senderImage,
        "recieverImage": widget.image,
        "time": DateTime.now().toString(),
        "last": type == 0 ? content : "Sent an attachment"
      });
    } else {}
  }
}

class EditCoverOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          height: 240.0,
          margin: EdgeInsets.all(10),
//          padding: EdgeInsets.only(bottom: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0))),
                child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            'Choose media',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          alignment: AlignmentDirectional.centerEnd,
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.camera);

                          _image = image;
                          setState(() {
                            _image = image;
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            child: Icon(
                              Icons.camera_alt,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);

                          _image = image;
                          setState(() {
                            _image = image;
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            child: Icon(
                              Icons.image,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
