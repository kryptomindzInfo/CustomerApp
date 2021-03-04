import 'package:beyond_wallet/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
Widget networkImage(String url){
  return CircleAvatar(
    backgroundColor: Colors.transparent,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: CachedNetworkImage(
        imageUrl: imageBaseURL+url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ),
  );
}