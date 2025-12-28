<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('schedules', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('company_id')->nullable()->unsigned();
            $table->bigInteger('branches_id')->nullable()->unsigned();
            $table->string('user_id')->nullable();
            $table->date('date')->nullable();
            $table->string('shift')->nullable();
            $table->time('clock_in')->nullable();
            $table->time('late_time')->nullable();
            $table->time('clock_out')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedules');
    }
};
