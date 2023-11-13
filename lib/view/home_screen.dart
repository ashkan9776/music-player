import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/player_controller.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var futureMusic = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.sort_by_alpha),
                      title: const Text(
                        'By Name',
                        style: TextStyle(fontFamily: 'lalezar'),
                      ),
                      onTap: () {
                        futureMusic = false;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer_rounded),
                      title: const Text(
                        'By Adding Time',
                        style: TextStyle(fontFamily: 'lalezar'),
                      ),
                      onTap: () {
                        futureMusic = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.sort, color: Colors.black),
        ),
        title: const Text(
          "My Music",
          style: TextStyle(color: Colors.black, fontFamily: 'lalezar'),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType:
              futureMusic ? SongSortType.DATE_ADDED : SongSortType.DISPLAY_NAME,
          uriType: UriType.EXTERNAL,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Song Found",
                style: TextStyle(fontFamily: 'lalezar'),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: Colors.white,
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'lalezar'),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'lalezar'),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          quality: 100,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isPlaying.value
                            ? const Icon(Icons.play_arrow,
                                color: Colors.black, size: 26)
                            : null,
                        onTap: () {
                          controller.playSong(snapshot.data![index].uri, index);
                          Get.to(
                            () => Player(
                              data: snapshot.data!,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              ),
            );
          }
        },
      ),
    );
  }
}
