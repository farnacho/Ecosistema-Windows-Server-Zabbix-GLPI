var params = JSON.parse(value);
var req = new HttpRequest();

req.addHeader('Content-Type: application/json');
req.addHeader('App-Token: ' + params.glpi_token);

var loginBody = JSON.stringify({
    "login": params.glpi_user,
    "password": params.glpi_password
});

var loginResponse = req.post(params.glpi_url + '/apirest.php/initSession', loginBody);
var sessionData = JSON.parse(loginResponse);

if (!sessionData.session_token) {
    throw 'Login failed: ' + loginResponse;
}

req.addHeader('Session-Token: ' + sessionData.session_token);

var ticketBody = JSON.stringify({
    "input": {
        "name": params.alert_subject,
        "content": params.alert_message,
        "urgency": 3,
        "impact": 3,
        "priority": 3,
        "type": 1,
        "status": 1
    }
});

var ticketResponse = req.post(params.glpi_url + '/apirest.php/Ticket', ticketBody);
req.get(params.glpi_url + '/apirest.php/killSession');

return 'Ticket created: ' + ticketResponse;