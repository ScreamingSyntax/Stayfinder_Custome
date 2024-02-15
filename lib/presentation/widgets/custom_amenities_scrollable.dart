import 'package:boxicons/boxicons.dart';

import '../../data/data_exports.dart';
import 'widgets_export.dart';

class CustomAmenitiesScrollable extends StatelessWidget {
  const CustomAmenitiesScrollable({
    super.key,
    required this.room,
    required this.accommodation,
  });

  final Room room;
  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.dumbbell,
            text: "Gym",
            value: accommodation.gym_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.bottleWater,
            text: "Water Bottle",
            value: room.water_bottle_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.trashArrowUp,
            text: "Trash Disposable",
            value: accommodation.trash_dispose_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.fan,
            text: "Fan",
            value: room.fan_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.car,
            text: "Parking",
            value: accommodation.parking_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: Icons.iron,
            text: "Iron",
            value: room.steam_iron_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.trash,
            text: "Dustbin",
            value: room.dustbin_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.jar,
            text: "Kettle",
            value: room.kettle_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.coffee,
            text: "Coffee Powder",
            value: room.coffee_powder_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: Icons.water,
            text: "Milk Powder",
            value: room.milk_powder_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: FontAwesomeIcons.glassWater,
            text: "Tea Powder",
            value: room.tea_powder_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: Icons.dry,
            text: "Hair Dryer",
            value: room.hair_dryer_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: Icons.tv,
            text: "T.V",
            value: room.tv_availability,
          ),
          SizedBox(
            width: 10,
          ),
          CustomAmenitiesCardRoom(
            icon: Boxicons.bx_water,
            text: "Swimming",
            value: accommodation.swimming_pool_availability,
          ),
        ],
      ),
    );
  }
}

class CustomAmenitiesCardRoom extends StatelessWidget {
  final IconData icon;
  final String text;
  bool? value;
  CustomAmenitiesCardRoom({
    super.key,
    required this.icon,
    required this.text,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value ?? false,
      child: Column(
        children: [
          Icon(
            icon,
            color: UsedColors.fadeOutColor,
            size: 20,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 10,
                color: UsedColors.fadeOutColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
