/*
package com.example.solar.payload;




import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginRequest {
    // Setter for email
    // Getter for email
    private String email;
    // Setter for password
    // Getter for password
    private String password;

}
*/

package com.example.solar.payload;

public class LoginRequest {
    private String email;
    private String password;

    // Default constructor
    public LoginRequest() {}

    // Constructor with parameters
    public LoginRequest(String email, String password) {
        this.email = email;
        this.password = password;
    }

    // Getters and Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
