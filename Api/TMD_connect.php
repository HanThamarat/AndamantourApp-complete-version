<?php
    
    $date = date("Y-m-d");
    $curl = curl_init();
  
    curl_setopt_array($curl, array(
      CURLOPT_URL => "https://data.tmd.go.th/nwpapi/v1/forecast/location/daily/at?lat=8.042129&lon=98.836766&fields=tc_max,rh&date={$date}&duration=2",
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => "",
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 30,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => "GET",
      CURLOPT_HTTPHEADER => array(
        "accept: application/json",
        "authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImFiNzFjNDlmZTY4ZWE2ZjNhMDRmZTYzOGJkNjAyOTM0YjhlZWI3Y2UzZDQzZDg5Y2JlMDgxNjgxMjM4MTEwYjA4NDFiNTM5NzJhNzIyMmM1In0.eyJhdWQiOiIyIiwianRpIjoiYWI3MWM0OWZlNjhlYTZmM2EwNGZlNjM4YmQ2MDI5MzRiOGVlYjdjZTNkNDNkODljYmUwODE2ODEyMzgxMTBiMDg0MWI1Mzk3MmE3MjIyYzUiLCJpYXQiOjE2OTYyNTI5OTksIm5iZiI6MTY5NjI1Mjk5OSwiZXhwIjoxNzI3ODc1Mzk5LCJzdWIiOiIyNzk3Iiwic2NvcGVzIjpbXX0.b-U9JWaWTZ-2LJAL-PI_wMMBZGRUXi3xxTvR4Yf_c9SoAtZLAEQ9adcmKGTWp08vUrcQHzDJ0K8dHIxTXXoRD93P__3RV_1ypSvMdPWMxPDFKELyMTmcx3LbYLF4p6GBghPDo3KIBqoDqRw9nt6QJ-cpz6XnGEKnqnFCetzZ-qf7GEsgfl0D2cm6qGH3Nj3WIw3mkfJkzL0-Mxp4-K90wE2FsmXib8xmlGSh6MUGAVj_Wfv5GsAJu_e2wm-pgFBGKvG5VZ3iCZRIFeOK28va97SXP2_oi-gvNcUusSqoItWRQ2H0OCV_9gKFKeAMpJNYm4x8Wzylkkkl5nkTjui87jZj-SaSkyL9GYLbdV0KkA7BXm26xeUW6OS3PAJi-6RPAG40diLUjD8WXHxrPeI_0GW2eR3NEOX9HKDtWVIxBVvPFgzIP_dOpnaU2enjLLfuTq2OhkFZfrAosjFX_nl4TgFOEABNagCxAMK_y8JJDZ53sCGFs4sogOJhjazXgW1TCdtt3mbK_2CMPE7zDMs3RvcWfoz7BtSrzNeVzIoClx8wNJcVwuvQliVNW4Ny7wuX1c_XD7As0nuzyrlgWwKUM0CzaAlnTsMlTBqsTUxgrVcxfihuP-X9YbyX6ondiagXOxLH4iW-8OgW6aZSM89tqfuwA26wQWRiTPcOY_AAyiE",
      ),
    ));
    
    $response = curl_exec($curl);
    $err = curl_error($curl);
    
    curl_close($curl);
    
    if ($err) {
      echo "cURL Error #:" . $err;
    } else {
      echo $response;
    }
?>