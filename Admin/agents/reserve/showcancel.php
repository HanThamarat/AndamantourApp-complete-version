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
    <title>AndamanTour | Booking</title>
    <link rel="stylesheet" href="cancelStyle.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
</head>
<body>
    <style>
        .detail-btn {
            border: none;
            padding: 10px;
            border-radius: 5px;
            background: #03045e;
            transition: all 0.2s ease;
        }

        .detail-btn a {
           text-decoration: none;
           color: #fff;
           font-size: 14px;
           font-weight: 600;
        }

        .detail-btn i {
           font-size: 14px;
        }

        .detail-btn:hover {
            background: #023e8a;
        }
    </style>
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
                        $ag_id = $_SESSION['agents_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $ag_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Agent bookings</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=" . $row['agentsID']?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile"></a>
            </div>
        </div>
        <div class="table-card">
            <div class="main-title">
                <H3>Cancel Bookings</H3>
            </div>
            <div class="table-container">
                <table class="myTable stripe">
                    <thead>
                        <?php
                            $stmt = $conn->query("SELECT * ,CONCAT(firstName, ' ', lastName) AS concatName FROM ((reserve INNER JOIN packages ON reserve.packID = packages.packID) INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId) WHERE agents_ID = $ag_id AND date_travel >= CURRENT_DATE() AND status_payment = '1' AND status_cancel = '2' ORDER BY date_travel ASC");
                            $stmt->execute();
                            $result = $stmt->fetchAll();
                        ?>
                        <tr>
                            <th>Number</th>
                            <th>Booking number</th>
                            <th>Name of person bookings</th>
                            <th>Package Name & type</th>
                            <th>Travel day</th>
                            <th>Total price</th>
                            <th>Detail</th>
                        </tr>
                        <tbody>
                            <?php
                                $n = 1;
                                foreach($result AS $row){ //foreach การ loop data
                                $reserveID = $row['reserveID'];
                            ?>
                            <tr>
                                <td><?php echo $n++; ?></td>
                                <td><?php echo $row['reserveID']; ?></td>
                                <td><?php echo $row['concatName']; ?></td>
                                <td>
                                    <p>PackageName : <?php echo $row['packName']; ?></p>
                                    <p>PackageType : <?php echo $row['packagesTypename']; ?></p>
                                </td>
                                <td><?php echo $row['date_travel']?></td>
                                <td><?php echo $row['total_price']?></td>
                                <td>
                                    <button class="detail-btn">
                                        <a href="<?php echo "{$domain}Admin/agents/reserve/reserveDetail.php?id=$ag_id&reserveID=$reserveID"?>">
                                            <i class="fa-solid fa-person-walking-luggage"></i>
                                            bookingDetail
                                        </a>
                                    </button>
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