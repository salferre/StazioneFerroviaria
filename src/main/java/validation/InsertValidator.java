package validation;

import java.util.HashMap;
import java.util.Map;

public class InsertValidator implements AbstractValidator {

    public static Map<String, String> validate(String numeroTreno, String stazionePartenza, String stazioneArrivo, String giornoPartenza, String oraPartenza, String binario) {

        Map<String, String> errors = new HashMap<>();

        if (rejectIfNullOrWhiteSpace(numeroTreno)) {
            errors.put("numeroTreno", "Inserire numero treno!");
        } else {
            if (!numeroTreno.matches(NUMERIC_REGEX)) {
                errors.put("numeroTreno", "Il numero treno può contenere solo caratteri numerici!");
            }
        }

        if (rejectIfNullOrWhiteSpace(stazionePartenza)) {
            errors.put("stazionePartenza", "Inserire stazione di partenza!");
        } else {
            if (!checkStazioneExists(stazionePartenza)) {
                errors.put("stazionePartenza", "Inserire una stazione di partenza fra quelle in lista!");
            }
        }

        if (rejectIfNullOrWhiteSpace(stazioneArrivo)) {
            errors.put("stazionePartenza", "Inserire stazione di partenza!");
        } else {
            if (!checkStazioneExists(stazioneArrivo)) {
                errors.put("stazionePartenza", "Inserire una stazione di partenza fra quelle in lista!");
            }
        }

        if(rejectIfNullOrWhiteSpace(giornoPartenza)){
            errors.put("giornoPartenza", "Inserire giorno di partenza!");
        } else {
            if(!giornoPartenza.matches(DATE_REGEX)){
                errors.put("giornoPartenza", "Inserire il giorno della partenza in formato dd/mm/yyyy!");
            }
        }

        //TODO continuare validazione orario e binario

        return errors;
    }

    public static boolean checkStazioneExists(String stazione){
        return stazioni.contains(stazione);
    }

    public static boolean rejectIfNullOrWhiteSpace(String toCheck){
        return (toCheck == null || toCheck.trim().isEmpty());
    }

}
