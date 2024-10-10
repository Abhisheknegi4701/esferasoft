import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper/route_helper.dart';
import '../../provider/home_provider.dart';
import '../../utill/app_constants.dart';
import '../../utill/globalmethod.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder:
          (BuildContext context, HomeProvider homeProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: (homeProvider.getTaskDataLoading)
                ? CircularProgressIndicator()
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: homeProvider.selectedIndex > -1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${homeProvider.allTaskList.task![homeProvider.selectedIndex].name}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (homeProvider
                                              .allTaskList
                                              .task![homeProvider.selectedIndex]
                                              .status ==
                                          0)
                                        Card(
                                          elevation: 10,
                                          color: homeProvider
                                                      .allTaskList
                                                      .task![homeProvider
                                                          .selectedIndex]
                                                      .priority ==
                                                  0
                                              ? Colors.green
                                              : homeProvider
                                                          .allTaskList
                                                          .task![homeProvider
                                                              .selectedIndex]
                                                          .priority ==
                                                      1
                                                  ? Colors.yellow
                                                  : Colors.red,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              "${AppConstants.priority[homeProvider.allTaskList.task![homeProvider.selectedIndex].priority]}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      else
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                        ),
                                    ],
                                  ),
                                  Text(
                                    "${homeProvider.allTaskList.task![homeProvider.selectedIndex].description}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Ends: ${DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(homeProvider.allTaskList.task![homeProvider.selectedIndex].deadline ?? DateTime.now().millisecondsSinceEpoch))}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    DateFormat.yMMMMEEEEd().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            homeProvider
                                                    .allTaskList
                                                    .task![homeProvider
                                                        .selectedIndex]
                                                    .created ??
                                                DateTime.now()
                                                    .millisecondsSinceEpoch)),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteHelper.editTask);
                                        },
                                        child: Card(
                                          elevation: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await homeProvider
                                              .deleteTask()
                                              .then((value) {
                                            if (value) {
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                              homeProvider
                                                  .updateSelectedIndex(-1);
                                            } else {
                                              showToast(homeProvider
                                                  .deleteTaskListErrorMessage);
                                            }
                                          });
                                        },
                                        child: Card(
                                          elevation: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: homeProvider
                                                    .deleteTaskDataLoading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if((homeProvider.allTaskList.task![homeProvider.selectedIndex].status == 0))
                                    GestureDetector(
                                    onTap: () {
                                      homeProvider.updateStatus();
                                    },
                                    child: Card(
                                      elevation: 10,
                                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: Center(
                                          child: homeProvider.updateStatusTaskDataLoading ?
                                          CircularProgressIndicator():
                                          Text(
                                            "Completed",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Data Found",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
