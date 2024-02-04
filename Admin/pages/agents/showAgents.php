<?php
    session_start();
    include_once '../../../sql/connect.php';
    include_once '../../../includes/domain.php';

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
    <title>AndamanTour | Insertpackage</title>
    <link rel="stylesheet" href="showAgents.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
</head>
<body>
    <?php include_once("../../includes/sidebar.php")?>
    <div class="main-container">
        <div class="header">
            <div class="header-title">
                <?php
                    if(isset($_SESSION['admin_login'])){
                        $agents_id = $_SESSION['admin_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $agents_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Admin Manage agents</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=" . $row['agentsID']?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile"></a>
            </div>
        </div>
        <div class="table-card">
            <div class="main-title">
                <H3>Agents</H3>
            </div>
            <div class="table-container">
                <table class="myTable stripe">
                    <thead>
                        <?php
                            $stmt = $conn->query("SELECT agentsID, agentsName, agentsLastname, agnetsEmail, lower(agnetsEmail) as lowerEmail, status FROM agents WHERE role = '0'");
                            $stmt->execute();
                            $result = $stmt->fetchAll();
                        ?>
                        <tr>
                            <th>Number</th>
                            <th>Agent ID</th>
                            <th>Fristname</th>
                            <th>Lastname</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Change Status</th>
                            <th>Edit</th>
                        </tr>
                        <tbody>
                            <?php
                                $n = 1;
                                foreach($result AS $row){ //foreach การ loop data
                                $row['agentsID'];
                            ?>
                            <tr>
                                <td><?php echo $n++; ?></td>
                                <td><?php echo $row['agentsID']; ?></td>
                                <td><?php echo $row['agentsName']; ?></td>
                                <td><?php echo $row['agentsLastname']; ?></td>
                                <td><?php echo $row['lowerEmail']; ?></td>
                                <td>
                                <?php if($row['status'] == 1){
                                    echo '<i class="fa-solid fa-circle" style="color: #ffff00;"></i> ONLINE';
                                }else{
                                    echo '<i class="fa-solid fa-circle" style="color: #323232;"></i> OFFLINE';
                                } ?>
                                </td>
                                <td class="on-off-button">
                                    <?php
                                        if($row['status'] == 1) {
                                    ?>
                                        <button class="change--status--off--btn"><a data-id="<?php echo $row['agentsID'];?>" data-status="0" class="update-status">Offline</a></button>
                                    <?php
                                        } else {
                                    ?>
                                        <button class="change--status--on--btn"><a data-id="<?php echo $row['agentsID'];?>" data-status="1" class="update-status">Online</a></button>
                                    <?php
                                        }
                                    ?>
                                </td>
                                <td>
                                    <a class="edit-button" href="<?php echo "{$domain}Admin/pages/agents/manage_agent/manage_agent.php?id=" . $row['agentsID'];?>"><i class="fa-regular fa-pen-to-square"></i> EDIT</a>
                                    <a class="delete-btn" data-id="<?php echo $row['agentsID'];?>"><i class="fa-solid fa-trash"></i> Delete</a>
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


        $('.update-status').click(function(e) {
            e.preventDefault();
            var agId = $(this).data('id');
            var status = $(this).data('status');

            updatestatusConfirm(agId, status);
        })

        function updatestatusConfirm(agId, status) {
            Swal.fire({
                title: 'Are you Sure?',
                text: 'Are you sure you want to change Agents status it or not?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, Update it!',
                preConfirm: function() {
                    return new Promise(function(resolve) {
                        $.ajax({
                            url: '<?php echo "{$domain}Admin/pages/agents/update_status_agents.php"?>',
                            type: 'GET',
                            data: {
                                'id' : agId,
                                'status': status
                            },
                            success: function(response){
                                if(response === 200){
                                    console.log('success');
                                }else if(response === 404){
                                    console.log('error');
                                }
                            }
                        }).done(function() {
                            Swal.fire({
                                title: 'success',
                                text: 'Update status successfully!',
                                icon: 'success'
                            }).then(() => {
                                document.location.href = '<?php echo "{$domain}Admin/pages/agents/showAgents.php"?>'
                            })
                        }).fail(function() {
                            Swal.fire('Oops...', 'Something went wrong with ajex!', 'error');
                            window.location.reload
                        })
                    })
                }
            })
        }

        $('.delete-btn').click(function(e) {
            e.preventDefault();
            var agId = $(this).data('id');

            deleteAgent(agId);
        })

        function deleteAgent(agId) {
            Swal.fire({
                title: 'Are you Sure?',
                text: 'Are you sure you want to delete Agents it or not?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                preConfirm: function() {
                    return new Promise(function(resolve) {
                        $.ajax({
                            url: '<?php echo "{$domain}/Admin/pages/agents/deleteAgent.php"?>',
                            type: 'GET',
                            data: {
                                'id' : agId,
                            },
                            success: function(response){
                                if(response === 200){
                                    console.log('success');
                                }else if(response === 404){
                                    console.log('error');
                                }
                            }
                        }).done(function() {
                            Swal.fire({
                                title: 'success',
                                text: 'Update status successfully!',
                                icon: 'success'
                            }).then(() => {
                                document.location.href = '<?php echo "{$domain}Admin/pages/agents/showAgents.php"?>'
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