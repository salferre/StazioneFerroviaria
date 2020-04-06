package dao.models;

import java.util.ArrayList;
import java.util.List;

public class Utente {

    private String username;
    private List<String> privileges;

    public Utente() {
    }

    public Utente(String username, List<String> privileges) {
        this.username = username;
        this.privileges = privileges;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<String> getPrivileges() {
        return privileges;
    }

    public void setPrivileges(List<String> privileges) {
        this.privileges = privileges;
    }
}
