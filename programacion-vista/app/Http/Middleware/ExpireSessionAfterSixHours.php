<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\UserSession;
use Illuminate\Support\Carbon;
use Symfony\Component\HttpFoundation\Response;

class ExpireSessionAfterSixHours
{
    public function handle(Request $request, Closure $next): Response
    {
        if (Auth::check()) {
            $sessionId = $request->session()->get('user_session_id');

            if ($sessionId) {
                $userSession = UserSession::where('id_session', $sessionId)
                    ->where('id_usuario', Auth::id())
                    ->first();

                if (
                    !$userSession ||
                    $userSession->session_end !== null ||
                    Carbon::parse($userSession->session_start)->addHours(6)->isPast()
                ) {

                    if ($userSession && $userSession->session_end === null) {
                        $userSession->update([
                            'session_end' => Carbon::now(),
                        ]);
                    }

Auth::guard('web')->logout();

                    $request->session()->invalidate();
                    $request->session()->regenerateToken();

                    return redirect()->route('login')->withErrors([
                        'email' => 'Tu sesión ha expirado por seguridad. Iniciá sesión nuevamente.',
                    ]);
                }
            }
        }

        return $next($request);
    }
}
