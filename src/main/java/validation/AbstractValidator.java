package validation;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public interface AbstractValidator {

    public static final List<String> stazioni = Arrays.asList("Palermo", "Messina", "Catania", "Napoli", "Roma", "Firenze", "Bologna", "Venezia", "Milano", "Torino");

    public static final String DATE_REGEX = "^([0-9]{2})\\/([0-9]{2})\\/([0-9]{4})$";
    public static final String PHONE_REGEX = "^[+]{0,1}[0-9]{4,}$";
    public static final String NAME_REGEX = "^[^\\^!\"£$%\\&/()=|\\<\\>\\[\\]\\{\\}@#°§_:.;,^+0-9]+$";
    public static final String NAMENUM_REGEX = "^[^\\^!\"£$%\\&/()=|\\<\\>\\[\\]\\{\\}@#°§_:.;,^]+$";
    public static final String ALPHANUM_REGEX = "^[a-zA-Z0-9]+$";
    public static final String CRO_REGEX = "^[a-zA-Z0-9-]+$";
    public static final String NUMERIC_REGEX = "^[0-9]+$";
    public static final String CIVICO_REGEX = "^[a-zA-Z0-9\\/]+$";
    public static final String IMPORTO_REGEX = "^[0-9,.]+$";
    public static final String IBAN_REGEX = "^[a-zA-Z0-9]{15,31}$";
    public static final String CAP_REGEX = "^[0-9]{5,5}+$";

//    public Map<String, String> validate (String ... s);

}
