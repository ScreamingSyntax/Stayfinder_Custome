import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import 'package:hive/hive.dart';
import '../../../logic/logic_exports.dart';
import '../screens_export.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchAccommodationsBloc, FetchAccommodationsState>(
        builder: (context, state) {
          if (state is FetchAccommodationsInitial) {
            context
                .read<FetchAccommodationsBloc>()
                .add(HitFetchAccommodationsEvent());
          }
          if (state is FetchAccommodationLoading) {
            return Center(
              child: CustomLoadingWidget(
                text: "Getting Accommodations",
              ),
            );
          }
          if (state is FetchAccommodationError) {
            return CustomErrorScreen(
              message: state.message,
              onPressed: () => context.read<FetchAccommodationsBloc>()
                ..add(HitFetchAccommodationsEvent()),
            );
          }
          if (state is FetchAccommodationSuccess) {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FlutterMap(options: MapOptions(), children: [
                    TileLayer(
                      errorTileCallback: (tile, error, stackTrace) {
                        // CachedTileProvider(store: store)
                      },

                      // tileProvider: CachedTileProvider(
                      //   // maxStale keeps the tile cached for the given Duration and
                      //   // tries to revalidate the next time it gets requested
                      //   maxStale: const Duration(days: 30),
                      //   // This example uses Hive as storage backend
                      //   store:

                      // ),
                      errorImage: AssetImage("assets/images/error.png"),
                      evictErrorTileStrategy: EvictErrorTileStrategy.notVisible,
                      urlTemplate:
                          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.stayfinder_customer.app',
                    ),
                  ]),
                )
              ],
            );
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}
