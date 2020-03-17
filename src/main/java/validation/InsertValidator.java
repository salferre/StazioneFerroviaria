package validation;

import java.util.*;

public class InsertValidator implements AbstractValidator {

    public static Map<String, String> validate(String numeroTreno, String stazionePartenza, String stazioneArrivo,
                                               String giornoPartenza, String oraPartenza, String binario, List<String> tappe) {

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
            errors.put("stazioneArrivo", "Inserire stazione di arrivo!");
        } else {
            if (!checkStazioneExists(stazioneArrivo)) {
                errors.put("stazioneArrivo", "Inserire una stazione di arrivo fra quelle in lista!");
            }
        }

        if(rejectIfNullOrWhiteSpace(giornoPartenza)) {
            errors.put("giornoPartenza", "Inserire il giorno della partenza!");
        } else {
            if(!giornoPartenza.matches(DATE_REGEX)) {
                errors.put("giornoPartenza", "Inserire il giorno della partenza in formato dd/mm/yyyy!");
            }
        }

        if(rejectIfNullOrWhiteSpace(oraPartenza)) {
            errors.put("oraPartenza", "Inserire l'ora della partenza!");
        } else {
            if(!oraPartenza.matches(TIME_REGEX)) {
                errors.put("oraPartenza", "Inserire l'ora della partenza in formato hh:mm!");
            }
        }

        if (rejectIfNullOrWhiteSpace(binario)) {
            errors.put("binario", "Inserire binario!");
        } else {
            if (!binario.matches(NUMERIC_REGEX)) {
                errors.put("binario", "Il binario può contenere solo caratteri numerici!");
            }
        }

        if(checkDuplicateStation(tappe)){
            errors.put("tappe", "Impossibile inserire la stessa stazione più volte!");
        }

        return errors;
    }

    public static boolean checkStazioneExists(String stazione){
        return stazioni.contains(stazione);
    }

    public static boolean rejectIfNullOrWhiteSpace(String toCheck){
        return (toCheck == null || toCheck.trim().isEmpty());
    }

    public static boolean checkDuplicateStation(List<String> tappe){
        Set<String> set = new HashSet<>(tappe);
        if(set.size() < tappe.size()){
            return true;
        }
        return false;
    }

}
