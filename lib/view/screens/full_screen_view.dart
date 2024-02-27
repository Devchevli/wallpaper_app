import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenView extends StatelessWidget {
  String imgSrc;

  FullScreenView({super.key, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imgSrc), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: InkWell(
                onTap: (){
                  AsyncWallpaper.setWallpaper(url: imgSrc,
                    errorToastDetails: ToastDetails.error(),
                    goToHome: true,
                    wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
                    toastDetails: ToastDetails.success(),
                  );

                },
                child: GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              AsyncWallpaper.setWallpaper(url: imgSrc,
                                errorToastDetails: ToastDetails.error(),
                                goToHome: true,
                                wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                                toastDetails: ToastDetails.success(),
                              );
                            },
                            child: Text('Home Screen'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              AsyncWallpaper.setWallpaper(url: imgSrc,
                                errorToastDetails: ToastDetails.error(),
                                goToHome: true,
                                wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
                                toastDetails: ToastDetails.success(),
                              );
                            },
                            child: Text('Lock Screen'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              AsyncWallpaper.setWallpaper(url: imgSrc,
                                errorToastDetails: ToastDetails.error(),
                                goToHome: true,
                                wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
                                toastDetails: ToastDetails.success(),
                              );
                            },
                            child: Text('Both Screen'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Set Wallpaper",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
