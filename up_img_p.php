<?php

$link = mysqli_connect('103.212.181.59', 'adminkaiser', 'a4521050001', "agriser_data","3888");


    if (!$link) {
    echo "Database connection faild";



    
    
}

    $image_car = $_FILES["image_car"]["name"];
    $image_license = $_FILES["image_license"]["name"];
    $ip_provider = $_FILES["idpro"]["name"];
    $name = $_POST["name"];
    
    $imagePath = "upload_image/".$image_car;
    $tmp_name = $_FILES['image_car']["tmp_name"];

    move_uploaded_file($tmp_name, $imagePath);

    $imagePath = "upload_image/".$image_license;
    $tmp_name = $_FILES['image_license']["tmp_name"];

    move_uploaded_file($tmp_name, $imagePath);

    $link->query("INSERT INTO tb_service_provider_car(image_license_plate,image_car,id_provider)VALUES('".$image_license."','".$image_car."','556') ");

        // "UPDATE tb_service_provider_car SET image_license_plate = $image_license  WHERE ip_provider = "556" "

                 // "UPDATE tb_service_provider_car(image_license_plate,image_car)SET('".$image_license."','".$image_car."')"

?>