<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\UserSession;
use Illuminate\Support\Carbon;

class ClosePreviousSessions extends Command
{
    protected $signature = 'app:close-previous-sessions';

    protected $description = 'Cierra las sesiones que quedaron abiertas de ejecuciones anteriores';

    public function handle(): int
    {
        $cantidad = UserSession::whereNull('session_end')->update([
            'session_end' => Carbon::now(),
        ]);

        $this->info("Se cerraron {$cantidad} sesiones anteriores.");

        return self::SUCCESS;
    }
}
