<?php
// OTS: dopisuje profesje Monk do probek postaci MyAAC (Admin Panel -> Settings -> Create Character).
// Zostawia reszte ustawienia bez zmian; gdy ustawienia jeszcze nie ma, zaczyna od domyslnych probek.

declare(strict_types=1);

function ots_env(string $name, string $default): string
{
	$value = getenv($name);
	return $value === false || $value === '' ? $default : $value;
}

$dsn = sprintf(
	'mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',
	ots_env('CANARY_DB_HOST', 'db'),
	ots_env('CANARY_DB_PORT', '3306'),
	ots_env('CANARY_DB_NAME', 'canary')
);
$pdo = new PDO($dsn, ots_env('CANARY_DB_USER', 'canary'), ots_env('CANARY_DB_PASSWORD', 'canary'), [
	PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
	PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$samples = [
	9 => 'Monk Sample',
];

$select = $pdo->prepare('SELECT `id`, `value` FROM `myaac_settings` WHERE `name` = ? AND `key` = ? LIMIT 1');
$select->execute(['core', 'character_samples']);
$row = $select->fetch();
$value = $row ? (string)$row['value'] : "1=Sorcerer Sample\n2=Druid Sample\n3=Paladin Sample\n4=Knight Sample";

$lines = array_values(array_filter(array_map('trim', preg_split('/\r\n|\r|\n/', trim($value)))));
$present = [];
foreach ($lines as $line) {
	$present[(int)explode('=', $line, 2)[0]] = true;
}
$changed = false;
foreach ($samples as $vocation => $name) {
	if (!isset($present[$vocation])) {
		$lines[] = $vocation . '=' . $name;
		$changed = true;
	}
}

if (!$changed) {
	echo "OTS: character samples already include Monk.\n";
	return;
}

$newValue = implode("\n", $lines);
if ($row) {
	$pdo->prepare('UPDATE `myaac_settings` SET `value` = ? WHERE `id` = ?')->execute([$newValue, $row['id']]);
} else {
	$pdo->prepare('INSERT INTO `myaac_settings` (`name`, `key`, `value`) VALUES (?, ?, ?)')->execute(['core', 'character_samples', $newValue]);
}
echo "OTS: character samples set to: " . str_replace("\n", ', ', $newValue) . "\n";
