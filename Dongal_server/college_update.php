
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$results = array("results","error");
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){	
		$uuid = $_POST[uuid];
		$college = $_POST[college];
		
		$result = sql_fetch("select * from dongal_college where mb_uuid = '$uuid'");
		if ($result[$college])
			$value = "0";
		else 
			$value = "1";
			
		$result2 = sql_query("update dongal_college set $college='$value' where mb_uuid='$uuid'");
		
		$results = array("results","success");
	} else{
		$results = array("results","error");
	}
		
		
	
	$results = json_encode($results); 	
	echo $results;
	
?>
