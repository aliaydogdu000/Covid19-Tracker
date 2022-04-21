import 'package:covid19/core/network/network_service.dart';
import 'package:covid19/feature/constants/colors.dart';
import 'package:covid19/feature/constants/strings.dart';
import 'package:covid19/feature/model/covid_model.dart';
import 'package:covid19/feature/service/country_service.dart';
import 'package:covid19/feature/views/country_view.dart';
import 'package:flutter/material.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MySearchPage createState() => _MySearchPage();
}

class _MySearchPage extends State<MySearchPage> {
  TextEditingController editingController = TextEditingController();

  CovidModel? model;
  List<Country> countryItems = [];
  bool isLoading = true;

  Future<CovidModel?> fetchCountryList() async {
    model = await CountryService(NetworkService.instance.networkManager)
        .fetchCountryData();
    return model;
  }

  @override
  void initState() {
    fetchCountryList().then((value) {
      setState(() {
        countryItems = model?.countries ?? [];
        isLoading = !isLoading;
      });
    });

    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        countryItems =
            model?.countries?.where((e) => e.slug!.contains(query)).toList() ??
                [];
      });
      return;
    } else {
      setState(() {
        countryItems = model?.countries ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScale().mainColor,
        title: Text(widget.title ?? ""),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: ColorScale().mainColor,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                      labelText: AllStrings().search,
                      hintText: AllStrings().search,
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorScale().mainColor,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: countryItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryPage(
                                    index: index,
                                    title: countryItems[index].country ?? "",
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: ColorScale().textIconColor,
                                    )),
                              ));
                        },
                        title: Text(
                          countryItems[index].country ?? "",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
