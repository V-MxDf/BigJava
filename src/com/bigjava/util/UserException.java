package com.bigjava.util;

public class UserException extends Exception{

    private String message;

    public String getMessage(){
        return message;
    }
    public UserException(){
        super();
    }

    public UserException(String message) {
        super(message);
        this.message = message;
    }

}
