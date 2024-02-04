<?php
    session_start();
    include_once "../../../sql/connect.php";
    include_once "../../../includes/domain.php";

    if(!isset($_GET['id'])){
        header("location: {$domain}Admin/login.php");
    }
    $id = $_GET['id'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | EditProfile</title>
    <link rel="stylesheet" href="select_style.css">
</head>
<body>
    <form method="POST" action="save_img.php?id=<?php echo $id?>" enctype="multipart/form-data">
    <div class="hero">
        <div class="card">
               <?php
                    if(isset($_GET['id'])){
                        $id = $_GET['id'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                   }
               ?>
            <h1><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></h1>
            <p><?php echo $row['agnetsEmail'];?></p>
            <img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile" id="profile-pic">
            <label for="input-file">Change Profile</label>
            <input type="file" id="input-file" name="file">
            <button>Update Profile<input type="summit" name="Update"></button>
        </div>
    </div>
    </form>
    <script>
        let profilePic = document.getElementById("profile-pic");
        let inputFile = document.getElementById("input-file");

        inputFile.onchange = function(){
            profilePic.src = URL.createObjectURL(inputFile.files[0]);
        }
    </script>
</body>
</html>