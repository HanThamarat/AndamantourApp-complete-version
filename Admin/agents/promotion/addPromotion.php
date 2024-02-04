<?php
    session_start();
    include_once('../../../sql/connect.php');
    include_once('../../../includes/domain.php');
    if(!isset($_GET['id']) || !isset($_GET['packID'])) {
        header("location: {$domain}Admin/login.php");
    }
    $ag_id = $_GET['id'];
    $packID = $_GET['packID'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | AddPromotion</title>
    <link rel="stylesheet" href="Addpro.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <style>
        
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
        <div class="input-card">
            <div class="main-title">
                <H3>Promotion package</H3>
            </div>
            <div class="input-container">
                <form method="POST" id="form-insert">
                <!-- <form action="<//?php echo "{$domain}Admin/agents/promotion/proAdd-db.php?id=$ag_id&packID=$packID"?>" method="POST" id="form-insert"> -->
                <div class="form">
                    <div class="row">
                        <div class="inputBx">
                            <span>Promotion name</span>
                            <input type="text" name="PromotionName" id="ProName">
                            <div class="errors"></div>
                        </div>
                            <?php
                                $stmt = $conn->query("SELECT packages.packtypeID, packagestype.packagesTypename FROM packages INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId WHERE packages.packID = $packID");
                                $stmt->execute();
                                $pk_ty = $stmt->fetch(PDO::FETCH_ASSOC);
                            ?>

                            <?php
                                if($pk_ty['packtypeID'] == 1) {
                            ?>  
                                <div class="inputBx">
                                <span>promotion Charter</span>
                                <input type="text" name="ProCharter" id="ProCharter">
                                <div class="errors"></div>
                                </div>
                            <?php
                                } else {
                            ?>
                                <div class="inputBx">
                                    <span>promotion Adult</span>
                                    <input type="text" name="ProAdult" id="ProAdult">
                                    <div class="errors"></div>
                                </div>
                                <div class="inputBx">
                                    <span>promotion Child</span>
                                    <input type="text" name="ProChild" id="ProChild">
                                    <div class="errors"></div>
                                </div>
                            <?php
                                }
                            ?>
                    </div>
                    <div class="inputBx">
                        <span>Starting day promotiont</span>
                        <input type="date" name="ProStarting" id="ProStarting">
                        <div class="errors"></div>
                    </div>
                    <div class="inputBx">
                        <span>End day promotiont</span>
                        <input type="date" name="ProEnd" id="ProEnd">
                        <div class="errors"></div>
                    </div>
                </div>
                <div class="btn-submit">
                    <button class="transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-70 duration-300 ..."><input type="submit" value="Add Promotion"></button>          
                    <!-- <button onclick="saveData()">Add Promotion</button>           -->
                    
                </div>
                </form>
            </div>
        </div>
        <div class="listPro">
        <div class="main-title">
            <H3>Promotion List</H3>
        </div>
        <div class="table-container ">
                <table class="dataTable w-full text-sm text-left rtl:text-right text-gray-500 dark:text-black">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-white">
                        <?php
                            $stmt = $conn->query("SELECT * FROM `promotion_package` WHERE packID = $packID");
                            $stmt->execute();
                            $result = $stmt->fetchAll();
                        ?>
                        <?php
                            if($pk_ty['packtypeID'] == 1) {
                        ?>
                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                <th>Number</th>
                                <th>Promotion Name</th>
                                <th>Promotion charter boat</th>
                                <th>Starting day promotiont</th>
                                <th>End day promotiont</th>
                            </tr>
                            <tbody>
                                <?php
                                    $n = 1;
                                    foreach($result AS $row){ //foreach การ loop data
                                ?>
                                <tr>
                                    <td><?php echo $n++; ?></td>
                                    <td><?php echo $row['promotion_Name']; ?></td>
                                    <td><?php echo $row['promotionPrice_charterBoat']; ?></td>
                                    <td><?php echo $row['promotionStart_date']; ?></td>
                                    <td><?php echo $row['promotionEnd_date']; ?></td>
                                </tr>
                                <?php
                                    }
                                ?>
                            </tbody>
                        <?php
                            } else {
                        ?>
                        <tr>
                            <th>Number</th>
                            <th>Promotion Name</th>
                            <th>Promotion adult</th>
                            <th>Promotion child</th>
                            <th>Starting day promotiont</th>
                            <th>End day promotiont</th>
                        </tr>
                        <tbody>
                            <?php
                                $n = 1;
                                foreach($result AS $row){ //foreach การ loop data
                            ?>
                            <tr>
                                <td><?php echo $n++; ?></td>
                                <td><?php echo $row['promotion_Name']; ?></td>
                                <td><?php echo $row['promotionPrice_Adult']; ?></td>
                                <td><?php echo $row['promotionPrice_Child']; ?></td>
                                <td><?php echo $row['promotionStart_date']; ?></td>
                                <td><?php echo $row['promotionEnd_date']; ?></td>
                            </tr>
                            <?php
                                }
                            ?>
                        </tbody>
                        <?php
                            }
                        ?>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script>

        $(document).ready(function() {
            $(".dataTable").DataTable();
            $("#form-insert").submit(function (e) {
                e.preventDefault();

            let formUrl = $(this).attr("action");
            let reqMethod = $(this).attr("method");
            let formData = $(this).serialize();

            if(validate()){
                Swal.fire({
                    title: 'Are you Sure?',
                    text: 'Are you sure you want to Add Promotion it or not?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Add Promotion it!',
                    preConfirm: function() {
                        return new Promise(function(resolve) {
                            $.ajax({
                            url: "<?php echo "{$domain}Admin/agents/promotion/proAdd-db.php?id=$ag_id&packID=$packID"?>",
                            type: reqMethod,
                            data: formData,
                            success: function(response) {
                                if(response === 200) {
                                    console.log("Success",response)
                                } else {
                                    console.log("Error",response)
                                }
                            }
                        }).done(function() {
                                Swal.fire({
                                    title: 'success',
                                    text: 'Add Promotion successfully!',
                                    icon: 'success'
                                }).then(() => {
                                    document.location.href = '<?php echo "{$domain}Admin/agents/promotion/addPromotion.php?id=$ag_id&packID=$packID"?>'
                                })
                            }).fail(function() {
                                Swal.fire('Oops...', 'Something went wrong with ajex!', 'error');
                                window.location.reload
                            })
                        })
                    }
                })
            }

            })
        })

        function validate() {
            let pass = true
            const proName = document.getElementById("ProName"); 
            const proCharter = document.getElementById("ProCharter");
            const proAdult = document.getElementById("ProAdult");
            const proChild = document.getElementById("ProChild");
            const proStarting = document.getElementById("ProStarting");
            const proEnd = document.getElementById("ProEnd");

            if(proCharter === null) {
                    if(proName.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Promotion name',
                        text: 'Promotion name is required'
                    })
                }  else if (proAdult.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Promotion price adult',
                        text: 'Promotion price adult is required'
                    })
                } else if (proChild.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Promotion price child',
                        text: 'Promotion price child is required'
                    })
                } else if (proStarting.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Starting day promotiont',
                        text: 'Starting day promotiont is required'
                    })
                } else if (proEnd.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'End day promotiont',
                        text: 'End day promotiont is required'
                    })
                }
            } else {
                    if(proName.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Promotion name',
                        text: 'Promotion name is required'
                    })
                }  else if (proCharter.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Promotion charter',
                        text: 'Promotion charter boat is required'
                    })
                } else if (proStarting.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'Starting day promotiont',
                        text: 'Starting day promotiont is required'
                    })
                } else if (proEnd.value.length <= 0) {
                    pass = false
                    Swal.fire({
                        icon: 'error',
                        title: 'End day promotiont',
                        text: 'End day promotiont is required'
                    })
                }  
            }
            
          return pass 
        }
    </script>
</body>
</html>