<?php
    session_start();
    echo "กรุณารอสักครู่";
    include_once "../../../includes/domain.php";
    require "../../../sql/connect.php";
    $id=$_GET['id'];
    $traget = "../img/";
    

    if(isset($_POST['Update'])){
            $id=$_GET['id'];
            $filename = basename($_FILES["file"]["name"]); 
            $new_filename = rand(0, microtime(true)).'-'.$filename;
            $folder = $traget . $new_filename;
            $tragetType = pathinfo($folder, PATHINFO_EXTENSION); 
            
            $allowTypes = array('jpg', 'png', 'jpeg', 'gif', 'pdf');

            if(in_array($tragetType, $allowTypes)){
                if(move_uploaded_file($_FILES["file"]["tmp_name"], $folder)){
                    $stmt = $conn->query("UPDATE agents SET image = '".$new_filename."' WHERE agentsID = '" . $id . "'");
                    $stmt->execute();
                    $row = $stmt->fetch(PDO::FETCH_ASSOC);

                    if($stmt){
                        $check_role = $conn->query("SELECT role FROM agents WHERE agentsID = $id");
                        $check_role->execute();
                        $row = $check_role->fetch(PDO::FETCH_ASSOC);

                        if($row['role'] == 0){
                            header("location: {$domain}Admin/agents/dashboard.php");
                        }else{
                            header("location: {$domain}Admin/pages/dashboard/dashboard.php");
                        }
                    }
                }
            }
    }
?>