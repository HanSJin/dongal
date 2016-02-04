
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$uuid = $_GET[uuid];
		
		$result = sql_fetch("select * from dongal_alarm where mb_uuid='$uuid'");
		$cnt = 0;
		
		$results = array(
			"arts"=>$result[arts],
			"bs"=>$result[bs],
			"edus"=>$result[edus],
			"engineers"=>$result[engineers],
			"entrances"=>$result[entrances],
			"globals"=>$result[globals],
			"laws"=>$result[laws],
			"liberals"=>$result[liberals],
			"lives"=>$result[lives],
			"normals"=>$result[normals],
			"pharms"=>$result[pharms],
			"proceedings"=>$result[proceedings],
			"sbas"=>$result[sbas],
			"scholars"=>$result[scholars],
			"sciences"=>$result[sciences],
			"socials"=>$result[socials],
			"studies"=>$result[studies]
		);
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){	
		$uuid = $_POST[uuid];	
		$college = $_POST[college];

		$result = sql_fetch("select * from dongal_alarm where mb_uuid='$uuid'");
		if ($result[$college]==0) {
			sql_query("update dongal_alarm set $college='1' where mb_uuid='$uuid'");
		} else {
			sql_query("update dongal_alarm set $college='0' where mb_uuid='$uuid'");
		}

		$results = array("results", $result[$college]);
	} else{
		$results = array("results","error");
	}
		
		
	
	

	$results = json_encode($results); 	
	echo $results;
	
?>
