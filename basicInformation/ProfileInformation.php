<?php
session_start();
include_once("../sql/connect.php");
include_once("../includes/domain.php");

    $agents_id = $_SESSION['agents_ID'];

    if(!isset($_SESSION['agents_ID'])){
        $_SESSION['error'] = "Error basic information pages";
        header("location: {$domain}Admin/login.php");
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | ProfileInformation</title>
    <link rel="stylesheet" href="informationStyle.css">
</head>
<body>
<div class="main-container">
                <div class="alert">
                <?php if(isset($_SESSION['verifi'])) { ?>
                    <div class="error-alert" role="alert">
                        <?php 
                            echo $_SESSION['verifi'];
                            unset($_SESSION['verifi']);
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
                <span><?php echo $row['agnetsEmail']?></span>
                <h2>AndamanTour</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/logout.php"?>">Logout</a>
            </div>
        </div>
        <div class="card-container">
            <form action="ProfileInformation-db.php?id=<?php echo $agents_id?>" method="POST" id="updateData">
            <H3 class="main-title">Personal Information</H3>
            <div class="input--container">
                <div class="input-Bx">
                    <span>FirstName *</span>
                    <input type="text" name="firstname" id="firstname">
                    <div class="error"></div>
                </div>
                <div class="input-Bx">
                    <span>LastName *</span>
                    <input type="text" name="Lastname" id="lastname">
                    <div class="error"></div>
                </div>
                <div class="input-Bx">
                    <span>Email</span>
                    <input type="text" name="Email" value="<?php echo $row['agnetsEmail']?>" readonly>
                </div>
            </div>
            <div class="input--container--br">
                <div class="input-Bx">
                    <span>Mobile No. *</span>
                    <input type="text" name="mobileAgent" id="MobileAgent">
                    <div class="error"></div>
                </div>
            </div>
            <hr>
            <H3 class="main-title">Company Information</H3>
            <div class="input--container">
                <div class="input-Bx">
                    <span>CompanyName *</span>
                    <input type="text" name="CompanyName" id="companyName">
                    <div class="error"></div>
                </div>
                <div class="input-Bx">
                    <span>Mobile No. *</span>
                    <input type="text" name="MobileCompany" id="MobileCompany">
                    <div class="error"></div>
                </div>
                <div class="input-Bx">
                    <span>RegistcompanyNo. *</span>
                    <input type="text" name="RegistcompanyNo" id="RegistcompanyNo">
                    <div class="error"></div>
                </div>
            </div>
            <div class="input--container">
                <span>Address. *</span>
                <textarea name="address" id="address" cols="30" rows="5"></textarea>
                <div class="error"></div>
            </div>
            <div class="input--container">
                <?php
                    $stmt = $conn->query("SELECT * FROM provinces");
                    $stmt->execute();
                    $result = $stmt->fetchAll();
                ?>
                <div class="input-Bx">
                    <span>Province *</span>
                    <select name="province_id" id="provinces">
                    <option value="">Select Province</option>
                        <?php
                            foreach($result as $row) {
                        ?>
                            <option value="<?=$row['id']?>"><?=$row['name_en']?></option>
                        <?php
                            }
                         ?>
                    </select>
                </div>
                <div class="input-Bx">
                    <span>Amphures *</span>
                    <select name="amphures_id" id="amphures">
                    <option value="">Select Amphures</option>
                    </select>
                    <div class="error"></div>
                </div>
                <div class="input-Bx">
                    <span>Districts *</span>
                    <select name="districts_id" id="districts">
                    <option value="">Select Districts</option>
                    </select>
                    <div class="error"></div>
                </div>
            </div>
            <div class="submit-btn">
                <center><input type="submit" value="Continue" id="submit" name="data"></center>
            </div>
        </form>
    </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- <script src="validateform.js"></script> -->
    <script>

            $(document).ready(function () {
                $("#updateData").submit(function (e) {
                    e.preventDefault()

                    let formUrl = $(this).attr("action");
                    let reqMethod = $(this).attr("method");
                    let formData = $(this).serialize();

                    if(validate()){
                        $.ajax({
                            url: formUrl,
                            type: reqMethod,
                            data: formData,
                            success: function(response) {
                                if (response.status = "Success") {
                                    console.log("Success", response)
                                    location.href="<?php echo "{$domain}Admin/agents/dashboard.php?id=$agents_id"?>"
                                } else {
                                     console.log("Error", response)
                                }
                            }
                        })
                    }
                })
            })

            function validate() {
                let pass = true
                const firstname = document.getElementById("firstname");
                const lastname = document.getElementById("lastname");
                const mobileAgent = document.getElementById("MobileAgent");
                const companyName = document.getElementById("companyName");
                const MobileCompany = document.getElementById("MobileCompany");
                const address = document.getElementById("address");
                const Registcompany = document.getElementById("RegistcompanyNo");

                const provinces = document.getElementById("provinces");
                const amphures = document.getElementById("amphures");
                const districts = document.getElementById("districts");

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
                } else if(mobileAgent.value.length <= 0) {
                    pass = false
                    title = 'Mobile No.'
                    text = 'Mobile No is required'
                    showAlert(title, text)
                } else if(companyName.value.length <= 0) {
                    pass = false
                    title = 'companyName'
                    text = 'companyName is required'
                    showAlert(title, text)
                } else if(MobileCompany.value.length <= 0) {
                    pass = false
                    title = 'Mobile No'
                    text = 'Mobile No is required'
                    showAlert(title, text)
                } else if(address.value.length <= 0) {
                    pass = false
                    title = 'address'
                    text = 'address is required'
                    showAlert(title, text)
                } else if(Registcompany.value.length <= 0) {
                    pass = false
                    title = 'RegistcompanyNo'
                    text = 'RegistcompanyNo is required'
                    showAlert(title, text)
                } else if(provinces.value.length <= 0) {
                    pass = false
                    title = 'Province'
                    text = 'Province is required'
                    showAlert(title, text)
                } else if(amphures.value.length <= 0) {
                    pass = false
                    title = 'Amphures'
                    text = 'Amphures is required'
                    showAlert(title, text)
                } else if(districts.value.length <= 0) {
                    pass = false
                    title = 'Districts'
                    text = 'Districts is required'
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
            // $(document).ready(function() {
            //     const form = document.getElementById("updateData");
            //     const firstname = document.getElementById("firstname");
            //     const lastname = document.getElementById("lastname");
            //     const mobileAgent = document.getElementById("MobileAgent");
            //     const companyName = document.getElementById("companyName");
            //     const MobileCompany = document.getElementById("MobileCompany");
            //     const address = document.getElementById("address");
            //     const Registcompany = document.getElementById("RegistcompanyNo");

            //     // const provinces = document.getElementById("provinces");
            //     // const amphures = document.getElementById("amphures");
            //     // const districts = document.getElementById("districts");

            //     form.addEventListener('submit', e => {
            //         e.preventDefault();

            //         ValidateInputs();

            //         if(ValidateInputs()){
            //             $(document).ready(function() {
            //                 $("#updateData").submit(function(e) {
            //                     e.preventDefault();
                                
            //                     let formUrl = $(this).attr("action");
            //                     let reqMethod = $(this).attr("method");
            //                     let formData = $(this).serialize();

            //                     $.ajax({
            //                         url: formUrl,
            //                         type: reqMethod,
            //                         data: formData,
            //                         success: function(response) {
            //                             if (response.status = "Success") {
            //                                 console.log("Success", response)
            //                                 location.href="<//?php echo "{$domain}Admin/agents/dashboard.php?id=$agents_id"?>"
            //                             } else {
            //                                 console.log("Error", response)
            //                             }
            //                         }
            //                     })
            //                 })
            //             })
            //         } else {
                        
            //         }
            //     })

            //     // func set error
            //     const setError = (element, message) => {
            //         const inputControl = element.parentElement;
            //         const errorDisplay = inputControl.querySelector('.error');

            //         errorDisplay.innerText = message;
            //         inputControl.classList.add('error');
            //         inputControl.classList.remove('success')
            //     }
            //     //func set success
            //     const setSuccess = element => {
            //         const inputControl = element.parentElement;
            //         const errorDisplay = inputControl.querySelector('.error');

            //         errorDisplay.innerText = '';
            //         inputControl.classList.add('success');
            //         inputControl.classList.remove('error');
            //     }

            //     const ValidateInputs = () => {
            //         const firstnameValue = firstname.value.trim();
            //         const lastnameValue = lastname.value.trim();
            //         const mobileAgentValue = mobileAgent.value.trim();
            //         const companyNameValue = companyName.value.trim();
            //         const MobileCompanyValue = MobileCompany.value.trim();
            //         const addressValue = address.value.trim();
            //         const RegistcompanyValue = Registcompany.value.trim();
            //         // const provinceValue = provinces.value.trim();
            //         // const amphuresValue = amphures.value.trim();
            //         // const districtsValue = districts.value.trim();

            //         if(firstnameValue === "") {
            //             setError(firstname, 'firstname is required')
            //         } else {
            //             setSuccess(firstname);
            //         }

            //         if(lastnameValue === ""){
            //             setError(lastname, 'lastname is required')
            //         } else {
            //             setSuccess(lastname);
            //         }

            //         if(mobileAgentValue === ""){
            //             setError(mobileAgent, 'mobileNo is required')
            //         } else {
            //             setSuccess(mobileAgent);
            //         }

            //         if(companyNameValue === ""){
            //             setError(companyName, 'companyName is required')
            //         } else {
            //             setSuccess(companyName);
            //         }

            //         if(MobileCompanyValue === ""){
            //             setError(MobileCompany, 'mobileNo is required')
            //         } else {
            //             setSuccess(MobileCompany);
            //         }

            //         if(addressValue === ""){
            //             setError(address, 'address is required')
            //         } else {
            //             setSuccess(address);
            //         }

            //         if(RegistcompanyValue === ""){
            //             setError(Registcompany, 'RegistcompanyNo is required')
            //         } else {
            //             setSuccess(Registcompany);
            //         }

                    // if(provinceValue === ""){
                    //     setError(provinces, 'provinces is required')
                    // } else {
                    //     setSuccess(provinces);
                    // }

                    // if(amphuresValue === ""){
                    //     setError(amphures, 'amphures is required')
                    // } else {
                    //     setSuccess(amphures);
                    // }

                    // if(districtsValue === ""){
                    //     setError(districts, 'districts is required')
                    // } else {
                    //     setSuccess(districts);
                    // }


            //     }
            // })
            
            
             

            $(function(){
                var provinceObject = $('#provinces');
                var amphureObject = $('#amphures');
                var districtObject = $('#districts');
            
                // on change province
                provinceObject.on('change', function(){
                    var provinceId = $(this).val();
            
                    amphureObject.html('<option value="">Select Amphures</option>');
                    districtObject.html('<option value="">Select Districts</option>');
            
                    $.get('get_amphure.php?province_id=' + provinceId, function(data){
                        var result = JSON.parse(data);
                        $.each(result, function(index, item){
                            amphureObject.append(
                                $('<option></option>').val(item.id).html(item.name_en)
                            );
                        });
                    });
                });
            
                // on change amphure
                amphureObject.on('change', function(){
                    var amphureId = $(this).val();
            
                    districtObject.html('<option value="">Select Districts</option>');
                    
                    $.get('get_district.php?amphure_id=' + amphureId, function(data){
                        var result = JSON.parse(data);
                        $.each(result, function(index, item){
                            districtObject.append(
                                $('<option></option>').val(item.id).html(item.name_en)
                            );
                        });
                    });
                });
            });
    </script>
</body>
</html>