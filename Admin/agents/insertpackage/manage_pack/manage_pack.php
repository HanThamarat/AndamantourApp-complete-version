<?php
    session_start();
    include_once '../../../../sql/connect.php';
    include_once '../../../../includes/domain.php';
    $pack_id = $_GET['id'];
    if(!isset($_SESSION['agents_login'])){
        header("location: {$domain}Admin/login.php");
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Managepackage</title>
    <link rel="stylesheet" href="managePack.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
</head>
<body>
    <?php include_once("../../includes/sidebar.php")?>
    <div class="main-container">
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
        <div class="package-card">
            <div class="black-page">
                <button><a href="<?php echo "{$domain}Admin/agents/insertpackage/insertpackage.php"?>"><i class="fa-solid fa-arrow-left"></i></a></button>
            </div>
            <div class="main-title">
                <H3>Edit package</H3>
            </div>
            <div class="packID-title">
                <H5>packageID : <?php echo $pack_id; ?></H5>
            </div>
            <div class="package-container">
                <form action="manage_save.php?id=<?php echo $pack_id?>" method="POST" enctype="multipart/form-data" class="form">
                    <?php
                        $stmt = $conn->query("SELECT packages.priceCharter ,packages.packName, packages.packPrice, packages.promotion, packages.packtypeID, packages.ticketKid, packagestype.* FROM packages INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId WHERE packID = $pack_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    ?>
                                        <?php
                        if($row['packtypeID'] == 1) {
                    ?>
                        <div class="pack-title">
                                <div class="inputBx">
                                    <H3>Package Name</H3>
                                    <input type="text" name="packname" placeholder="PackageName" value="<?php echo $row['packName']?>">
                                </div>
                                <div class="inputBx">
                                    <H3>Type</H3>
                                    <input class="packtype" type="text" name="" placeholder="Adult price" value="<?php echo $row['packagesTypename']?>" readonly>
                                </div>
                                <div class="inputBx">
                                    <H3>Adult price</H3>
                                    <input type="text" name="priceCharter" placeholder="Adult price" value="<?php echo $row['priceCharter']?>">
                                </div>
                        </div>
                    <?php
                        } else {
                    ?>
                        <div class="pack-title">
                            <div class="row-input">
                                <div class="inputBx">
                                    <H3>Package Name</H3>
                                    <input type="text" name="packname" placeholder="PackageName" value="<?php echo $row['packName']?>">
                                </div>
                                <div class="inputBx">
                                    <H3>Type</H3>
                                    <input class="packtype" type="text" name="" placeholder="Adult price" value="<?php echo $row['packagesTypename']?>" readonly>
                                </div>
                            </div>
                            <div class="row-input">
                                <div class="inputBx">
                                    <H3>Adult price</H3>
                                    <input type="text" name="Price" placeholder="Adult price" value="<?php echo $row['packPrice']?>">
                                </div>
                            </div>
                            
                            <div class="row-input">
                                <div class="inputBx">
                                    <?php
                                        $stmt = $conn->query("SELECT packages.ticketKid FROM packages INNER JOIN packagestype ON packages.packtypeID = packagestype.packagesTypeId WHERE packID = $pack_id");
                                        $stmt->execute();
                                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                                    ?>
                                    <H3>Kid price</H3>
                                    <input type="text" name="priceKid" placeholder="Kid price" value="<?php echo $row['ticketKid']?>">
                                </div>
                            </div>
                        </div>
                    <?php
                        }
                    ?>
                    <div class="pack-deteil">
                        <div class="pack-deteil-name">
                            <?php
                                $show_deteil = $conn->query("SELECT packDeteil FROM packages WHERE packID = $pack_id");
                                $show_deteil->execute();
                                $row = $show_deteil->fetch(PDO::FETCH_ASSOC);
                            ?>
                            <H3>Deteil</H3>
                            <textarea name="deteil" id="deteilForms"><?php echo $row['packDeteil']?></textarea>
                            <script>
                                ClassicEditor
                                    .create( document.querySelector( '#deteilForms' ) )
                                    .then( editor => {
                                            console.log( editor );
                                    } )
                                    .catch( error => {
                                            console.error( error );
                                    } );
                            </script>
                        </div>
                    </div>
                    <div class="pack-next-button">
                        <input id="button" type="submit"  value="Save" name="save">
                    </div>
                </form>
            </div>
        </div>
        <div class="package-card">
            <div class="main-title">
                <H3>Edit image</H3>
            </div>
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
            <div class="package-container">
                <form action="manage_save.php?id=<?php echo $pack_id?>" method="POST" enctype="multipart/form-data">
                    <div class="pack-title">
                        <div class="inputBx-name">
                            <H3>Package Image (190 x 120)</H3>
                            <input type="file" name="file" multiple>
                        </div>
                    </div>
                    <div class="show-image">
                        <?php
                            $pk_img = $conn->query("SELECT image FROM packages WHERE packID = $pack_id");
                            $pk_img->execute();
                            $row = $pk_img->fetch(PDO::FETCH_ASSOC);
                        ?>
                        <img src="<?php echo "{$domain}Admin/agents/insertpackage/pack_img/" . $row['image']?>" alt="">
                    </div>
                    <div class="pack-next-button">
                        <input id="button" type="submit"  value="Save" name="save_image">
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>