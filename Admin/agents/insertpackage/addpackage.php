<?php
    session_start();
    include_once '../../../sql/connect.php';
    include_once '../../../includes/domain.php';

    if(!isset($_SESSION['agents_login'])){
        header("location: {$domain}Admin/login.php");
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Insertpackage</title>
    <link rel="stylesheet" href="addpackage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
</head>
<style>
    .inputEvent {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
    }
    .inputEvent.active .inputBx input {
        background: rgba(0, 0, 0, 0.1);
        pointer-events: none;
    }
    .inputEvents.active input {
        background: rgba(0, 0, 0, 0.1);
        pointer-events: none;
    }
</style>
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
        <div class="package-card">
            <div class="black-page">
                <button><a href="<?php echo "{$domain}Admin/agents/insertpackage/insertpackage.php"?>"><i class="fa-solid fa-arrow-left"></i></a></button>
            </div>
            <div class="main-title">
                <H3 class="">Add new package</H3>
            </div>
            <div class="package-container">
                <form action="addpackage-db.php?id=<?php echo $row['agentsID'];?>" method="POST" enctype="multipart/form-data">
                    <div class="pack-title">
                        <div class="inputBx">
                            <H3>Package Name</H3>
                            <input type="text" name="packname" placeholder="PackageName">
                        </div>
                        <div class="inputBx">
                            <?php
                                $stmt = $conn->query("SELECT * FROM packagestype");
                                $stmt->execute();
                                $result = $stmt->fetchAll();
                            ?>
                            <H3>Type</H3>
                            <select name="Type" id="packType">
                                <option value="">Select Type</option>
                                <?php
                                    foreach($result AS $row){
                                ?>
                                <option value="<?php echo $row['packagesTypeId']?>"><?php echo $row['packagesTypename'] ?></option>
                                <?php
                                    }
                                ?>
                            </select>
                        </div>
                        <div class="inputEvent">
                            <div class="inputBx">
                                <H3>Adult price</H3>
                                <input type="text" name="Price" placeholder="Adult price">
                            </div>
                            <div class="inputBx">
                                <H3>Kid price</H3>
                                <input type="text" name="priceKid" placeholder="Kid price">
                            </div>
                        </div>
                        <div class="inputBx inputEvents">
                            <H3>Charter price</H3>
                            <input type="text" name="priceCharter" placeholder="Charter price">
                        </div>
                    </div>
                    <div class="inputBx">
                            <?php
                                $sl_pv = $conn->query("SELECT * FROM provinces");
                                $sl_pv->execute();
                                $result = $sl_pv->fetchAll()
                            ?>
                            <H3>Location</H3>
                            <select name="location">
                                <option value="">Select Provinces</option>
                                <?php
                                    foreach($result AS $row){
                                ?>
                                <option value="<?php echo $row['id']?>"><?php echo $row['name_en']?></option>
                                <?php
                                    }
                                ?>
                            </select>
                        </div>
                    <div class="pack-deteil">
                        <div class="pack-deteil-name">
                            <H3>Deteil</H3>
                            <textarea name="deteil" id="deteilForm"></textarea>
                            <script>
                                ClassicEditor
                                    .create( document.querySelector( '#deteilForm' ) )
                                    .then( editor => {
                                            console.log( editor );
                                    } )
                                    .catch( error => {
                                            console.error( error );
                                    } );
                            </script>
                        </div>
                    </div>
            </div>
        </div>
        <div class="package-card">
            <div class="main-title">
                <H3>Add package image</H3>
            </div>
            <div class="package-container">
                    <div class="pack-title">
                        <div class="inputBx-image">
                            <H3>Package Image (190 x 120)</H3>
                            <input type="file" name="file" multiple>
                        </div>
                    </div>
                    <div class="pack-next-button">
                        <input id="button" type="submit"  value="Create Now Package" name="upload">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        const packEvent = document.getElementById('packType');
        const InputCharter = document.querySelector('.inputEvents');
        const Inputs = document.querySelector('.inputEvent');
        
        packEvent.addEventListener("change", function() {
            if(packEvent.value == 1) {
                Inputs.classList.add("active");
                InputCharter.classList.remove("active");
            } else if(packEvent.value == 2){
                InputCharter.classList.add("active");
                Inputs.classList.remove("active");
            } else {
                Inputs.classList.remove("active");
                InputCharter.classList.remove("active");
            }
        })
    </script>
</body>
</html>