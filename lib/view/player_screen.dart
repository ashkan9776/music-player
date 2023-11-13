import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/player_controller.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 175, 175, 175),
                        offset: Offset(10, 10),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(255, 202, 202, 202),
                        offset: Offset(10, 10),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: QueryArtworkWidget(
                    quality: 100,
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      size: 100,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: 'lalezar',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: 'lalezar',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => Row(
                          children: [
                            Text(controller.position.value),
                            Expanded(
                              child: Slider(
                                thumbColor: Colors.black,
                                inactiveColor: Colors.grey,
                                activeColor: Colors.black,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller
                                      .changeDurationToSecond(newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(controller.duration.value),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NeumorphicButton(
                            onTap: () {
                              controller.playSong(
                                  data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1);
                            },
                            borderRadius: 50,
                            bottomRightShadowBlurRadius: 15,
                            bottomRightShadowSpreadRadius: 1,
                            borderWidth: 5,
                            backgroundColor: Colors.grey.shade300,
                            topLeftShadowBlurRadius: 15,
                            topLeftShadowSpreadRadius: 1,
                            topLeftShadowColor: Colors.white,
                            bottomRightShadowColor: Colors.grey.shade500,
                            height: MediaQuery.of(context).size.height * 0.065,
                            width: MediaQuery.of(context).size.width * 0.14,
                            padding: const EdgeInsets.all(2),
                            bottomRightOffset: const Offset(4, 4),
                            topLeftOffset: const Offset(-4, -4),
                            child: const Icon(Icons.skip_previous_rounded,
                                size: 30, color: Colors.black87),
                          ),
                          Obx(
                            () => NeumorphicButton(
                              onTap: () {
                                if (controller.isPlaying.value) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  controller.audioPlayer.play();
                                  controller.isPlaying(true);
                                }
                              },
                              borderRadius: 50,
                              bottomRightShadowBlurRadius: 15,
                              bottomRightShadowSpreadRadius: 1,
                              borderWidth: 5,
                              backgroundColor: Colors.grey.shade300,
                              topLeftShadowBlurRadius: 15,
                              topLeftShadowSpreadRadius: 1,
                              topLeftShadowColor: Colors.white,
                              bottomRightShadowColor: Colors.grey.shade500,
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: const EdgeInsets.all(2),
                              bottomRightOffset: const Offset(4, 4),
                              topLeftOffset: const Offset(-4, -4),
                              child: Center(
                                child: controller.isPlaying.value
                                    ? const Icon(
                                        size: 50,
                                        Icons.pause,
                                        color: Color.fromARGB(255, 64, 64, 64),
                                      )
                                    : const Icon(
                                        size: 50,
                                        Icons.play_arrow_rounded,
                                        color: Color.fromARGB(255, 64, 64, 64),
                                      ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            onTap: () {
                              controller.playSong(
                                data[controller.playIndex.value + 1].uri,
                                controller.playIndex.value + 1,
                              );
                            },
                            borderRadius: 50,
                            bottomRightShadowBlurRadius: 15,
                            bottomRightShadowSpreadRadius: 1,
                            borderWidth: 5,
                            backgroundColor: Colors.grey.shade300,
                            topLeftShadowBlurRadius: 15,
                            topLeftShadowSpreadRadius: 1,
                            topLeftShadowColor: Colors.white,
                            bottomRightShadowColor: Colors.grey.shade500,
                            height: MediaQuery.of(context).size.height * 0.065,
                            width: MediaQuery.of(context).size.width * 0.14,
                            padding: const EdgeInsets.all(2),
                            bottomRightOffset: const Offset(4, 4),
                            topLeftOffset: const Offset(-4, -4),
                            child: const Icon(
                              Icons.skip_next_rounded,
                              size: 30,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
