package com.example.firstprojects;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import java.io.IOException;


public class ConvertTextToImage {

    Bitmap convert(final String text) throws IOException {
        Paint paint = new Paint();
        Paint paintName = new Paint();

        Bitmap bitmap = Bitmap.createBitmap(230, 18, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paintName.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        paintName.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paintName.setColor(Color.BLACK);
        paint.setTextSize(11);
        paintName.setTextSize(30);
        canvas.drawText(text, 230, 10, paintName);
        return bitmap;
    }

    Bitmap keyValue(String title, String value) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 40, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(25);
        canvas.drawText(title, 550, 30, paint);
        canvas.drawText(value, 350, 30, paint);
        return bitmap;
    }

    Bitmap footer(String title, String value) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 40, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(25);
        canvas.drawText(title, 500, 30, paint);
        canvas.drawText(value, 170, 30, paint);
        return bitmap;
    }

    Bitmap dddd(String title1, String value1, String title2, String value2) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 40, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(25);
        canvas.drawText(title1, 550, 30, paint);
        canvas.drawText(value1, 350, 30, paint);

        canvas.drawText(title2, 250, 30, paint);
        canvas.drawText(value2, 120, 30, paint);
        return bitmap;
    }

    Bitmap statementDetails(String value) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 40, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(25);
        canvas.drawText(value, 250, 30, paint);
        return bitmap;
    }

    Bitmap companyName(String title) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 50, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.CENTER);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(35);
        canvas.drawText(title, 275, 45, paint);

        return bitmap;
    }

    Bitmap header(String title) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 35, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.CENTER);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(27);
        canvas.drawText(title, 275, 30, paint);


        return bitmap;
    }

    Bitmap headersubTitle(String title) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 30, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.CENTER);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(20);
        canvas.drawText(title, 275, 25, paint);
        return bitmap;
    }

    Bitmap ItemRow(String title, Paint.Align align) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 40, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(align);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(25);
        canvas.drawText(title, 550, 30, paint);
        return bitmap;
    }

    Bitmap ItemTitle(String title, Paint.Align align) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 40, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(align);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(25);
        paint.setUnderlineText(true);
        paint.setFakeBoldText(true);
        canvas.drawText(title, 550, 30, paint);
        return bitmap;
    }

    Bitmap item(String dueDate, String status, String amount, String balance) {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 50, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(23);
        canvas.drawText(dueDate, 550, 30, paint);
        canvas.drawText(status, 370, 30, paint);
        canvas.drawText(amount, 190, 30, paint);
        canvas.drawText(balance, 80, 30, paint);
        canvas.drawText(new String(new char[10]).replace("\0", "---------------"), 550, 55, paint);

        return bitmap;
    }

    Bitmap itemHeader() {

        Paint paint = new Paint();


        Bitmap bitmap = Bitmap.createBitmap(550, 50, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        paint.setColor(Color.WHITE);
        paint.setTextAlign(Paint.Align.RIGHT);
        canvas.drawRect(0, 0, bitmap.getWidth(), bitmap.getHeight(), paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(23);
        canvas.drawText(new String(new char[10]).replace("\0", "---------------"), 550, 8, paint);
        canvas.drawText("التاريخ المستحق", 550, 30, paint);
        canvas.drawText("الحالة", 370, 30, paint);
        canvas.drawText("المبلغ", 190, 30, paint);
        canvas.drawText("الرصيد", 80, 30, paint);
        canvas.drawText(new String(new char[10]).replace("\0", "---------------"), 550, 50, paint);

        return bitmap;
    }

}
