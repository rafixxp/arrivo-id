<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ config('app.name', 'Laravel') }}</title>
    <link rel="manifest" href="{{ asset('manifest.json') }}">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta name="apple-mobile-web-app-title" content="{{ config('app.name', 'Laravel') }}">
    <meta name="theme-color" content="#FFFFFF">
    <link rel="apple-touch-icon" href="{{ asset('icons/icon-192x192.webp') }}">
    <style>
        scrollbar-width: thin;
        scrollbar-color: transparent transparent;

        *{
            font-family: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
        }
        
        /* Hide scrollbar for Chrome, Safari and Opera */
        ::-webkit-scrollbar {
            display: none;
        }
        
        .dark-mode{
            background-color: #021329ff;
            color: white;
        }
        .dark-mode .text-muted{
            color: white !important;
        }
        .dark-mode .card{
            background-color: #021c36ff !important;
        }
        .dark-mode .bg-white{
            background-color: #021c36ff !important;
            color: white !important;
        }
        .dark-mode .modal .modal-content{
            background-color: #021c36ff !important;
            color: white !important;
        }
        .dark-mode .btn-primary{
            background-color: #021c36ff !important;
            border-color: #021c36ff !important;
        }
    </style>
    @vite(['resources/js/app.js'])
</head>
<body class="bg-light">
    <div id="app"></div>
</body>
</html>