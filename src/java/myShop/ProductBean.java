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

import java.io.Serializable;

/**
 * @author Karl Kwan
 */
public class ProductBean extends Object implements Serializable {

    private String prodID = "";
    private String prodName = "";
    private int prodQty = 0;
    private double prodPrice = 0.0;
    private String prodDesc = "";
    private String extraField1 = "";
    private String extraField2 = "";
    // You can add in more fields here if needed
    // e.g. private double discountRate = 0.0;
    //      private double weight = 0.0;
    //      private double tax = 0.0 ;

    public ProductBean() {
        // default class constructor, no special is required. 
    }

    public String getProdTotal() {
        // This method returns the subtotal of the current product.
        return String.format("%.2f", this.prodPrice * this.prodQty);
    }

    void clone(ProductBean otherProd) {
        // This method copy all the attributes (except the product ID)
        // from another product.
        this.prodName = otherProd.getProdName();
        this.prodDesc = otherProd.getProdDesc();
        this.prodPrice = otherProd.getProdPrice();
        this.prodQty = otherProd.getProdQty();
        this.extraField1 = otherProd.getExtraField1();
        this.extraField2 = otherProd.getExtraField2();
    }

    // All the methods at below are either setters or getters
    //
    public String getProdID() {
        return prodID;
    }

    public void setProdID(String prodID) {
        this.prodID = prodID;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public int getProdQty() {
        return prodQty;
    }

    public void setProdQty(int prodQty) {
        this.prodQty = prodQty;
    }

    public void setProdQty(String prodQty) {
        // validate if prodQty is an Integer
        int newQty = 0;
        try {
            newQty = Integer.parseInt(prodQty);
        } catch (NumberFormatException ex) {
            // prodQty does not contains a valid value.
        }
        this.prodQty = newQty;
    }

    public double getProdPrice() {
        return prodPrice;
    }

    public void setProdPrice(double prodPrice) {

        this.prodPrice = prodPrice;
    }

    public void setProdPrice(String prodPrice) {
        double newPrice = 0.0;
        // validate if prodQty is an Integer

        try {
            newPrice = Double.parseDouble(prodPrice);
        } catch (NumberFormatException ex) {
            // prodPrice does not contains a valid value.
        }
        this.prodPrice = newPrice;
    }

    /**
     * @return the prodDesc
     */
    public String getProdDesc() {
        return prodDesc;
    }

    /**
     * @param prodDesc the prodDesc to set
     */
    public void setProdDesc(String prodDesc) {
        this.prodDesc = prodDesc;
    }

    /**
     * @return the extraField1
     */
    public String getExtraField1() {
        return extraField1;
    }

    /**
     * @param extraField1 the extraField1 to set
     */
    public void setExtraField1(String extraField1) {
        this.extraField1 = extraField1;
    }

    /**
     * @return the extraField2
     */
    public String getExtraField2() {
        return extraField2;
    }

    /**
     * @param extraField2 the extraField2 to set
     */
    public void setExtraField2(String extraField2) {
        this.extraField2 = extraField2;
    }
}
