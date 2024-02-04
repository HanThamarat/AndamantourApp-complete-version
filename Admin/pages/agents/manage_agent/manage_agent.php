<?php
    session_start();
    include_once '../../../../sql/connect.php';
    include_once '../../../../includes/domain.php';

    
    $ag_id = $_GET['id'];
    if(!isset($_SESSION['admin_login'])){
        header("location: {$domain}Admin/login.php");
  }

  $ad_id = $_SESSION['admin_login'];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Manageagent</title>
    <link rel="stylesheet" href="manageAgent.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
</head>
<body>
    <style>
        .inputBx [placeholder="Email"] {
            padding-left: 10px;
            background: rgb(220,220,220, 0.5);
        }

        .inputBx input:focus{
            border-color: rgba(3, 102, 214, 0.7);
            box-shadow: rgba(3, 102, 214, 0.3) 0px 0px 0px 2px;
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
                        $admin = $_SESSION['admin_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $admin");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Admin Manage package</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=" . $row['agentsID']?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile"></a>
            </div>
        </div>
        <div class="package-card">
            <div class="black-page">
                <button><a href="<?php echo "{$domain}Admin/pages/agents/showAgents.php"?>"><i class="fa-solid fa-arrow-left"></i></a></button>
            </div>
            <div class="main-title">
                <H3>Edit agent</H3>
            </div>
            <div class="packID-title">
                <H5>packageID : <?php echo $ag_id; ?></H5>
            </div>
            <div class="package-container">
                <form action="manege_agent_save.php?id=<?php echo $ag_id?>" method="POST" id="form">
                    <?php
                        $stmt = $conn->query("SELECT * FROM agents INNER JOIN company ON agents.companyID = company.companyID WHERE agentsID = $ag_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                        ?>
                        <div class="pack-title">
                            <div class="row-input">
                                <div class="inputBx">
                                    <H3>First name</H3>
                                    <input type="text" id="firstname" name="firstname" placeholder="firstname" value="<?php echo $row['agentsName']?>">
                                </div>
                                <div class="inputBx">
                                    <H3>Email</H3>
                                    <input type="text" id="email" name="email" placeholder="Email" value="<?php echo $row['agnetsEmail']?>" readonly>
                                </div>
                            </div>
                            <div class="row-input">
                                <div class="inputBx">
                                    <H3>Last name</H3>
                                    <input type="text" id="lastname" name="lastname" placeholder="lastname" value="<?php echo $row['agentsLastname']?>">
                                </div>
                            </div>
                            <div class="row-input">
                                <div class="inputBx">
                                    <H3>Phone number</H3>
                                    <input type="text" id="phonenumber" name="phonenumber" placeholder="Phone number" value="<?php echo $row['phone']?>">
                                </div>
                            </div>
                        </div>
                    <div class="pack-next-button">
                        <input id="button" type="submit"  value="Save" name="save">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
         $(document).ready(function () {
                $("#form").submit(function (e) {
                    e.preventDefault()

                    let formUrl = $(this).attr("action");
                    let reqMethod = $(this).attr("method");
                    let formData = $(this).serialize();

                    if(validate()){
                        Swal.fire({
                            title: 'Are you Sure?',
                            text: 'Are you sure you want to change Agents information it or not?',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, Update it!',
                            preConfirm: function() {
                                return new Promise(function(resolve) {
                                    $.ajax({
                                        url: formUrl,
                                        type: reqMethod,
                                        data: formData,
                                        success: function(response){
                                            if(response.status === 200){
                                                console.log('success');
                                            }else{
                                                console.log('error');
                                            }
                                        }
                                    }).done(function() {
                                        Swal.fire({
                                            title: 'success',
                                            text: 'Update status successfully!',
                                            icon: 'success'
                                        }).then(() => {
                                            document.location.href = '<?php echo "{$domain}/Admin/pages/agents/manage_agent/manage_agent.php?id=$ag_id"?>'
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
                const firstname = document.getElementById("firstname");
                const lastname = document.getElementById("lastname");
                const phonenumber = document.getElementById("phonenumber");


                if(firstname.value.length <= 0){
                    pass = false
                    title = 'Firstname'
                    text = 'Firstname is required'
                    showAlert(title, text)
                } else if(lastname.value.length <= 0) {
                    pass = false
                    title = 'Lastname'
                    text = 'Lastname is required'
                    showAlert(title, text)
                } else if(phonenumber.value.length <= 0) {
                    pass = false
                    title = 'Phone number.'
                    text = 'Mobile No is required'
                    showAlert(title, text)
                }

                return pass
            }


            function showAlert(title, text) {
                Swal.fire({
                        icon: 'error',
                        title: title,
                        text: text
                    })
            }
    </script>
</body>
</html>