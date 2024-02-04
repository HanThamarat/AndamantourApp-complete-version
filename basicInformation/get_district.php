<?php
require_once ("../sql/connect.php");
$am_sr = $conn->query("SELECT * FROM districts WHERE amphure_id={$_GET['amphure_id']}");
$am_sr->execute();
$result = $am_sr->fetchAll();

$json = array();

foreach($result as $data) {
    array_push($json, $data);
}

echo json_encode($json);
?>