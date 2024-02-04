<?php
    require_once("../../../sql/connect.php");
    include_once("../../../includes/domain.php");

    $ag_id = $_GET['id'];
    $packID = $_GET['packID'];
    
    $proName = $_POST['PromotionName'];
    $proCharter = $_POST['ProCharter'];
    $proAdult = $_POST['ProAdult'];
    $proChild = $_POST['ProChild'];
    $proStarting = $_POST['ProStarting'];
    $proEnd = $_POST['ProEnd'];

    $stmt = $conn->query("SELECT packages.packtypeID, packagestype.packagesTypename FROM packages INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId WHERE packages.packID = $packID");
    $stmt->execute();
    $pk_ty = $stmt->fetch(PDO::FETCH_ASSOC);

    if($pk_ty['packtypeID'] == 1) {
        if($_SERVER['REQUEST_METHOD'] == "POST"){
            if(!$proName){
                echo json_encode(array("status" => "Error", "msg" => "Promotion name is required"));
            } else if (!$proCharter) {
                echo json_encode(array("status" => "Error", "msg" => "Promotion charter boat is required"));
            } else if (!$proStarting) {
                echo json_encode(array("status" => "Error", "msg" => "Starting day promotiont is required"));
            } else if (!$proEnd) {
                echo json_encode(array("status" => "Error", "msg" => "End day promotiont is required"));
            } else {
            try{
                $in_pro = $conn->prepare("INSERT INTO promotion_package(packID, promotion_Name, promotionPrice_charterBoat, promotionStart_date, promotionEnd_date)
                                        VALUES (:packID, :promotion_Name,  :promotionPrice_charterBoat, :promotionStart_date, :promotionEnd_date)");
                $in_pro->bindParam(':packID',$packID);
                $in_pro->bindParam(':promotion_Name',$proName);
                $in_pro->bindParam(':promotionPrice_charterBoat',$proCharter);
                $in_pro->bindParam(':promotionStart_date',$proStarting);
                $in_pro->bindParam(':promotionEnd_date',$proEnd);
                $in_pro->execute();
                if($in_pro){
                    echo json_encode(array("status" => "Success", "msg" => "add Promotion success charter"));
                } else {
                    echo json_encode(array("status" => "Error", "msg" => "add Promotion error"));
                }
            }catch(PDOException $e){
                echo json_encode(array("status" => "Error", "msg" => $e->getMessage()));
            }
            } 
        }
    } else {
        if($_SERVER['REQUEST_METHOD'] == "POST"){
            if(!$proName){
                echo json_encode(array("status" => "Error", "msg" => "Promotion name is required"));
            } else if (!$proStarting) {
                echo json_encode(array("status" => "Error", "msg" => "Starting day promotiont is required"));
            } else if (!$proEnd) {
                echo json_encode(array("status" => "Error", "msg" => "End day promotiont is required"));
            } else if (!$proAdult) {
                echo json_encode(array("status" => "Error", "msg" => "Promotion price adult is required"));
            } else if (!$proChild) {
                echo json_encode(array("status" => "Error", "msg" => "Promotion price child is required"));
            } else {
            try{
                $in_pro = $conn->prepare("INSERT INTO promotion_package(packID, promotion_Name, promotionPrice_Adult, promotionPrice_Child, promotionStart_date, promotionEnd_date)
                                        VALUES (:packID, :promotion_Name, :promotionPrice_Adult, :promotionPrice_Child, :promotionStart_date, :promotionEnd_date)");
                $in_pro->bindParam(':packID',$packID);
                $in_pro->bindParam(':promotion_Name',$proName);
                $in_pro->bindParam(':promotionPrice_Adult',$proAdult);
                $in_pro->bindParam(':promotionPrice_Child',$proChild);
                $in_pro->bindParam(':promotionStart_date',$proStarting);
                $in_pro->bindParam(':promotionEnd_date',$proEnd);
                $in_pro->execute();
                if($in_pro){
                    echo json_encode(array("status" => "Success", "msg" => "add Promotion success"));
                } else {
                    echo json_encode(array("status" => "Error", "msg" => "add Promotion error"));
                }
            }catch(PDOException $e){
                echo json_encode(array("status" => "Error", "msg" => $e->getMessage()));
            }
        }
        }
    }
?>