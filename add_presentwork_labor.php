<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('103.212.181.59', 'adminkaiser', 'a4521050001', "agriser_data","3888");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
    }



    
    $phone_user = $_POST["phone_user"];
    $type_presentwork = $_POST["type_presentwork"];
    $count_field = $_POST["count_field"];
    $info_choice = $_POST["info_choice"];
    $prices = $_POST["prices"];
    $date_work = $_POST["date_work"];
    $details = $_POST["details"];
    $map_lat_work = $_POST["map_lat_work"];
    $map_long_work = $_POST["map_long_work"];
    $imag1 = $_POST["img1"];
    $imag2 = $_POST["img2"];
    $box1 = $_POST["box1"];
    $box2 = $_POST["box2"];
    $box3 = $_POST["box3"];
    $box4 = $_POST["box4"];
    $box5 = $_POST["box5"];
    $box6 = $_POST["box6"];
    $total_choice = $_POST["total_choice"];


    
    
    
    // $imagePath = "upload_image/".$imag1;
    // $tmp_name = $_FILES['img_no1']["tmp_name"];

    // move_uploaded_file($tmp_name, $imagePath);

    // $imagePath = "upload_image/".$imag2;
    // $tmp_name = $_FILES['img_no2']["tmp_name"];

    // move_uploaded_file($tmp_name, $imagePath);

    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);
    $selectdatabooking = "SELECT * from tb_provider where id_provider = '" . $num . "' ";
    $objselect = mysqli_query($link, $selectdatabooking);
    $Resultselect = mysqli_fetch_array($objselect ,MYSQLI_ASSOC);
    while (!is_null($Resultselect)) {
    $nums = str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

    }
    $num = "l_".$nums."";

    if (!$link->query("INSERT INTO tb_presentwork_user_labor( 
            id_presentwork,
            phone_user,
            type_presentwork,
            count_field,
            info_choice,
            prices,
            date_work,
            details,
            img_field1,
            img_field2,
            map_lat_work,
            map_long_work,
            rice,
            sweetcorn,
            cassava,
            sugarcane,
            chili,
            choice,
            status_work,
            total_choice
            )VALUES(

            '$num',
            '$phone_user',
            '$type_presentwork',
            '$count_field',
            '$info_choice',
            '$prices',
            '$date_work',
            '$details',
            '$imag1',
            '$imag2',
            '$map_lat_work',
            '$map_long_work',
            '$box1',
            '$box2',
            '$box3',
            '$box4',
            '$box5',
            '$box6',
            '0',
            '$total_choice'

            )
            ")) {
     	echo("Error description: " . $link -> error);
     } 

 	

       

?>