<?php
    session_start();
    include_once('../../../sql/connect.php');
    include_once('../../../includes/domain.php');

    if(!isset($_SESSION['agents_login'])){
        header("location: {$domain}Admin/login.php");
    }

    $ag_id = $_SESSION['agents_login'];

    if(isset($_SESSION['agents_login'])) {
        try{
            $check_verifi = $conn->query("SELECT status, is_verify FROM agents WHERE agentsID = $ag_id");
            $check_verifi->execute();
            $result = $check_verifi->fetch(PDO::FETCH_ASSOC);
            
            if($result['status'] == 0) {
                $_SESSION['verifi'] = "Please fill in basic information.";
                header("location: {$domain}Admin/agents/dashboard.php");
            }

            if($result['is_verify'] == 0) {
                $_SESSION['verifi'] = "Please verifycation in email.";
                header("location: {$domain}Admin/agents/dashboard.php");
            }
        }catch(PDOException $e){
            echo $e->getMessage();
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Promotion</title>
    <link rel="stylesheet" href="showPromotion.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
</head>
<body>
<?php include_once("../includes/sidebar.php")?>
    <div class="main-container">
        <div class="alert">
                <?php if(isset($_SESSION['error'])) { ?>
                    <div class="error-alert" role="alert">
                        <?php 
                            echo $_SESSION['error'];
                            unset($_SESSION['error']);
                        ?>
                    </div>
                <?php } ?>
                <?php if(isset($_SESSION['success'])) { ?>
                    <div class="suscess-alert" role="alert">
                        <?php 
                            echo $_SESSION['success'];
                            unset($_SESSION['success']);
                        ?>
                    </div>
                <?php } ?>
        </div>
        <div class="header">
            <div class="header-title">
                <?php
                    if(isset($_SESSION['agents_login'])){
                        $agents_id = $_SESSION['agents_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $agents_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Agent Manage package</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=" . $row['agentsID']?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile"></a>
            </div>
        </div>
        <div class="table-card">
            <div class="main-title">
                <H3>Packages</H3>
                <button><a href="<?php echo "{$domain}Admin/agents/insertpackage/addpackage.php"?>">Add New package</a></button>
            </div>
            <div class="table-container">
                <table class="myTable stripe">
                    <thead>
                        <?php
                            $stmt = $conn->query("SELECT packages.*, packagestype.packagesTypename FROM packagestype INNER JOIN packages ON packagestype.packagesTypeId = packages.packtypeID WHERE packages.agents_ID = $ag_id ORDER BY packID ASC");
                            $stmt->execute();
                            $result = $stmt->fetchAll();
                        ?>
                        <tr>
                            <th>Number</th>
                            <th>Package Name</th>
                            <th>Package Type</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Promotion</th>
                        </tr>
                        <tbody>
                            <?php
                                $n = 1;
                                foreach($result AS $row){ //foreach การ loop data
                                $packID = $row['packID'];
                            ?>
                            <tr>
                                <td><?php echo $n++; ?></td>
                                <td><?php echo $row['packName']; ?></td>
                                <td><?php echo $row['packagesTypename']; ?></td>
                                <td>
                                <?php
                                    if($row['packPrice'] == null){
                                ?>        
                                        <p>Charter price : <?php echo $row['priceCharter'];?></p>
                                <?php 
                                    } else {
                                ?>
                                    <p>Adult price : <?php echo $row['packPrice'];?></p>
                                    <p>Child price : <?php echo $row['ticketKid'];?></p>
                                <?php
                                    }
                                ?>
                                </td>
                                <td><?php if($row['status'] == 1){
                                    echo '<i class="fa-solid fa-circle" style="color: #ffff00;"></i> ONLINE';
                                }else{
                                    echo '<i class="fa-solid fa-circle" style="color: #323232;"></i> OFFLINE';
                                } ?></td>
                                <td>
                                    <button><a href="<?php echo "{$domain}Admin/agents/promotion/addPromotion.php?id=$ag_id&packID=$packID"?>">Add Promotion</a></button>
                                </td>
                            </tr>
                            <?php
                                }
                            ?>
                        </tbody>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.myTable').DataTable();
        })
    </script>
</body>
</html>