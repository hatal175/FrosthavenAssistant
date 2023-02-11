import 'package:flutter/material.dart';
import 'package:frosthaven_assistant/Layout/section_button.dart';
import 'package:frosthaven_assistant/Resource/state/game_state.dart';
import '../Resource/settings.dart';
import '../Resource/state/monster_instance.dart';
import '../services/service_locator.dart';

class SectionList extends StatefulWidget {
  const SectionList({Key? key}) : super(key: key);

  @override
  SectionListState createState() => SectionListState();
}

class SectionListState extends State<SectionList> {
  late List<MonsterInstance> lastList = [];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> generateList(List<String> inputList) {
    List<Widget> list = [];
    for (int index = 0; index < inputList.length; index++) {
      var item = inputList[index];
      SectionButton value =
          SectionButton(key: Key(item), data: item);
      list.add(value);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<double>(
        valueListenable: getIt<Settings>().userScalingBars,
        builder: (context, value, child) {
          double scale = getIt<Settings>().userScalingBars.value;
          GameState gameState = getIt<GameState>();
    return ValueListenableBuilder<int>(
        valueListenable: getIt<GameState>().commandIndex,
        builder: (context, value, child) {
          var list = gameState.modelData.value[gameState.currentCampaign.value]
              ?.scenarios[gameState.scenario.value]?.sections.keys
              .toList();
          if(list != null && gameState.scenarioSectionsAdded.length == list.length) {
            list = [];
          }
          list ??= [];
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 4 * scale,
              runSpacing: 0 * scale,
              children: generateList(list));
        });
        });
  }
}