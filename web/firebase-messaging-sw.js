// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyBUHEHV7EtXHezDywFNGqiS8ggYbB4bMEs",
    authDomain: "vitamedd.firebaseapp.com",
    databaseURL: "https://vitamedd-default-rtdb.firebaseio.com",
    projectId: "vitamedd",
    storageBucket: "vitamedd.appspot.com",
    messagingSenderId: "356117566040",
    appId: "1:356117566040:web:0504ade43eb6ec2286f02d"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});