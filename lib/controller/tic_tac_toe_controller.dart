import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TicTacToeController extends GetxController {
  RxList<String> board = RxList.filled(9, '');
  RxString currentPlayer = 'X'.obs;
  RxString result = ''.obs;
  RxBool gameOver = false.obs;
  RxString difficulty = 'Easy'.obs;
  List<String> difficultyList = ['Easy', 'Medium', 'Hard'];

  void resetGame() {
    board.clear();
    board = RxList.filled(9, '');
    currentPlayer.value = 'X';
    result.value = '';
    gameOver.value = false;
  }

  void checkGameStatus() {
    List<List<int>> winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombos) {
      if (board[combo[0]] != '' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[0]] == board[combo[2]]) {
        result.value = 'Player ${board[combo[0]]} Wins!';
        gameOver.value = true;
        if(board[combo[0]]=='X'){
          Get.dialog(
            AlertDialog(
              title:  Lottie.asset(
                'assets/animations/Animation - 1728715686260.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
                repeat: true,
              ),
            ),
          );

          // Close the dialog after 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            Get.back();
          });
        }
        return;
      }
    }

    if (!board.contains('')) {
      result.value = 'It\'s a Draw!';
      gameOver.value = true;
    } else {
      currentPlayer.value = currentPlayer.value == 'X' ? 'O' : 'X';
    }
  }

  void computerMove() {
    if (difficulty.value == 'Easy') {
      easyMove();
    } else if (difficulty.value == 'Medium') {
      mediumMove();
    } else {
      hardMove();
    }
    checkGameStatus();
  }

  void easyMove() {
    print('Easy Move');
    var available = [];
    for (var i = 0; i < board.length; i++) {
      if (board[i] == '') {
        available.add(i);
      }
    }
    var random = Random();
    int move = available[random.nextInt(available.length)];
    board[move] = 'O';
    update();
  }

  void mediumMove() {
    print('Medium Move');
    // Try to block player if possible, otherwise random move
    for (var i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        if (checkIfWinner('O')) {
          return;
        }
        board[i] = 'X';
        if (checkIfWinner('X')) {
          board[i] = 'O';
          return;
        }
        board[i] = '';
      }
    }
    easyMove(); // Fallback to random move
  }

  bool checkIfWinner(String player) {
    List<List<int>> winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombos) {
      if (board[combo[0]] == player &&
          board[combo[1]] == player &&
          board[combo[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void hardMove() {
    print('HARD Move');
    // Implementing Minimax Algorithm for optimal moves
    int bestScore = -1000;
    int move = -1;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = minimax(board, false);
        board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    board[move] = 'O';
    update();
  }

  int minimax(List<String> newBoard, bool isMaximizing) {
    if (checkIfWinner('O')) return 1;
    if (checkIfWinner('X')) return -1;
    if (!newBoard.contains('')) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i] == '') {
          newBoard[i] = 'O';
          int score = minimax(newBoard, false);
          newBoard[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i] == '') {
          newBoard[i] = 'X';
          int score = minimax(newBoard, true);
          newBoard[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }
}