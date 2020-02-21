package validation;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public interface AbstractValidator {

    public static final List<String> stazioni = Arrays.asList("Palermo", "Messina", "Catania", "Napoli", "Roma", "Firenze", "Bologna", "Venezia", "Milano", "Torino");

    public static final String DATE_REGEX = "^([0-9]{2})\\/([0-9]{2})\\/([0-9]{4})$";
    public static final String TIME_REGEX = "^([01][0-9]|[2][0-3]):([0-5]\\d)$";
    public static final String NUMERIC_REGEX = "^[0-9]+$";
    public static final String ALPHANUM_REGEX = "^[a-zA-Z0-9]+$";

//    public Map<String, String> validate (String ... s);

}
