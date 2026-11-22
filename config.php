<?php
/**
 * MARITY TRADE — PRODUCTION CONFIGURATION & HARDENING
 * Prepared for Apple App Store / WKWebView & Production PHP Deployment
 */

// Production Error Handling: Never show raw errors or paths to clients
error_reporting(E_ALL);
ini_set('display_errors', '0');
ini_set('display_startup_errors', '0');
ini_set('log_errors', '1');

$log_dir = __DIR__ . '/logs';
if (!is_dir($log_dir)) {
    @mkdir($log_dir, 0755, true);
}
ini_set('error_log', $log_dir . '/php_error.log');

// Set Timezone
date_default_timezone_set('Africa/Accra');

// Secure Session Configuration
if (session_status() === PHP_SESSION_NONE) {
    $is_https = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') 
                || (isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == 443) 
                || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https');

    ini_set('session.cookie_httponly', '1');
    ini_set('session.use_only_cookies', '1');
    if ($is_https) {
        ini_set('session.cookie_secure', '1');
    }
    @session_start();
}

// Dynamic Host & Protocol Detection
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https')) ? 'https://' : 'http://';
$host = $_SERVER['HTTP_HOST'] ?? '127.0.0.1';
$script_dir = dirname($_SERVER['SCRIPT_NAME'] ?? '');
$base_url = rtrim($protocol . $host . ($script_dir !== '/' ? $script_dir : ''), '/\\');

define('SITE_URL', $base_url);
define('SITE_NAME', 'Marity Trade');
define('CURRENCY_SYMBOL', 'GH₵');
define('CURRENCY_CODE', 'GHS');
define('DELIVERY_WINDOW', 'Delivery within 12 to 24 hours');

// Database Configuration with Graceful Fallback
define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_NAME', getenv('DB_NAME') ?: 'marity_trade_db');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') ?: '');

global $pdo, $db_connected;
$db_connected = false;

try {
    $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
        PDO::ATTR_TIMEOUT            => 2, // 2-second timeout to prevent mobile hang
    ];
    $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
    $db_connected = true;
} catch (Throwable $e) {
    // Log privately; NEVER die() or expose raw credentials to iOS clients
    error_log("Database connection notice: " . $e->getMessage());
    $pdo = null;
    $db_connected = false;
}
?>