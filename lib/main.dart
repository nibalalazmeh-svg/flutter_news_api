

import 'package:difficult_app/model.dart';
import 'package:difficult_app/service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<ArticalModel> articalBookmark = [];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int indexofpages = 0;

  final List<Widget> pages = [
    pageOne(),
    pagethree(),
    pageOne(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: 400,
          color:  Color.fromARGB(255, 249, 218, 218).withOpacity(0.2),
          child: Column(
            children: [
              Expanded(
                child: pages[indexofpages],
              ),
              NavigationBar(
               backgroundColor: const Color.fromARGB(255, 249, 218, 218).withOpacity(0.2),
             indicatorColor: const Color.fromARGB(255, 81, 90, 95),
          
                selectedIndex: indexofpages,
                onDestinationSelected: (value) {
                  setState(() {
                     indexofpages = value;
                  });
                },
                
                destinations:  [
                
                  NavigationDestination( icon: Row(
    mainAxisSize: MainAxisSize.min,
    children:  [
      Container(
       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        constraints: const BoxConstraints(minWidth: 50),
        
        
        child: Icon(Icons.explore)),
      if(indexofpages==0)
    const SizedBox(width: 6),
       if(indexofpages==0)
       const Text("Explore",style: TextStyle(color: Colors.white,fontSize: 10),),
    ],
  ),
  label: "    ", 
),
                  NavigationDestination(icon: Row(
    mainAxisSize: MainAxisSize.min,
    children:  [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: const BoxConstraints(minWidth: 50),
        
        
        child: Icon(Icons.bookmark_outline)),
      if(indexofpages==1)
const SizedBox(width: 6),
if(indexofpages==1)
      Text("BookMark",style: TextStyle(color: Colors.white),),
    ],
  ),
  label: "     ",),
                  NavigationDestination(icon: Row(
    mainAxisSize: MainAxisSize.min,
    children:  [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: const BoxConstraints(minWidth: 50),
        
        
        child: Icon(Icons.home_outlined)),
      if(indexofpages==2)
      SizedBox(width: 6),
      if(indexofpages==2)
      Text("Home",style: TextStyle(color: Colors.white),),
    ],
  ),
  label: "    ",),
  NavigationDestination(icon: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: const BoxConstraints(minWidth: 50),
        
        
        child: Icon(Icons.person_outline)),
      if(indexofpages==3)
      SizedBox(width: 6),
      if(indexofpages==3)
      Text("Profile",style: TextStyle(color: Colors.white),),
    ],
  ),
  label: "    ",),
                ],
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

NewsService service = NewsService();
TextEditingController title = TextEditingController(text: "Explore");
TextEditingController title2 = TextEditingController(text: "BookMark");

class pageOne extends StatefulWidget {
  pageOne({super.key});

  @override
  State<pageOne> createState() => page1();
}

class page1 extends State<pageOne> {
  List<ArticalModel> tempResult2 = [];

  @override
  void initState() {
    super.initState();
    tempResult2 = [...articalBookmark];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE9EEFA),
        title: TextField(
          controller: title,
          onChanged: (value) {
        
            setState(() {});
          },
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<ArticalModel>>(
        future: NewsService().getNews(title.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                final artical = snapshot.data![index];
                final isSaved = articalBookmark.contains(artical);

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            artical.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            artical.urlToImage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              artical.urlToImage,
                              errorBuilder: (context, error, stackTrace) =>
                                  const FlutterLogo(size: 60),
                            ).image,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class pagethree extends StatefulWidget {
  pagethree({super.key});

  @override
  State<pagethree> createState() => page3();
}

class page3 extends State<pagethree> {
  List<ArticalModel> tempResult = [];

  @override
  void initState() {
    super.initState();
    tempResult = [...articalBookmark];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: const Color(0xffE9EEFA),
        title: TextField(
          controller: title2,
          onChanged: (value) {
            tempResult.clear();
            for (var i = 0; i < articalBookmark.length; i++) {
              if (articalBookmark[i]
                  .title
                  .toLowerCase()
                  .contains(value.toLowerCase())) {
                tempResult.add(articalBookmark[i]);
              }
            }
            setState(() {});
          },
         style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder<List<ArticalModel>>(
  
        future: NewsService().getNews(title2.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                final artical = snapshot.data![index];
                final isSaved = articalBookmark.contains(artical);

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            artical.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            artical.urlToImage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              artical.urlToImage,
                              errorBuilder: (context, error, stackTrace) =>
                                  const FlutterLogo(size: 60),
                            ).image,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isSaved) {
                            articalBookmark.remove(artical);
                          } else {
                            articalBookmark.add(artical);
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          isSaved
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: isSaved
                              ? const Color.fromARGB(255, 49, 52, 53)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}







