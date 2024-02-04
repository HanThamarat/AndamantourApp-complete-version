<?php
    session_start();
    include_once('../../../../sql/connect.php');
    include_once('../../../../includes/domain.php');

    
    if(!isset($_GET['id']) || !isset($_GET['reserveID'])) {
        header("location: {$domain}Admin/login.php");
    }

    $ad_id = $_GET['id'];
    $reserveID = $_GET['reserveID'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | BookingDetail</title>
    <link rel="stylesheet" href="reserveDetail.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
</head>
<body>
    <style>
        .img-container img {
            width: 350px;
            padding: 20px;
            background: #ffebeb;
            border-radius: 10px;
        }
        
        .data-reserve {
            width: 100%;
            padding: 2rem;
            background: #ffebeb;
            border-radius: 10px;
        }

        .reserve-data {
            margin-top: 10px;
            justify-content: space-between;
            width: 100%;
            display: flex;
            gap: 1rem;
        }

        .bookingID {
            margin-top: 5px;
        }

        .data-in {
            margin-top: 5px;
        }

        .data-reserve .title {
            display: flex;
        }

        .data-reserve i{
            font-size: 20px;
            margin-right: 10px;
        }

        .data-in span{
            margin-left: 5px;
            font-size: 18px;
            font-weight: 500;
        }

        .data-in-last {
            margin-top: 5px;
            margin-bottom: 20px;
        }

        .data-in-last span{
            margin-left: 5px;
            font-size: 18px;
            font-weight: 500;
        }

        .data-total {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn-con {
            border: none;
            padding: 10px;
            border-radius: 5px;
            background: #03045e;
            transition: all 0.2s ease;
            color: #fff;
            font-size: 14px;
            font-weight: 500;
        }


        .btn-con i {
           font-size: 14px;
           margin-right: 5px;
        }

        .btn-con:hover {
            background: #023e8a;
        }
    </style>
    <?php include_once("../../../includes/sidebar.php")?>
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
                    if(isset($_SESSION['admin_login'])){
                        $ad_id = $_SESSION['admin_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $ad_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Admin Manage Bookings</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=" . $row['agentsID']?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile"></a>
            </div>
        </div>
        <div class="reserve-card">
            <?php
                $stmt = $conn->query("SELECT * ,CONCAT(firstName, ' ', lastName) AS concatName FROM ((reserve INNER JOIN packages ON reserve.packID = packages.packID) INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId) WHERE reserveID = $reserveID");
                $stmt->execute();
                $row = $stmt->fetch(PDO::FETCH_ASSOC);
            ?>
            <div class="main-title">
                <H3>Booking detail</H3>
                <H4 class="bookingID">bookingID : <?php echo $row['reserveID'] ?></H4>
            </div>
            <div class="reserve-data">
                <div class="img-container">
                    <img src="<?php echo "{$dataUser}paymentImage/" . $row['image_payment'] ?>" alt="">
                </div>
                <div class="data-reserve">
                    <div class="title">
                        <i class="fa-solid fa-person-walking-luggage"></i>
                        <H3>Contact information :</H3>
                    </div>
                    <div class="data-in">
                        <span>Name of person booking : <?php echo $row['concatName']?></span>
                    </div>
                    <div class="data-in">
                        <span>Email : <?php echo $row['email']?></span>
                    </div>
                    <div class="data-in">
                        <span>Phone number : <?php echo $row['Phone_number']?></span>
                    </div>
                    <div class="data-in-last">
                        <span>Location hotel : <?php echo $row['location_hotel']?></span>
                    </div>

                    <div class="title">
                        <i class="fa-solid fa-ship"></i>
                        <H3>Booking detail :</H3>
                    </div>
                    <div class="data-in">
                        <span>Travel day : <?php echo $row['date_travel']?></span>
                    </div>
                    <?php
                        if($row['quantity_adult'] == 0 || $row['quantity_child'] == 0 ) {
                    ?>
                    <div class="data-in">
                        <span>Number of adults : <?php echo $row['packagesTypename']?></span>
                    </div>
                    <?php
                        } else {
                    ?>
                    <div class="data-in">
                        <span>Number of adults : <?php echo $row['quantity_adult']?></span>
                    </div>
                    <div class="data-in">
                        <span>Number of childs : <?php echo $row['quantity_child']?></span>
                    </div>
                    <?php
                        }
                    ?>
                    <div class="data-in">
                        <span>Location hotel : <?php echo $row['location_hotel']?></span>
                    </div>

                </div>
                <div class="data-reserve">
                    <div class="title">
                        <i class="fa-solid fa-building-columns"></i>
                        <H3>Bank detail :</H3>
                    </div>
                    <div class="data-in">
                        <span>Bank name : <?php echo $row['bank_name']?></span>
                    </div>
                    <div class="data-in">
                        <span>Bank number : <?php echo $row['bank_number']?></span>
                    </div>
                    <div class="data-in">
                        <span>Name matching bank account number : <?php echo $row['bank_FirstLast_name']?></span>
                    </div>
                </div>
            </div>
            <div class="data-total">
                <div class="main-title">
                    <H3>Total price : <?php echo $row['total_price']?></H3>
                </div>
                <button class="btn-con" data-id="<?php echo $reserveID ?>">
                    <i class="fa-solid fa-check"></i>
                    Refund
                </button>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script>
          $('.btn-con').click(function(e) {
            e.preventDefault();
            var Id = $(this).data('id');

            updatestatusConfirm(Id); //post paraiter to updatestatusConfirm
        })
            
            function updatestatusConfirm(Id) { // function updatestatusConfirm get variable paramiter 2  paramiter
                Swal.fire({
                    title: 'Are you Sure?',
                    text: 'Are you sure you want to Cancel booking it or not?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Cancel it!',
                    preConfirm: function() {
                        return new Promise(function(resolve) {
                            $.ajax({
                                url: '<?php echo "{$domain}Admin/pages/reserve/cancelBooking/cancelDb.php"?>',
                                type: 'GET',
                                data: {
                                    'id': Id,
                                },
                                success: function(response) {
                                    if(response === 200) {
                                        console.log('success');
                                    }else if(response === 500) {
                                        console.log('error');
                                    }
                                }
                            }).done(function() {
                                Swal.fire({
                                    title: 'success',
                                    text: 'Cancel booking successfully!',
                                    icon: 'success'
                                }).then(() => {
                                    document.location.href = '<?php echo "{$domain}Admin/pages/reserve/cancelBooking/calelBooking.php"?>'
                                })
                            }).fail(function() {
                                Swal.fire('Oops...', 'Something went wrong with ajex!', 'error');
                                window.location.reload
                            })
                        })
                    }
                })
            }
    </script>
</body>
</html>