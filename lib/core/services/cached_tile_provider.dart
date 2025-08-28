import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';

class CachedTileProvider extends TileProvider {
  final BaseCacheManager cacheManager;

  CachedTileProvider({BaseCacheManager? cacheManager})
    : cacheManager = cacheManager ?? DefaultCacheManager();

  @override
  ImageProvider getImage(TileCoordinates coords, TileLayer layer) {
    final url = layer.urlTemplate!
        .replaceAll('{z}', coords.z.toString())
        .replaceAll('{x}', coords.x.toString())
        .replaceAll('{y}', coords.y.toString());

    return CachedNetworkImageProvider(url, cacheManager: cacheManager);
  }
}
