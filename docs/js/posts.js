function storeUserData(dataKey,email) {

    sessionStorage.setItem("userid",7);
    
    $.ajax({
        type: "GET",
        url: "http://hackpsu-fall2019.herokuapp.com/emailidconverter/",
        data: {"email": email},
        dataType: "json",
        success: function (data) {
            console.log("Got data successfully");
            console.log(data);
            sessionStorage.setItem("user",data);
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
                sessionStorage.setItem("numTasks",0);
                storeUserData(data["key"], document.getElementById('loginFormEmail').value);
                document.location.href = document.location.href.replace('index.html', '') + "pages/main.html";
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
            user: sessionStorage.getItem("userid"),
            item: document.getElementById('requestItem').value,
            item_description: document.getElementById('requestDetails').value,
            severity: document.getElementById('requestUrgency').value,
            severity_detail: document.getElementById('requestSeverity').value
        };

    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/help/requests/create",
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

function getRequests(){

    $.ajax({
        type: "GET",
        url: "http://hackpsu-fall2019.herokuapp.com/help/requests",
        success: function (data) {
            for(i = 0; i < data.length; i ++){
                helpBody = document.getElementById("helpBody");
                helpBody.innerHTML += "<div class='cardForm'><p>" + data[i]["item"] + "</p><p>" + 
                                        data[i]["item_description"] + "</p><p>" + 
                                        data[i]["severity"] + "</p><p>" + 
                                        data[i]["severity_detail"] + "</p><form><input type='hidden' id='claimID' value='" + 
                                        data[i]["id"] + "'><input type='hidden' id='item" + i + "' value='" + 
                                        data[i]["item"] + "'><input type='hidden' id='item_description" + i + "' value='" + 
                                        data[i]["item_description"] + "'><input type='hidden' id='severity" + i + "' value='" + 
                                        data[i]["severity"] + "'><input type='hidden' id='severity_detail" + i + "' value='" + 
                                        data[i]["severity_detail"] + "'><input type='submit' value='Claim' class='formcontrol btn btn-primary' onclick='claimTask(" + i + ")'></form></div>";
            }
        },
        error: function (e) {
            alert('Error' + e);
        }
    });
}

function getMyItems(){

    for(i = 0; i < parseInt(sessionStorage.getItem("numTasks")); i += 1){
        viewBody = document.getElementById("viewBody");
        viewBody.innerHTML += "<div class='cardForm'><p>" + sessionStorage.getItem("taskItem"+i) + "</p><p>" 
                                        + sessionStorage.getItem("taskDesc"+i) + "</p><p>"  
                                        + sessionStorage.getItem("taskSev"+i) + "</p><p>"  
                                        + sessionStorage.getItem("taskDet"+i) + "</p></div>";
    }

}

function claimTask(index){
    saveIndex = sessionStorage.getItem("numTasks");
    sessionStorage.setItem("taskItem"+saveIndex,document.getElementById("item"+index).value);
    sessionStorage.setItem("taskDesc"+saveIndex,document.getElementById("item_description"+index).value);
    sessionStorage.setItem("taskSev"+saveIndex,document.getElementById("severity"+index).value);
    sessionStorage.setItem("taskDet"+saveIndex,document.getElementById("severity_detail"+index).value);
    sessionStorage.setItem("numTasks",parseInt(sessionStorage.getItem("numTasks")) + 1);
}

function logout(){
    document.location.href = document.location.href.replace('pages/main.html', 'index.html');
}


function getDateTime(){
    var today = new Date();
    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    var dateTime = date+' '+time;
}