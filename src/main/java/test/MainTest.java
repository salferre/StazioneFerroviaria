package test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MainTest {

    public static void main(String[] args) throws ParseException {
        String myTime = "14:10";
        SimpleDateFormat df = new SimpleDateFormat("HH:mm");
        Date d = df.parse(myTime);
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.add(Calendar.MINUTE, 10);
        String newTime = df.format(cal.getTime());
        System.out.println(newTime);
    }

}
