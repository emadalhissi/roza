import 'package:Rehlati/FireBase/fb_firestore_favorites_controller.dart';
import 'package:Rehlati/Providers/favorites_provider.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesScreenListViewItem extends StatefulWidget {
  final Trip trip;

  const FavoritesScreenListViewItem({
    required this.trip,
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesScreenListViewItem> createState() =>
      _FavoritesScreenListViewItemState();
}

class _FavoritesScreenListViewItemState
    extends State<FavoritesScreenListViewItem> with SnackBarHelper {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1.5,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image:
                          CachedNetworkImageProvider(widget.trip.images!.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.trip.name!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.trip.time!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.trip.date!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.place,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              SharedPrefController().getLang == 'en'
                                  ? widget.trip.addressCityName!
                                  : widget.trip.addressCityNameAr!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        await favorite();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 23,
                        child: Icon(
                          Icons.favorite,
                          color: Provider.of<FavoritesProvider>(context)
                                  .checkFavorite(tripId: widget.trip.tripId!)
                              ? const Color(0xff5859F3)
                              : Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '\$${widget.trip.price}',
                      style: const TextStyle(
                        color: Color(0xff5859F3),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> favorite() async {
    await FbFireStoreFavoritesController().favorite(
      type: SharedPrefController().getAccountType,
      tripId: widget.trip.tripId!,
      officeId: widget.trip.officeId!,
      callBackUrl: ({
        required bool status,
        required bool favorite,
        required Trip trip,
      }) async {
        if (status && favorite) {
          Provider.of<FavoritesProvider>(context, listen: false).favorite_(
            trip: trip,
            status: true,
          );
          showSnackBar(
            context,
            message: AppLocalizations.of(context)!.favoriteAdded,
            error: false,
          );
        } else if (status && !favorite) {
          Provider.of<FavoritesProvider>(context, listen: false).favorite_(
            trip: trip,
            status: false,
          );
          showSnackBar(
            context,
            message: AppLocalizations.of(context)!.favoriteRemoved,
            error: false,
          );
        } else {
          showSnackBar(
            context,
            message: AppLocalizations.of(context)!.somethingWentWrong,
            error: true,
          );
        }
      },
    );
  }
}
