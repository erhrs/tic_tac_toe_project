import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tic_tac_toe_project/controller/tic_tac_toe_controller.dart';
import 'package:tic_tac_toe_project/utils/custom_widgets.dart';
import 'package:tic_tac_toe_project/utils/extensions.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  TicTacToeController ticTacToeController = Get.put(TicTacToeController());

  @override
  void dispose() {
    Get.delete<TicTacToeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Tic Tac Toe'),
      //   actions: [
      //     PopupMenuButton<String>(
      //       onSelected: (String value) {
      //         ticTacToeController.difficulty.value = value;
      //       },
      //       itemBuilder: (BuildContext context) {
      //         return ['Easy', 'Medium', 'Hard'].map((String choice) {
      //           return PopupMenuItem<String>(
      //             value: choice,
      //             child: Text(choice),
      //           );
      //         }).toList();
      //       },
      //     ),
      //   ],
      // ),
      // body: SafeArea(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       DropdownMenu<String>(
      //         initialSelection: ticTacToeController.difficultyList.first,
      //         onSelected: (String? value) {
      //           ticTacToeController.difficulty.value = value!;
      //         },
      //         dropdownMenuEntries: ticTacToeController.difficultyList
      //             .map<DropdownMenuEntry<String>>((String value) {
      //           return DropdownMenuEntry<String>(value: value, label: value);
      //         }).toList(),
      //       ),
      //       Obx(
      //         () => Text(
      //           ticTacToeController.result.isNotEmpty
      //               ? ticTacToeController.result.value
      //               : 'Current Player: ${ticTacToeController.currentPlayer.value}',
      //           style: const TextStyle(fontSize: 24),
      //         ),
      //       ),
      //       20.height,
      //       GridView.builder(
      //         padding: const EdgeInsets.all(20),
      //         shrinkWrap: true,
      //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 3, childAspectRatio: 1),
      //         itemCount: 9,
      //         itemBuilder: (context, index) {
      //           return GestureDetector(
      //               onTap: () {
      //                 if (!ticTacToeController.gameOver.value &&
      //                     ticTacToeController.board[index] == '') {
      //                   ticTacToeController.board[index] =
      //                       ticTacToeController.currentPlayer.value;
      //                   ticTacToeController.checkGameStatus();
      //                   if (!ticTacToeController.gameOver.value) {
      //                     ticTacToeController.computerMove();
      //                   }
      //                 }
      //               },
      //               child: Obx(
      //                 () => Container(
      //                   decoration: BoxDecoration(
      //                     color: ticTacToeController.board[index] == 'X'
      //                         ? Colors.red
      //                         : ticTacToeController.board[index] == 'O'
      //                             ? Colors.blue
      //                             : Colors.white,
      //                     border: Border.all(color: Colors.black),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       ticTacToeController.board[index],
      //                       style: const TextStyle(fontSize: 32),
      //                     ),
      //                   ),
      //                 ),
      //               ));
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           ticTacToeController.resetGame();
      //         },
      //         child: const Text('Restart Game'),
      //       ),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[100]!, Colors.blue[300]!],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Select Level : ',style: customTextStyle(fontSize: 20),),
                  Obx(() => DropdownButton<String>(
                    value: ticTacToeController.difficulty.value,
                    onChanged: (String? newValue) {
                      ticTacToeController.difficulty.value = newValue!;
                    },
                    items: ticTacToeController.difficultyList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: customTextStyle(fontSize: 18,color: Colors.white),
                        ),
                      );
                    }).toList(),
                    dropdownColor: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    style:customTextStyle(),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    ),
                    elevation: 20,
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                  )),
                ],
              ),
              20.height,
              Obx(
                () => Text(
                  ticTacToeController.result.isNotEmpty
                      ? ticTacToeController.result.value
                      : 'You Are Player: ${ticTacToeController.currentPlayer.value}',
                  style: customTextStyle(fontSize: 25, color: Colors.blue),
                ),
              ),
              10.height,
              _buildBoard(),
              30.height,
              customButton(title: 'Restart!', onPressed: () => ticTacToeController.resetGame(), lightBool: true)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (!ticTacToeController.gameOver.value &&
                  ticTacToeController.board[index] == '') {
                ticTacToeController.board[index] =
                    ticTacToeController.currentPlayer.value;
                ticTacToeController.checkGameStatus();
                if (!ticTacToeController.gameOver.value) {
                  ticTacToeController.computerMove();
                }
              }
            },
            child: Obx(() => Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Center(
                child: Text(
                  ticTacToeController.board[index],
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: ticTacToeController.board[index] == 'X'
                        ? Colors.blue
                        : Colors.red,
                  ),
                ),
              ),
            ),)
          );
        },
      ),
    );
  }
}