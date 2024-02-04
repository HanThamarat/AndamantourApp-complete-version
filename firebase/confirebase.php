<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connect | Firebase</title>
</head>
<body>
<script type="module">
  
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.5.2/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.5.2/firebase-analytics.js";
  
  const firebaseConfig = {
    apiKey: "AIzaSyCSWNkdnlu1oDMlv_oDjFlT0uuNxGVkriQ",
    authDomain: "andamantour-app-d7115.firebaseapp.com",
    projectId: "andamantour-app-d7115",
    storageBucket: "andamantour-app-d7115.appspot.com",
    messagingSenderId: "230449477840",
    appId: "1:230449477840:web:f9ab326a3166ade86646d5",
    measurementId: "G-FK3KXV3YT0"
  };

  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
</script>
</body>
</html>