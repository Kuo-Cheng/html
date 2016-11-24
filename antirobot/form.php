<?php
/*
* ERROR CODE:
* missing-input-secret	The secret parameter is missing.
* invalid-input-secret	The secret parameter is invalid or malformed.
* missing-input-response	The response parameter is missing.
* invalid-input-response	The response parameter is invalid or malformed.
*/
	foreach ($_POST as $key => $value) {
		echo '<p><strong>' . $key.':</strong> '.$value.'</p>';
	}

	$email;$comment;$captcha;
	if(isset($_POST['email'])){
	  $email=$_POST['email'];
	}
	
	if(isset($_POST['comment'])){
	  $email=$_POST['comment'];
	}
	
	if (isset($_POST['g-recaptcha-response'])) {
		$captcha = $_POST['g-recaptcha-response'];
		$privatekey = "YOUR_KEY";
		$url = 'https://www.google.com/recaptcha/api/siteverify';
		$data = array(
			'secret' => $privatekey,
			'response' => $captcha,
			'remoteip' => $_SERVER['REMOTE_ADDR']
		);

		$curlConfig = array(
			CURLOPT_URL => $url,
			CURLOPT_POST => true,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_POSTFIELDS => $data
		);

		$ch = curl_init();
		curl_setopt_array($ch, $curlConfig);
		$response = curl_exec($ch);
		curl_close($ch);
	}

	echo  '<br>response=';
	echo $response;
	
$jsonResponse = json_decode($response);

//echo  '<br>'.$jsonResponse;

if ($jsonResponse->success == "true")
    echo "true!";
else
    echo "false!";

echo  '<br>jsonResponse=';
echo $jsonResponse;


?>