<?php
$servername = "15.235.154.180";
$username = "travelan_andamantur-db";
$password = "Han_0647526359";
$dbname = "travelan_andamantur-db";

try {
  $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
  echo "Connection failed: " . $e->getMessage();
}
?>