package myShop;
/*
 * Sample JavaBean for ST8016
 * To illustrate the basic implementation concept of
 * a Shopping Cart with basic add to cart, list items,
 * validate duplicates, total price computing
 * and checkout features.
 *
 * ProductBean plays an important part of the shoppingCart demo.
 * It simulates individual item that can be stored in the cart.
 */

/*
    Name            : Nanda Min Naing
    Course          : ST8016
    Class           : SECT\VC\1A\02
    Admission No    : P1257506
*/

import java.io.Serializable;
import java.util.Date;

/**
 * @author Karl Kwan
 */
public class CustomerBean extends Object implements Serializable {

    private String email = "";
    private String name = "";
    private String userid = "";
    private String contactnumber = "";
    private String address = "";
    private String cardno = "";
    private String cardholdername = "";
    private Date expiry;
    private String securitycode = "";
    // You can add in more fields here if needed
    // e.g. private double discountRate = 0.0;
    //      private double weight = 0.0;
    //      private double tax = 0.0 ;

    public CustomerBean() {
        // default class constructor, no special is required. 
    }

    void clone(CustomerBean otherProd) {
        // This method copy all the attributes (except the product ID)
        // from another product.
        this.email = otherProd.getEmail();
        this.userid = otherProd.getUserid();
        this.name = otherProd.getName();
        this.contactnumber = otherProd.getContactnumber();
        this.cardno = otherProd.getCardno();
        this.cardholdername = otherProd.getCardholdername();
        this.securitycode = otherProd.getSecuritycode();
        this.expiry = otherProd.getExpiry();
        this.address = otherProd.getAddress();
    }

    // All the methods at below are either setters or getters
    public String getCardno() {
        return cardno;
    }
    
    public void setCardno(String cardno) {
        this.cardno= cardno;
    }
    
    public String getCardholdername() {
        return cardholdername;
    }
    
    public void setCardholdername(String cardholdername) {
        this.cardholdername= cardholdername;
    }
    
    public Date getExpiry() {
        return expiry;
    }
    
    public void setExpiry(Date expiry) {
        this.expiry= expiry;
    }
    
    public String getSecuritycode() {
        return securitycode;
    }
    
    public void setSecuritycode(String securitycode) {
        this.securitycode= securitycode;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email= email;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserid() {
        return userid;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactnumber() {
        return contactnumber;
    }

    public void setContactnumber(String contactnumber) {
        this.contactnumber = contactnumber;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

}