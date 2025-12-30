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
        Schema::create('payslip_setting_details', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('company_id')->unsigned()->nullable();
            $table->bigInteger('branch_id')->unsigned()->nullable();
            $table->bigInteger('payslip_id')->unsigned()->nullable();
            $table->string('name')->nullable();
            $table->string('type')->nullable();
            $table->bigInteger('time_id')->unsigned()->nullable();
            $table->bigInteger('criteria_id')->unsigned()->nullable();
            $table->tinyInteger('quantity')->unsigned()->nullable();
            $table->bigInteger('value')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payslip_setting_details');
    }
};
