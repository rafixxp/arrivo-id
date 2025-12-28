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
        Schema::create('attendance_headers', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('company_id')->nullable()->unsigned();
            $table->bigInteger('branch_id')->nullable()->unsigned();
            $table->bigInteger('user_id')->nullable()->unsigned();
            $table->date('date')->nullable();
            $table->bigInteger('schedule_id')->nullable()->unsigned();
            $table->tinyInteger('status')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance_headers');
    }
};
