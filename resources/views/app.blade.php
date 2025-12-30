<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ config('app.name', 'Laravel') }}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="manifest" href="{{ asset('manifest.json') }}">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta name="apple-mobile-web-app-title" content="{{ config('app.name', 'Laravel') }}">
    <meta name="theme-color" content="#FFFFFF">
    <link rel="apple-touch-icon" href="{{ asset('icons/icon-192x192.webp') }}">
    <style>
        *{
            font-family: 'Inter', sans-serif !important;
        }
        
        /* Hide scrollbar for Chrome, Safari and Opera */
        ::-webkit-scrollbar {
            display: none;
        }
        
        /* Hide scrollbar for IE, Edge and Firefox */
        scrollbar-width: thin;
        scrollbar-color: transparent transparent;

        .roboto-<uniquifier> {
        font-family: "Roboto", sans-serif;
        font-optical-sizing: auto;
        font-weight: <weight>;
        font-style: normal;
        font-variation-settings:
            "wdth" 100;
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