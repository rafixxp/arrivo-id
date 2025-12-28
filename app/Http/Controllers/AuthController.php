<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AuthController extends Controller
{
    public function signIn(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);

        $cred = $request->only('email', 'password');
        if (Auth::attempt($cred)) {
            $user = User::where('users.email', $request->email)
                ->rightJoin('positions', 'users.position_id', 'positions.id')
                ->select('users.address', 'users.date_of_birth', 'users.place_of_birth', 'users.phone', 'users.email', 'users.id', 'users.name', 'users.role', 'users.branch_id', 'users.company_id', 'positions.name as position_id')
                ->first();

            $users = Auth::user();
            $token = $users->createToken('auth_token')->plainTextToken;

            if($users->role == 'admin' || $users->role == 'super admin'){
                return response()->json([
                    'access_token' => $token,
                    'tokenstype' => 'Bearer',
                    'redirect' => '/',
                    'user' => $user
                ]);
            }
            else if($users->role == 'employee'){
                return response()->json([
                    'access_token' => $token,
                    'token_tyse' => 'Bearer',
                    'redirect' => '/home',
                    'user' => $user
                ]);
            }
        }
        else {
            return response()->json(['message' => 'Email atau password salah !'], 401);
        }
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logout berhasil !'], 200);
    }
}
