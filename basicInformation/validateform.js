const form = document.getElementById("updateData");
const firstname = document.getElementById("firstname");
const lastname = document.getElementById("lastname");
const mobileAgent = document.getElementById("MobileAgent");
const companyName = document.getElementById("companyName");
const MobileCompany = document.getElementById("MobileCompany");
const address = document.getElementById("address");
const provinces = document.getElementById("provinces");
const amphures = document.getElementById("amphures");
const districts = document.getElementById("districts");

form.addEventListener('submit', (e) => {
    e.preventDefault();

    ValidateInputs();
})

// func set error
const setError = (element, message) => {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector('.error');

    errorDisplay.innerText = message;
    inputControl.classList.add('error');
    inputControl.classList.remove('success')
}
//func set success
const setSuccess = element => {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector('.error');

    errorDisplay.innerText = '';
    inputControl.classList.add('success');
    inputControl.classList.remove('error');
}

const ValidateInputs = () => {
    const firstnameValue = firstname.value.trim();
    const lastnameValue = lastname.value.trim();
    const mobileAgentValue = mobileAgent.value.trim();
    const companyNameValue = companyName.value.trim();
    const MobileCompanyValue = MobileCompany.value.trim();
    const addressValue = address.value.trim();
    const provinceValue = provinces.value.trim();
    const amphuresValue = amphures.value.trim();
    const districtsValue = districts.value.trim();

    if(firstnameValue === "") {
        setError(firstname, 'firstname is required')
    } else {
        setSuccess(firstname);
    }

    if(lastnameValue === ""){
        setError(lastname, 'lastname is required')
    } else {
        setSuccess(lastname);
    }

    if(mobileAgentValue === ""){
        setError(mobileAgent, 'mobileNo is required')
    } else {
        setSuccess(mobileAgent);
    }

    if(companyNameValue === ""){
        setError(companyName, 'companyName is required')
    } else {
        setSuccess(companyName);
    }

    if(MobileCompanyValue === ""){
        setError(MobileCompany, 'mobileNo is required')
    } else {
        setSuccess(MobileCompany);
    }

    if(addressValue === ""){
        setError(address, 'address is required')
    } else {
        setSuccess(address);
    }

    if(provinceValue === ""){
        setError(provinces, 'provinces is required')
    } else {
        setSuccess(provinces);
    }

    if(amphuresValue === ""){
        setError(amphures, 'amphures is required')
    } else {
        setSuccess(amphures);
    }

    if(districtsValue === ""){
        setError(districts, 'districts is required')
    } else {
        setSuccess(districts);
    }


}