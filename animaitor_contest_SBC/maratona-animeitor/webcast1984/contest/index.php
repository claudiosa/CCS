<?php

require '../../db.php';
require '../config.php';

header('Content-type: text/plain; encoding=utf-8');

$ct = DBContestInfo($contest);

echo
	$ct['contestname'] . "\n";

echo 
	$ct['contestduration']/60 . '' .
	$ct['contestlastmileanswer']/60 . '' .
	$ct['contestlastmilescore']/60 . '' .
	$ct['contestpenalty']/60 . "\n";

$c = DBConnect();

$r = DBExec($c,
	'SELECT problemnumber FROM problemtable' .
	' WHERE contestnumber = ' . $contest .
	' AND problemnumber > 0');

$numProblems = DBnlines($r);

$r = DBExec($c,
	'SELECT username, userfullname, userdesc FROM usertable' .
	' WHERE contestnumber = ' . $contest .
	' AND userenabled = \'t\' AND usersitenumber = ' . $site .
	' AND usertype = \'team\'');

$numTeams = DBnlines($r);

echo 
	$numTeams . '' .
	$numProblems . "\n";

for ($i = 0; $i < $numTeams; $i++) {
	$a = DBRow($r, $i);
	$teamID = $a['username'];
	$pieces = explode('</b>', $a['userfullname']);
	$teamName = $a['userfullname'];
	$pieces = explode(']', $a['userdesc']);
	$pieces = explode('[', trim($pieces[0]));
	$teamUni = trim($pieces[1]);
	//print_r( array_keys($a));

	echo
		$teamID . '' .
		$teamUni . '' .
		$teamName . "\n";
}

echo "1" . '' .  "1\n";
echo $numProblems .  '' .   "Y\n";
?>
