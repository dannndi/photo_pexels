import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:photo_pexels/data/constans/status_download.dart';
import 'package:photo_pexels/module/detail_photo/bloc/detail_photo_cubit.dart';
import 'package:photo_pexels/routes/page_name.dart';
import 'package:photo_pexels/widgets/dialog_widgets.dart';

class DetailPhotoView extends StatelessWidget {
  const DetailPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: BlocConsumer<DetailPhotoCubit, DetailPhotoState>(
        listenWhen: (previous, current) {
          return previous.statusDownload != current.statusDownload ||
              previous.statusShare != current.statusShare;
        },
        listener: (context, state) {
          if (state.statusShare == StatusDownload.downloading) {
            showDialogLoading(context);
          }

          if (state.statusShare == StatusDownload.success ||
              state.statusShare == StatusDownload.failed) {
            Navigator.pop(context);
          }

          if (state.statusDownload == StatusDownload.downloading) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            showBannerProgress(
              context,
              color: Colors.blueGrey,
              title: "Downloading..",
            );
          }

          if (state.statusDownload == StatusDownload.success) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            showBanner(
              context,
              color: Colors.green[200]!,
              title: "Download Complete",
              actions: [
                TextButton(
                  onPressed: () {
                    OpenFile.open(state.downloadedFilePath);
                  },
                  child: Text(
                    "Open File",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            );

            Future.delayed(const Duration(seconds: 2), () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            });
          }

          if (state.statusDownload == StatusDownload.failed) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            showBanner(
              context,
              color: Colors.red[200]!,
              title: "Download Failed",
            );

            Future.delayed(const Duration(seconds: 2), () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            });
          }
        },
        buildWhen: (_, __) => false,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                iconSize: 20,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).textTheme.headline1?.color,
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                "Detail Photo",
                style: Theme.of(context).textTheme.headline4,
              ),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey[100],
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: NetworkImage(state.photo.imageOriginal),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Image(
                            image: NetworkImage(state.photo.imageLarge),
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_sharp,
                                  color: Colors.blueGrey,
                                ),
                              );
                            },
                          );
                        },
                        errorBuilder: (_, __, ___) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image_sharp,
                              color: Colors.blueGrey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Photo by ${state.photo.photographer}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      actionIconButton(
                        context: context,
                        path: "assets/ic_download.png",
                        onTap: context.read<DetailPhotoCubit>().downloadImage,
                      ),
                      actionIconButton(
                        context: context,
                        path: "assets/ic_share.png",
                        onTap: context.read<DetailPhotoCubit>().shareImage,
                      ),
                      actionIconButton(
                        context: context,
                        path: "assets/ic_edit.png",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageName.editPhoto,
                            arguments: state.photo,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget actionIconButton({
    required BuildContext context,
    required String path,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(path),
          ),
        ),
      ),
    );
  }

  void showBannerProgress(
    BuildContext context, {
    Color color = Colors.grey,
    String title = "",
  }) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        elevation: 1,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        backgroundColor: color,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
            BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
              builder: (context, state) {
                return Text(
                  "${state.progressDownload}%",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                      ),
                );
              },
            ),
          ],
        ),
        actions: const [
          SizedBox(),
        ],
      ),
    );
  }
}
