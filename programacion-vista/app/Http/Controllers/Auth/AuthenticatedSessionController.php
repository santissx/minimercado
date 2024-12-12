<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class AuthenticatedSessionController extends Controller
{
    /**
     * Display the login view.
     */
    public function create(): View
    {
        return view('auth.login');
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): RedirectResponse
{
        // Intenta autenticar al usuario
        $request->authenticate();

        // Obtiene el usuario autenticado
        $user = Auth::user();

        // Verifica si el estado del usuario es "activo"
        if ($user->estado !== 'activo') {
            // Si el estado no es "activo", cierra la sesión y lanza un error
            Auth::logout();
            return redirect()->back()->withErrors([
                'email' => 'Tu cuenta no está activa. Por favor, contacta al administrador.',
            ]);
        }

        // Regenera la sesión
        $request->session()->regenerate();

        // Redirige según el rol del usuario
        if ($user->rol === 'administrador') {
            return redirect()->intended(route('views.ventas'));
        } elseif ($user->rol === 'empleado') {
            return redirect()->intended(route('views.ventas'));
        } else {
            // Si no tiene un rol reconocido, redirige a una ruta por defecto
            return redirect()->intended(route('login'));
        }
}
    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/login');

    }
}