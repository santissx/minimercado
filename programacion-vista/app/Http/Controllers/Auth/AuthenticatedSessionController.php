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

    // Regenera la sesión
    $request->session()->regenerate();

      // Obtiene el usuario autenticado
      $user = Auth::user();

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