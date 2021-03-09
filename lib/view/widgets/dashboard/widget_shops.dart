import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/model/shop.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/fake_database.dart';
import 'package:emplog/utils/helper.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/route/route_shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ShopsFragment extends StatefulWidget {
  @override
  _ShopsFragmentState createState() => _ShopsFragmentState();
}

class _ShopsFragmentState extends State<ShopsFragment> {
  List<Shop> shopList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    shopList = shops;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    attendanceProvider.trackLocation();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: themeProvider.backgroundColor,
          title: Text("Shops", style: TextStyles.title(context: context, color: themeProvider.accentColor)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.name,
                style: TextStyles.body(context: context, color: themeProvider.textColor),
                cursorColor: themeProvider.accentColor,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  if (searchController.text.isEmpty) {
                    setState(() {
                      shopList = shops;
                    });
                  } else {
                    setState(() {
                      String keyword = searchController.text.toLowerCase();
                      shopList = shops.where((shop) => shop.name.toLowerCase().startsWith(keyword) || shop.address.toLowerCase().startsWith(keyword)).toList();
                    });
                  }
                },
                decoration: InputDecoration(
                  fillColor: themeProvider.secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(4)),
                  contentPadding: EdgeInsets.all(16),
                  hintText: "search",
                  hintStyle: TextStyles.body(context: context, color: themeProvider.shadowColor),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: shopList.length,
                itemBuilder: (BuildContext context, int index) {
                  Shop shop = shopList[index];
                  return ListTile(
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    tileColor: attendanceProvider.didVisitedThisShopToday(shop.name) ? themeProvider.tagColor : themeProvider.backgroundColor,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(border: Border.all(color: themeProvider.accentColor, width: attendanceProvider.didVisitedThisShopToday(shop.name) ? 2 : 0),
                          borderRadius: BorderRadius.circular(40)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: CachedNetworkImage(
                                imageUrl: shop.logo,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.store, color: themeProvider.hintColor),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: attendanceProvider.didVisitedThisShopToday(shop.name),
                            child: Positioned(
                              child: CircleAvatar(child: Icon(Icons.check, color: themeProvider.backgroundColor, size: 12), backgroundColor: themeProvider.accentColor, radius: 8),
                              bottom: -4,
                              right: -4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(shop.name, style: TextStyles.body(context: context, color: themeProvider.textColor)),
                    subtitle: Text(shop.address, style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
                    trailing: attendanceProvider.currentLocation != null
                        ? Text(
                            "${prettyDistance(calculateDistance(shop.latitude, shop.longitude, attendanceProvider.currentLocation.latitude, attendanceProvider.currentLocation.longitude))} away",
                            style: TextStyles.caption(context: context, color: themeProvider.hintColor))
                        : null,
                    onTap: () {
                      Navigator.of(context).pushNamed(ShopDetailsRoute().route, arguments: shop.guid);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
