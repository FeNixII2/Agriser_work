<?php

$link = mysqli_connect('103.212.181.59', 'adminkaiser', 'a4521050001', "agriser_data","3888");


    if (!$link) {
    echo "Database connection faild";

} 
$phone_user = $_POST["phone_user"];
    $image_car = $_FILES["img_field1"]["name"];
    $image_license = $_FILES["img_field2"]["name"];
    
    
    $imagePath = "upload_image/".$image_car;
    $tmp_name = $_FILES['img_field1']["tmp_name"];

    move_uploaded_file($tmp_name, $imagePath);

    $imagePath = "upload_image/".$image_license;
    $tmp_name = $_FILES['img_field2']["tmp_name"];

    move_uploaded_file($tmp_name, $imagePath);

    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "l_".$nums."";

    $link->query("INSERT INTO tb_presentwork_user_labor(img_field1,img_field2,phone_user,id_presentwork)VALUES('".$image_license."','".$image_car."','".$phone_user."','$num') ");

        // "UPDATE tb_service_provider_car SET image_car_2 = $image_license  WHERE ip_provider = "556" "

                 // "UPDATE tb_service_provider_car(image_car_2,image_car)SET('".$image_license."','".$image_car."')"

?>