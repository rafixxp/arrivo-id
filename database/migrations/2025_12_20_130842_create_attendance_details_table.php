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
        Schema::create('attendance_details', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('company_id')->nullable()->unsigned();
            $table->bigInteger('branch_id')->nullable()->unsigned();
            $table->bigInteger('attendance_id')->nullable()->unsigned();
            $table->time('time')->nullable();
            $table->string('attend')->nullable();
            $table->string('type')->nullable();
            $table->string('path')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance_details');
    }
};
