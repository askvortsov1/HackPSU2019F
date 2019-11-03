function storeUserData(dataKey) {
    var userData = {key:dataKey};
    
    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/rest-auth/user/",
        data: userData,
        success: function (data) {
            console.log("Got data successfully");
            console.log("data");
            window.localStorage["curr_user"] = data;
        },
        error: function () {
            console.log("Failed to get data");
        }
    });
}


function submitLogin() {
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
                document.cookie = "key:" + data["key"];
                document.location.href = document.location.href.replace('index.html', '') + "pages/main.html";
                storeUserData(data["key"]);
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

    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/rest-auth/registration/",
        dataType: "json",
        data: registerData,
        success: function (data) {
            if(data){
                if(data["password1"]){
                    document.getElementById('registerFailText').innerHTML = data["password1"];
                    document.getElementById('registerFailText').style.display = 'block';
                }
                else{
                    console.log("Got token " + data["key"]);
                    document.getElementById('registerFailText').innerHTML = "Successfully Registered!";
                    document.getElementById('registerFailText').style.display = 'block';
                }
            }
            else{
                console.log("Failed user registration");
                document.getElementById('registerFailText').style.display = 'block';
            }
            console.log("Return data was : " + data);
        },
        error: function () {
            console.log("Failed user registration");
            document.getElementById('registerFailText').style.display = 'block';
        }
    });
}

function submitRequest() {

    var requestData =
        {
            user: window.localStorage["curr_user"]["id"],
            item: document.getElementById('requestItem').value,
            item_description: document.getElementById('requestDetails').value,
            severity: document.getElementById('requestUrgency').value,
            severity_detail: document.getElementById('requestSeverity').value
        };

    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/rest-auth/help/requests/",
        dataType: "json",
        data: requestData,
        success: function (data) {
            if(data){
                document.getElementById('requestFailText').innerHTML = "Successfully created request!";
                document.getElementById('requestFailText').style.display = 'block';
            }
            else{
                document.getElementById('requestFailText').style.display = 'block';
            }
            console.log("Return data was : " + data);
        },
        error: function () {
            document.getElementById('requestFailText').style.display = 'block';
        }
    });
}

function getDateTime(){
    var today = new Date();
    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    var dateTime = date+' '+time;
}