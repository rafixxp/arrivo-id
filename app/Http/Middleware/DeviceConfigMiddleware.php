<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class DeviceConfigMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        $response->headers->set('Accept-CH', 'Sec-CH-UA,Sec-CH-UA-Platform,Sec-CH-UA-Mobile,Sec-CH-UA-Model,Sec-CH-UA-Platform-Version,Sec-CH-UA-Full-Version');

        return $response;
    }
}
