
<?php 
	
	include_once('common.php');
	conn();
	
	if($_SERVER['REQUEST_METHOD'] == "GET"){	
		$uuid = $_GET[uuid];
		$result = sql_fetch("select use_keyword from dongal_member where mb_uuid='$uuid'");
		$results = array( "use_keyword"=>$result[use_keyword] );
		
	} else if($_SERVER['REQUEST_METHOD'] == "POST"){
		$uuid = $_POST[uuid];	
		
		$result = sql_fetch("select use_keyword from dongal_member where mb_uuid='$uuid'");
		if ($result[use_keyword]==0) {
			sql_query("update dongal_member set use_keyword='1' where mb_uuid='$uuid'");
		} else {
			sql_query("update dongal_member set use_keyword='0' where mb_uuid='$uuid'");
		}
		
		$results = array("results","success");
		
	} else{
		$results = array("results","error");
	}
		
		
	
	

	$results = json_encode($results); 	
	echo $results;
	
?>
