import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project3/theme.dart';
import 'package:project3/widget/call_view.dart';
import 'package:project3/widget/camera_view.dart';
import 'package:project3/widget/chat_view.dart';
import 'package:project3/widget/status_view.dart';

class WhatsAppPage extends StatefulWidget {
  const WhatsAppPage({super.key});

  @override
  State<WhatsAppPage> createState() => _WhatsAppPageState();
}

class _WhatsAppPageState extends State<WhatsAppPage>
    with SingleTickerProviderStateMixin {
  final tabs = const [
    Tab(
      icon: Icon(Icons.camera_alt_outlined, size: 22),
    ),
    Tab(
      child: Text(
        "CHAT",
        style: TextStyle(fontSize: 12),
      ),
    ),
    Tab(
      child: Text(
        "STATUS",
        style: TextStyle(fontSize: 12),
      ),
    ),
    Tab(
      child: Text(
        "CALLS",
        style: TextStyle(fontSize: 12),
      ),
    ),
  ];
  TabController? tabController;
  var fabIcon = Icons.message_rounded;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController?.index = 1;
    tabController?.addListener(() {
      setState(() {
        switch (tabController?.index) {
          case 0:
            fabIcon = Icons.camera_alt_rounded;
            break;
          case 1:
            fabIcon = Icons.message_rounded;
            break;
          case 2:
            fabIcon = Icons.camera_alt_outlined;
            break;
          case 3:
            fabIcon = Icons.call;
            break;
          default:
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp"),
        backgroundColor: WhatsAppGreen,
        // backgroundColor: const Color(0xFF008069),
        actions: <Widget>[
          new Icon(Icons.search),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
          new PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    const PopupMenuItem(
                        value: "Newgroup", child: Text("New group")),
                    PopupMenuItem(
                      value: "New broadcast",
                      child: Text("New broadcast"),
                    ),
                    PopupMenuItem(
                      value: "Linked devices",
                      child: Text("Linked devices"),
                    ),
                    PopupMenuItem(
                      value: "Starred messages",
                      child: Text("Starred message"),
                    ),
                    PopupMenuItem(
                      value: "Setting",
                      child: Text("Setting"),
                    )
                  ])
        ],
        bottom: TabBar(
          tabs: tabs,
          controller: tabController,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          CameraWidget(), 
          ChatView(), 
          StatusView(), 
          CallView()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: WhatsAppLightGreen,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const Icon(Icons.message_rounded),
      ),
    );
  }
}
