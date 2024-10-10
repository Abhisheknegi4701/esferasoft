
import 'package:esferasoft/helper/route_helper.dart';
import 'package:esferasoft/provider/home_provider.dart';
import 'package:esferasoft/utill/app_constants.dart';
import 'package:esferasoft/utill/globalmethod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).getTaskData(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: (homeProvider.getTaskDataLoading)?
              Center(child: CircularProgressIndicator())
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hello User,",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showToast("Person Profile");
                              },
                              child: Icon(Icons.person),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      if(homeProvider.allTaskList.task != null && homeProvider.allTaskList.task!.isNotEmpty)
                        SizedBox(
                          height: 40,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    homeProvider.filterList(-1);
                                  },
                                  child: Card(
                                    color: homeProvider.selectedFiltered == -1 ? Colors.black : Colors.white,
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      child:  Text("${AppConstants.status[-1]}", style: TextStyle(
                                          color: homeProvider.selectedFiltered == -1 ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    homeProvider.filterList(0);
                                  },
                                  child: Card(
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: homeProvider.selectedFiltered == 0 ? Colors.black : Colors.white,
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      child:  Text("${AppConstants.status[0]}", style: TextStyle(
                                          color: homeProvider.selectedFiltered == 0 ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    homeProvider.filterList(1);
                                  },
                                  child: Card(
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: homeProvider.selectedFiltered == 1 ? Colors.black : Colors.white,
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      child:  Text("${AppConstants.status[1]}", style: TextStyle(
                                          color: homeProvider.selectedFiltered == 1 ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                )
                              ],
                          ),
                        ),
                      if(homeProvider.allTaskList.task != null && homeProvider.allTaskList.task!.isNotEmpty)
                        ListView.builder(
                        itemCount: homeProvider.allTaskList.task!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            if (homeProvider.selectedFiltered == -1 ||
                                homeProvider.allTaskList.task![index].status == homeProvider.selectedFiltered){
                                return GestureDetector(
                                  onTap: (){
                                    homeProvider.updateSelectedIndex(index);
                                    Navigator.pushNamed(context, RouteHelper.detail);
                                  },
                                  child: Card(
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${homeProvider.allTaskList.task![index].name}", style: TextStyle(
                                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold
                                              ),),
                                              if(homeProvider.allTaskList.task![index].status == 0)
                                                Card(
                                                  elevation: 10,
                                                  color: homeProvider.allTaskList.task![index].priority == 0 ? Colors.green :
                                                  homeProvider.allTaskList.task![index].priority == 1 ? Colors.yellow :
                                                  Colors.red,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                    child:  Text("${AppConstants.priority[homeProvider.allTaskList.task![index].priority]}", style: TextStyle(
                                                        color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold
                                                    ),),
                                                  ),
                                                )
                                              else
                                                Icon(Icons.check_circle_outline, color: Colors.green,),
                                            ],
                                          ),
                                          Text("${homeProvider.allTaskList.task![index].description}", style: TextStyle(
                                              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500
                                          ),),
                                          SizedBox(height: 20,),
                                          Text("Ends: ${DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(homeProvider.allTaskList.task![index].deadline ?? DateTime.now().millisecondsSinceEpoch))}", style: TextStyle(
                                              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500
                                          ),),
                                          SizedBox(height: 10,),
                                          Text(DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(homeProvider.allTaskList.task![index].created ?? DateTime.now().millisecondsSinceEpoch)), style: TextStyle(
                                              color: Colors.black, fontSize: 10, fontWeight: FontWeight.w300
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                          }
                      )
                      else
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Text("No Task Found", style: TextStyle(
                                  color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ),
          floatingActionButton: !homeProvider.getTaskDataLoading ?
          FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, RouteHelper.addTask);
              },
            child: Icon(Icons.add, color: Colors.black,),
          ): Container(),
        );
      },
    );
  }
}
