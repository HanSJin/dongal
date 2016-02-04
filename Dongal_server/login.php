
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$results = array("results","error");
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){	
		$uuid = $_POST[uuid];
		
		$sql = "select * from dongal_member where mb_uuid='$uuid'";
		$result = sql_fetch($sql);
		if ($result[mb_no]) {
			$results = "success";
		} else {
			$results = "new";
			sql_query("insert into dongal_member (mb_uuid) values ('$uuid')");
			sql_query("insert into dongal_college (mb_uuid) values ('$uuid')");
			sql_query("insert into dongal_alarm (mb_uuid) values ('$uuid')");
		}

	} else{
		$results = array("results","error");
	}
		
	$results = json_encode($results); 	
	echo $results;
	
?>
