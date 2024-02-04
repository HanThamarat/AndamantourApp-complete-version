<?php
require_once ("../sql/connect.php");

$ag_id = $_GET['id'];

$firstName = $_POST['firstname'];
$lastName = $_POST['Lastname'];
$mobileAgent = $_POST['mobileAgent'];

$CompanyName = $_POST['CompanyName'];
$MobileCompany = $_POST['MobileCompany'];
$RegistcompanyNo = $_POST['RegistcompanyNo'];

$address = $_POST['address'];
$provinceID = $_POST['province_id'];
$amphuresID = $_POST['amphures_id'];
$districtsID = $_POST['districts_id'];



if($_SERVER['REQUEST_METHOD'] == "POST"){
   try{
        $stmt_com = $conn->prepare("INSERT INTO company(companyName, tell, registcompany_No, provinceID, amphuresID, districtsID, address)
                                    VALUES(:companyName, :tell, :registcompany_No, :provinceID, :amphuresID, :districtsID, :address)");
        $stmt_com->bindParam(':companyName', $CompanyName);
        $stmt_com->bindParam(':tell', $MobileCompany);
        $stmt_com->bindParam(':registcompany_No', $RegistcompanyNo);
        $stmt_com->bindParam(':provinceID', $provinceID);
        $stmt_com->bindParam(':amphuresID', $amphuresID);
        $stmt_com->bindParam(':districtsID', $districtsID);
        $stmt_com->bindParam(':address', $address);
        $stmt_com->execute();

        if($stmt_com){
            echo json_encode(array("status" => "Success", "msg" => "success Server"));
            try{
                $stmt_com_last_insert = $conn->query("SELECT * FROM company WHERE companyID = (SELECT LAST_INSERT_ID())");
                $stmt_com_last_insert->execute();
                $row = $stmt_com_last_insert->fetch(PDO::FETCH_ASSOC);

                if($stmt_com_last_insert){
                    echo json_encode(array("status" => "Success", "msg" => $row['companyID']));
                    $CompanyID = $row['companyID'];
                    try{
                        $stmt_ag = $conn->prepare("UPDATE agents SET agentsName = '$firstName', agentsLastname = '$lastName', phone = '$mobileAgent', companyID = $CompanyID, status = '1' WHERE agentsID = $ag_id");
                        $stmt_ag->execute();

                        if($stmt_ag){
                            echo json_encode(array("status" => "Success", "msg" => "update data success"));
                        } else {
                            echo json_encode(array("status" => "Success", "msg" => "update data error"));
                        }
                    }catch(PDOException $e){
                        echo json_encode(array("status" => "Error", "msg" => $e->getMessage()));
                    }
                } else {
                    echo json_encode(array("status" => "Error", "msg" => "erorr select lastID"));
                }
            }catch(PDOException $e){
                echo json_encode(array("status" => "Error", "msg" => $e->getMessage()));
            }
        } else {
            echo json_encode(array("status" => "Error", "msg" => "error insert data company"));
        }
   }catch(PDOException $e){
        echo json_encode(array("status" => "Error", "msg" => $e->getMessage()));
   }
} else {
    echo json_encode(array("status" => "Error", "msg" => "Error Server"));
}

?>