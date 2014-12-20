/// <reference path="jquery-1.10.2.js" />

function GetData() {
    $.ajax({
        url: "WebForm1.aspx",
        type: "POST",
        data: {
            user: "admin",
            pass: "123",
            action: "GetData"
        },
        success: function (data) {
            var res = $(data).filter('main').find('result').text();
            alert(res);
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}

function GetPassWord() {
    $.ajax({
        url: "WebForm1.aspx",
        type: "POST",
        data: {
            user: "admin",
            pass: "123",
            action: "GetPassWord"
        },
        success: function (data) {
            var res = $(data).filter('main').find('result').text();
            alert(res);
        },
        error: function (error) {
            alert("Error happened please contact System Administrator : " + error.statusText);
        }
    });
}


function GetNames() {
    $.ajax({
        url: "WebForm1.aspx",
        type: "POST",
        data: {
            user: "admin",
            pass: "123",
            action: "GetNames"
        },
        success: function (data) {
            $(data).filter('main').find('ClientsInfo').find('Client').each(function () {

                $("#cbo_names").append('<option value="' + $(this).find('Id').text() + '" >' + $(this).find('Name').text() + '</option>');
            });
        },
        error: function (error) {
            alert('Error happened please contact System Administrator : ' + error.statusText);
        }
    });
}