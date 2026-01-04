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
        Schema::create('payslip_users', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('company_id')->unsigned()->nullable();
            $table->bigInteger('branch_id')->unsigned()->nullable();
            $table->bigInteger('users_id')->unsigned()->nullable();
            $table->bigInteger('payslip_id')->unsigned()->nullable();
            $table->string('name')->nullable();
            $table->tinyInteger('present')->unsigned()->nullable();
            $table->tinyInteger('absence')->unsigned()->nullable();
            $table->tinyInteger('sick')->unsigned()->nullable();
            $table->tinyInteger('leave')->unsigned()->nullable();
            $table->tinyInteger('alpha')->unsigned()->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payslip_users');
    }
};
