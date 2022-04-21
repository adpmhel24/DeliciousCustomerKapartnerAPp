import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatefulWidget {
  ImageViewer({
    Key? key,
    required this.initialIndex,
    required this.attachments,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  final int initialIndex;
  final PageController pageController;
  final List<Map<String, dynamic>> attachments;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attachments"),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          pageController: widget.pageController,
          itemCount: widget.attachments.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              heroAttributes:
                  PhotoViewHeroAttributes(tag: widget.attachments[index]),
              imageProvider: CachedNetworkImageProvider(
                widget.attachments[index]['image_url'],
              ),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: Theme.of(context).canvasColor,
          ),
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
