<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Cars
 *
 * @property int $id
 * @property string|null $name
 * @property string $registration
 * @property string|null $vin
 * @property int|null $phone
 * @property string|null $description
 * @property \Illuminate\Support\Carbon $created_at
 * @property \Illuminate\Support\Carbon $updated_at
 * @property int $enabled
 * @method static \Illuminate\Database\Eloquent\Builder|Cars newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Cars newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Cars query()
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereEnabled($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars wherePhone($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereRegistration($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Cars whereVin($value)
 * @mixin \Eloquent
 */
class Cars extends Model
{
    use HasFactory;
}
