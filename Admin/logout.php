<?php
session_start();
include_once '../includes/domain.php';
session_destroy();
unset($_SESSION['admin_login']);
echo "กำลังออกจากระบบ";
header("location: {$domain}Admin/login.php");
?>