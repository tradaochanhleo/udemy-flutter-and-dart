import 'package:flutter/material.dart';

import '/widgets/tabs_screen/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveHandler;
  final Map<String, bool> currentFilters;

  const FiltersScreen({
    Key? key,
    required this.saveHandler,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    super.initState();
    glutenFree = widget.currentFilters['gluten'] as bool;
    lactoseFree = widget.currentFilters['lactose'] as bool;
    vegetarian = widget.currentFilters['vegetarian'] as bool;
    vegan = widget.currentFilters['vegan'] as bool;
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              widget.saveHandler({
                'gluten': glutenFree,
                'lactose': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian,
              });
              // print({
              //   'gluten': glutenFree,
              //   'lactose': lactoseFree,
              //   'vegan': vegan,
              //   'vegetarian': vegetarian,
              // });
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  glutenFree,
                  (newValue) {
                    setState(() {
                      glutenFree = newValue;
                      // v?? n?? s??? kh??ng t??? build l???i n??n c???n ph???i setState
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  lactoseFree,
                  (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                      // v?? n?? s??? kh??ng t??? build l???i n??n c???n ph???i setState
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  vegetarian,
                  (newValue) {
                    setState(() {
                      vegetarian = newValue;
                      // v?? n?? s??? kh??ng t??? build l???i n??n c???n ph???i setState
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals',
                  vegan,
                  (newValue) {
                    setState(() {
                      vegan = newValue;
                      // v?? n?? s??? kh??ng t??? build l???i n??n c???n ph???i setState
                    });
                  },
                ),
                // Ban ?????u nh?? n??y s??? kh??ng ?????, v?? khi m??nh chuy???n sang
                // page categories meal r???i quay l???i filters page th??
                // filters page s??? b??? load l???i => m???t h???t c??c gi?? tr???
                // c???a filter hi???n t???i!
              ],
            ),
            // have fixed amount of elements here => don't need builder
          ),
        ],
      ),
    );
  }
}
