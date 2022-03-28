import 'package:flutter/material.dart';

void showDialogLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showInfoDialog(BuildContext context, String text, [IconData? iconData]) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Icon(iconData, size: 50),
                ),
              ),
            Text(
              text,
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      );
    },
  );
}

Future<T?> showDialogConfirmationToExit<T>(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Discard Edits ?",
          style: Theme.of(context).textTheme.headline2,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure want to Exit ? You'll lose all the edits you've made",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Cancel",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text(
              "Discard",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white),
            ),
          )
        ],
      );
    },
  );
}

void showBanner(
  BuildContext context, {
  Color color = Colors.grey,
  String title = "",
  List<Widget> actions = const [SizedBox()],
}) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      elevation: 1,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      backgroundColor: color,
      content: Text(
        title,
        style: Theme.of(context).textTheme.headline5?.copyWith(
              color: Colors.white,
            ),
      ),
      actions: actions,
    ),
  );
}
