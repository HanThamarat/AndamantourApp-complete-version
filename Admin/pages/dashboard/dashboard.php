<?php
    session_start();
    include_once '../../../sql/connect.php';
    include_once '../../../includes/domain.php';

 

    if(!isset($_SESSION['admin_login'])){
        $_SESSION['error'] = "Please login";
        header("location: {$domain}Admin/login.php");
    }
    $ad_id = $_SESSION['admin_login'];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Dashboard</title>
    <link rel="stylesheet" href="../../assets/Styles/dash_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <style>
        .table-card{
            margin-top: 20px;
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
        }

        .table-card {
            background: #fff;
            margin-top: 20px;
            border-radius: 10px;
            padding: 2rem;
        }

        .table-container {
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #004AAD;
            color: #fff;
        }

        th {
            padding: 15px;
            text-align: center;
        }

        tbody{
            background: #f2f2f2;
        }

        th, td {
            padding: 15px;
            text-align: center;
        }

        tr:nth-child(even) {
            background: #fff;
        }

        tfoot {
            background: #004AAD;
            font-weight: bold;
            color: #fff;
        }

        tfoot td {
            color: green;
            background: none;
        }
    </style>
    <?php include_once("../../includes/sidebar.php")?>
    <div class="main-container">
        <div class="header">
            <div class="header-title">
                <?php
                    if(isset($_SESSION['admin_login'])){
                        $admin_id = $_SESSION['admin_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $admin_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Admin Dashboard</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=$ad_id"?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt=""></a>
            </div>
        </div>
        
        <div class="card-container">
            <H3 class="main-title">Today's data</H3>
            <div class="card-wapper">
                <div class="agent-card">
                    <div class="card-header">
                        <div class="amout">
                            <?php
                                $stmt = $conn->prepare("SELECT COUNT(packID) as allPackage FROM packages");
                                $stmt->execute();
                                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                            ?>
                            <span class="title">All package</span>
                            <span class="amout-value"><?php echo $row['allPackage']?></span>
                        </div>
                        <div class="icon"><i class="fa-solid fa-clipboard"></i></div>
                    </div>
                </div>

                <div class="agent-card">
                    <div class="card-header">
                        <div class="amout">
                            <?php
                                $stmt = $conn->query("SELECT COUNT(agentsID) as agentSum FROM agents WHERE status = '1' AND role = '0'");
                                $stmt->execute();
                                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                            ?>

                            <span class="title">All agents</span>
                            <span class="amout-value"><?php echo $row['agentSum']; ?></span>
                        
                        </div>
                        <div class="icon"><i class="fa-solid fa-ship"></i></div>
                    </div>
                </div>

                <div class="agent-card">
                    <div class="card-header">
                        <div class="amout">
                            <?php
                                $stmt = $conn->query("SELECT COUNT(reserveID) AS countBooks FROM reserve WHERE status_payment = '1'");
                                $stmt->execute();
                                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                            ?>
                            <span class="title">All bookings</span>
                            <span class="amout-value"><?php echo $row['countBooks']?></span>
                        
                        </div>
                        <div class="icon"><i class="fa-solid fa-person-walking-luggage"></i></div>
                    </div>
                </div>

                <div class="agent-card">
                    <div class="card-header">
                        <div class="amout">
                           <?php
                                $stmt = $conn->query("SELECT COUNT(reserveID) AS countToday FROM `reserve` WHERE DATE_FORMAT(datetime_reserve,'%Y %M %D') = DATE_FORMAT(CURRENT_DATE(),'%Y %M %D')");
                                $stmt->execute();
                                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                            ?>
                            <span class="title">Today's bookings</span>
                            <span class="amout-value"><?php echo $row['countToday']?></span>
                        
                        </div>
                        <div class="icon"><i class="fa-solid fa-clipboard"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-card">
            <div class="main-title">
                <H3>Bookings</H3>
            </div>
            <div class="table-container">
                <table class="myTable stripe">
                    <thead>
                        <?php
                            $stmt = $conn->query("SELECT * ,CONCAT(firstName, ' ', lastName) AS concatName FROM ((reserve INNER JOIN packages ON reserve.packID = packages.packID) INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId) WHERE DATE_FORMAT(datetime_reserve,'%Y %M %D') = DATE_FORMAT(CURRENT_DATE(),'%Y %M %D')");
                            $stmt->execute();
                            $result = $stmt->fetchAll();
                        ?>
                        <tr>
                            <th>Number</th>
                            <th>Booking number</th>
                            <th>Name of person bookings</th>
                            <th>Package Name & type</th>
                            <th>Total price</th>
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
                                <td><?php echo $row['total_price']?></td>
                            </tr>
                            <?php
                                }
                            ?>
                        </tbody>
                    </thead>
                </table>
                <?php
                    $stmt = $conn->query("SELECT SUM(total_price) AS totalPeice FROM reserve INNER JOIN packages ON reserve.packID = packages.packID WHERE DATE_FORMAT(datetime_reserve,'%Y %M %D') = DATE_FORMAT(CURRENT_DATE(),'%Y %M %D')");
                    $stmt->execute();
                    $row = $stmt->fetch(PDO::FETCH_ASSOC);
                ?>
                <div class="main-title">
                    <H3>Total price : <?php echo $row['totalPeice'] ?></H3>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- jquery -->
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.myTable').DataTable();
        })
    </script>
</body>
</html>