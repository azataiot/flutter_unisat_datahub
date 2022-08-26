import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unisat_data/pages/selection/selection_state.dart';

import '../../widgets/svg/azt_svg_logo.dart';
import '../home/home_view.dart';
import 'selection_controller.dart';

class SelectionPage extends GetResponsiveView<SelectionController> {
  @override
  final controller = Get.find<SelectionController>();
  final state = Get.find<SelectionController>().state;

  SelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AztSvgLogoText(
          svgAsset: 'assets/logo/logo-unisat.svg',
          spaceBetweenLogoAndText: 6.0,
          logoText: 'UniSat DataHub',
        ),
      ),
      body: GetBuilder<SelectionController>(builder: (controller) {
        if (state.isError!) {
          return SelectionStatus(
              statusType: HomeStatusType.error,
              controller: controller,
              state: state);
        } else if (state.isLoading!) {
          return SelectionStatus(
              statusType: HomeStatusType.loading,
              controller: controller,
              state: state);
        } else if (state.isConnecting!) {
          return SelectionStatus(
              statusType: HomeStatusType.connecting,
              controller: controller,
              state: state);
        }
        return Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 18, bottom: 18),
                      child: Text("page_select_select_provider".tr),
                    )
                  ],
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  itemCount: state.collections!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                state.collections![index].id!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                const Icon(Icons.satellite_alt,
                                    color: Colors.orangeAccent),
                                const SizedBox(width: 8),
                                Text(
                                    state.collections![index].id! == "unino"
                                        ? "page_select_sample_provider".tr
                                        : "page_select_unisat_provider".tr,
                                    style:
                                        const TextStyle(color: Colors.black87))
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_right,
                                  color: Colors.orange, size: 30.0),
                              onPressed: () {
                                controller.handleSelectSource(
                                    state.collections![index].id!);
                              },
                            )),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class SelectionStatus extends StatelessWidget {
  const SelectionStatus({
    Key? key,
    required this.statusType,
    required this.controller,
    required this.state,
  }) : super(key: key);

  final HomeStatusType statusType;
  final SelectionController controller;
  final SelectionState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(state.errorMsg!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text((statusType == HomeStatusType.error)
                    ? "page_select_505".tr
                    : (statusType == HomeStatusType.loading)
                        ? "page_select_loading".tr
                        : "page_select_connecting".tr),
              ),
            ),
          ),
          statusType == HomeStatusType.error
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.reTry();
                        },
                        child: const Text("Retry")),
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
