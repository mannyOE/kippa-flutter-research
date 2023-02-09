import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'feed_viewmodel.dart';

class FeedView extends StackedView<FeedViewModel> {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FeedViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              children: [
                ...viewModel.categories.map(
                  (e) => GestureDetector(
                    onTap: () => {viewModel.fetchNews(e.toLowerCase())},
                    child: Container(
                      height: 50,
                      width: 90,
                      margin: const EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: viewModel.currentCategory !=
                                      e.toLowerCase()
                                  ? [
                                      const Color.fromRGBO(143, 148, 251, 1),
                                      const Color.fromRGBO(143, 148, 251, .7),
                                    ]
                                  : [
                                      const Color.fromARGB(255, 179, 136, 1),
                                      const Color.fromRGBO(255, 179, 136, 1),
                                    ])),
                      child: Center(
                        child: Text(
                          e,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {viewModel.logOut()},
                  child: Container(
                    height: 50,
                    width: 90,
                    margin: const EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 179, 136, 1),
                          Color.fromRGBO(255, 179, 136, 1),
                        ])),
                    child: const Center(
                      child: Text(
                        "Log out",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ...viewModel.box.values.map((article) => SizedBox(
                height: 250,
                child: Column(
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      article.content,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                )))
          ],
        ),
      ),
    );
  }

  @override
  FeedViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FeedViewModel();
  @override
  void onViewModelReady(FeedViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.fetchNews('africa'));
}
