<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Cars;
use Illuminate\Contracts\View\View;

class CarsController extends Controller
{
    public function list(): View
    {
        $cars = Cars::paginate(20);

        return view('cars.list', ['cars' => $cars]);
    }
}
