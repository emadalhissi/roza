import 'package:Rehlati/Providers/favorites_provider.dart';
import 'package:Rehlati/Screens/trip_screen.dart';
import 'package:Rehlati/widgets/Favorites%20Screen%20Widgets/favorites_screen_list_view_item.dart';
import 'package:Rehlati/widgets/not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Rehlati/Providers/profile_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoritesWidget(),
    );
  }

  Widget favoritesWidget() {
    if (Provider.of<ProfileProvider>(context).loggedIn_) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Provider.of<FavoritesProvider>(context).favorites_.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      Provider.of<FavoritesProvider>(context).favorites_.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripScreen(
                              tripName: Provider.of<FavoritesProvider>(context)
                                  .favorites_[index]
                                  .name!,
                              tripTime: Provider.of<FavoritesProvider>(context)
                                  .favorites_[index]
                                  .time!,
                              tripDate: Provider.of<FavoritesProvider>(context)
                                  .favorites_[index]
                                  .date!,
                              tripAddress:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .addressCityName!,
                              tripAddressAr:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .addressCityNameAr!,
                              price: Provider.of<FavoritesProvider>(context)
                                  .favorites_[index]
                                  .price!,
                              tripId: Provider.of<FavoritesProvider>(context)
                                  .favorites_[index]
                                  .tripId!,
                              tripDescription:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .description!,
                              minPayment:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .minPayment!,
                              tripImages:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .images!,
                              tripAddressId:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .addressCityId!,
                              officeName:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .officeName!,
                              officeEmail:
                                  Provider.of<FavoritesProvider>(context)
                                      .favorites_[index]
                                      .officeEmail!,
                              officeId: Provider.of<FavoritesProvider>(context)
                                  .favorites_[index]
                                  .officeId!,
                            ),
                          ),
                        );
                      },
                      child: FavoritesScreenListViewItem(
                        trip: Provider.of<FavoritesProvider>(context)
                            .favorites_[index],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    AppLocalizations.of(context)!.youHaveNoFavorites,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        ),
      );
    } else {
      return const NotLoggedIn();
    }
  }
}
