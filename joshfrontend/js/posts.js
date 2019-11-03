function submitLogin(){
    var loginData =
        {
         email: document.getElementById('loginFormEmail').value,
         password: document.getElementById('loginFormPassword').value
        };

    var loginDataString = JSON.stringify(loginData);

    $.ajax({
        type: "POST",
        url: "http://hackpsu-fall2019.herokuapp.com/rest-auth/login/",
        dataType: "json",
        data: loginDataString,
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