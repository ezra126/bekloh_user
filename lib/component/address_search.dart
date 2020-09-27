import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bekloh_user/services/place_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  String get searchFieldLabel => "Enter Your Destination";

  @override
  // TODO: implement textInputAction
  TextInputAction get textInputAction => super.textInputAction;

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text('error occured while search'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .08,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          top: MediaQuery.of(context).size.height * .02),
                      child: Text(
                        'Favorite Locations',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide.none,
                      right: BorderSide.none,
                    )),
                    height: MediaQuery.of(context).size.height * .08,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  GestureDetector(
                      onTap: (){
                         Navigator.pop(context);
                       // Navigator.pushNamed(context, PackageDetailRoute);
                        BlocProvider.of<DeliveryBookingBloc>(context).add(DestinationSelectedEvent());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide.none,
                          right: BorderSide.none,
                        )),
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Icon(Icons.location_on)),
                            Expanded(
                                flex: 8,
                                child: Text('Search location using map ')),
                            Expanded(
                                flex: 1, child: Icon(Icons.location_searching))
                          ],
                        ),
                      )),
                  Divider(
                    height: 0,
                    thickness: 2,
                  ),
                ],
              ),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data[index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(),
    );
  }
}
