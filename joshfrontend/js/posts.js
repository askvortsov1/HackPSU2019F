function submitLogin(){
    var loginData =
        {email: document.getElementById('loginFormEmail').value,password:document.getElementById('loginFormPassword').value};

    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/rest-auth/login/",
        dataType: "json",
        data: loginData,
        success: function (data) {
            if(data){
                console.log("Got token " + data["key"]);
                document.location.href = document.location.href.replace('index.html','') + "pages/main.html";
            }
            else{
                console.log("Failed user authentication");
                document.getElementById('loginFailText').style.display = 'block';
            }
            console.log("Return data was : " + data);
        },
        error: function () {
            console.log("Failed user authentication");
            document.getElementById('loginFailText').style.display = 'block';
        }
    });
}

function submitRegister(){
    var registerData =
        {
            email:document.getElementById('registerFormEmail').value,
            password1:document.getElementById('registerFormPassword').value,
            password2:document.getElementById('registerFormPassword2').value,
            fname:document.getElementById('registerFormFirstname').value,
            lname:document.getElementById('registerFormLastname').value,
            birthday:document.getElementById('registerFormBirthday').value,
            gender:document.getElementById('registerFormGender').value
        };

    var registerStringData = JSON.stringify(registerData);

    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/rest-auth/registration/",
        dataType: "json",
        data: registerStringData,
        success: function (data) {
            if(data){
                console.log("Got token " + data[key]);
                document.location.href = document.location.href.replace('index.html','') + "pages/main.html";
            }
            else{
                console.log("Failed user authentication");
                document.getElementById('loginFailText').style.display = 'block';
            }
            console.log("Return data was : " + data);
        },
        error: function () {
            alert('Error');
        }
    });
}