import 'package:audioplayers/audioplayers.dart';
import 'package:carlock/service/i_car_service.dart';
import 'package:carlock/service/car_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/car_brand.dart';
import 'car_controller_screen.dart';

class SelectCarScreen extends StatefulWidget {
  const SelectCarScreen({Key? key}) : super(key: key);

  @override
  State<SelectCarScreen> createState() => _SelectCarScreenState();
}

class _SelectCarScreenState extends State<SelectCarScreen> {

  String lamborghiniAssetPath = "assets/lamborghini.png";
  String carLogos = "https://raw.githubusercontent.com/filippofilip95/car-logos-dataset/master/logos/optimized/";

  List<CarBrand>? _items;
  bool _isLoading = false;
  bool _isAbsorbing = false;

  late final ICarService _carService;

  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer(
      mode: PlayerMode.LOW_LATENCY,
    );
    _carService = CarService();
    fetchItems();
  }

  void _changeLoading(){
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void fetchItems() async {
    _items = await _carService.fetchCarItems();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: _isAbsorbing,
        child: body(context),
      ),
    );
  }

  SafeArea body(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          firstLayer(context),
          _isAbsorbing ? Container(color: Colors.black54,) : Container(),
        ],
      )
    );
  }

  Column firstLayer(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        lamborghiniAssetPath,
                        height: 170,
                      ),
                      right: -50,
                    )
                  ],
                )
            ),
            Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select your car",
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 24,),
                          _isLoading ? DropdownButtonFormField(
                            onChanged: (value){
                              debugPrint(value.toString());
                            },
                            hint: Text(
                              "Select brand",
                            ),
                            isExpanded: true,
                            items: _items?.map((e){
                              return DropdownMenuItem(
                                child: SizedBox(
                                    child: Row(
                                      children: [
                                        Image.network(
                                          carLogos + (e.name!.contains(" ") ? "${e.name!.replaceAll(" ", "-").toLowerCase()}.png" : "${e.name.toString().toLowerCase()}.png"),
                                          errorBuilder: (context, url, s){
                                            return const Placeholder(
                                              fallbackHeight: 20,
                                              fallbackWidth: 20,
                                            );
                                          },
                                          height: 20,
                                        ),
                                        SizedBox(width: 24,),
                                        Text(
                                          e.name.toString(),
                                        ),
                                      ],
                                    )
                                ),
                                value: e,
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ) : CircularProgressIndicator(),
                          _divider(context),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "Give a name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          SizedBox(height: 24,),
                          InkWell(
                            onTap: (){
                              ready();

                            },
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/steering_wheel.svg",
                                height: 60,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                )
            )
          ],
        );
  }

  Center _divider(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
              color: Colors.black26,
            ),
            height: 5,
            width: 5,
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
              color: Colors.black26,
            ),
            height: 5,
            width: 5,
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  void ready() {
    /*int result = await _audioPlayer.play("engine_start.wav", isLocal: true);
    debugPrint(result.toString());*/

    setState(() {
      _isAbsorbing = true;

      final player = AudioCache();
      player.play("engine_start.wav",).whenComplete(() async {
        Future.delayed(const Duration(seconds: 5)).whenComplete((){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CarControllerScreen()));
        });
      });
    });
  }
}
