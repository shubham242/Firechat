const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
exports.myFunction = functions.firestore
    .document("chats/{message}")
    .onCreate((snap, context) => {
      admin.messaging().sendToTopic("chats", {
        notification: {
          title: snap.data().username,
          body: snap.data().text,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        }});
    });
