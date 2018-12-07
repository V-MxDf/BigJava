package com.bigjava.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

public class VerifyCode {
    private int height = 35;
    private int weight = 70;
    private Random random = new Random();
    private String[] fontNames = {"宋体", "微软雅黑", "黑体"};
    private String codes = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    private Color backgroundColor = new Color(255, 255, 255);

    private String text;

    //返回随机颜色
    private Color randomColor() {
        int green = random.nextInt(150);
        int blue = random.nextInt(150);
        int red = random.nextInt(150);
        return new Color(green, blue, red);
    }

    //随机字体
    private Font randomFont() {
        int index = random.nextInt(fontNames.length);
        //随机字体名称
        String name = fontNames[index];
        //生成随机的样式, 0(无样式), 1(粗体), 2(斜体), 3(粗体+斜体)
        int style = random.nextInt(3);
        //随即大小
        int size = random.nextInt(5) + 24;

        return new Font(name, style, size);
    }

    //干扰线
    private void drawLine(BufferedImage image) {
        int num = 5;  //一共画五条
        Graphics2D graphics2Dh = (Graphics2D) image.getGraphics();
        for (int i = 0; i <= num; i++) {
            int x1 = random.nextInt(height);
            int y1 = random.nextInt(weight);

            int x2 = random.nextInt(height);
            int y2 = random.nextInt(weight);
            graphics2Dh.setStroke(new BasicStroke(1.5F));
            graphics2Dh.setColor(backgroundColor);
            graphics2Dh.drawLine(x1, y1, x2, y2);
        }
    }


    //随机生成一个字符
    private char randomCodes() {
        int index = random.nextInt(codes.length());
        return codes.charAt(index);
    }

    //创建BufferedImage
    private BufferedImage createImage() {
        BufferedImage bufferedImage = new BufferedImage(weight, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics2D = (Graphics2D) bufferedImage.getGraphics();
        graphics2D.setColor(this.backgroundColor);
        graphics2D.fillRect(0, 0, weight, height);
        return bufferedImage;
    }

    //调用这个方法得到验证码
    public BufferedImage getImage() {
        BufferedImage image = createImage();    //创建图片缓冲区域
        Graphics2D graphics2D = (Graphics2D) image.getGraphics();   //得到绘制环境
        StringBuilder stringBuilder = new StringBuilder();    //用来装载生成的验证码文本
        for (int i = 0; i < 4; i++) {    //向图片中画四个字符
            String code = randomCodes() + "";   //随机生成一个字符
            stringBuilder.append(code);   //添加到stringBuilder中
            float x = i * 1.0F * weight / 4;    //设置当前字符的x轴坐标
            graphics2D.setColor(randomColor());    //设置随机颜色
            graphics2D.setFont(randomFont());   //设置随机字体
            graphics2D.drawString(code, x, height - 5);  //画图
        }
        this.text = stringBuilder.toString();   //把生成的字符串添加到当前的文本框中
        drawLine(image);    //添加干扰线
        return image;
    }

    //返回文本
    public String getText() {
        return this.text;
    }

    //保存图片到指定的输出流
    public  void output(BufferedImage image, OutputStream outputStream) throws IOException {
        ImageIO.write(image, "JPEG",outputStream );
    }
}
