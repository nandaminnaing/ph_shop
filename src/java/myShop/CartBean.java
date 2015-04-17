/*
 * Sample JavaBean for ST8016
 * To illustrate the basic implementation concept of
 * a Shopping Cart with basic add to cart, list items,
 * validate duplicates, total price computing
 * and checkout features.
 *
*/
package myShop;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Karl Kwan
 */
// You may use the <jsp:useBean > action tag in a jsp page to
// create a shopping Cart object
// Usage in jsp page :
// <jsp:useBean class="myShop.CartBean" id="myCart" scope="session" />
//
// The above sample creates a session variable, myCart.
// myCart is an instance of CartBean, and the jsp page can use it to
// carry out the shopping cart operations.
// myCart is declared as a session variable, thus, the shopping cart content
// can be kept within the same browser session.

public class CartBean extends Object implements Serializable {
    // declaring an internal List to serve as the internal store of
    // all the items. The name of the List is 'shoppingCart'
    // The items in the list must be ProductBean type.
    // Please refer to the source code of ProductBean to find out what can be
    // stored in each ProductBean item.

    // The initial size of the shoppingCart List is only 3. But it can
    // grow dynamically when more items are being add into it.
    private List<ProductBean> shoppingCart = new ArrayList<ProductBean>(3);

    public CartBean() {
        // default class contructor, in this case, no special
        // operation is required here.
    }

    public int getNoItems() {
        // This method returns the current size of the shoppingCart List
        // In other word : It gives the number of
        // items currently insider the shopping Cart.
        // Usage in jsp page :
        // ${myCart.noItems}
        return shoppingCart.size();
    }

    private int findItemIndex(String prodID) {
        // an internal helper method to locate the target product with
        // a given product ID from the shopping cart
        // it will return the index of the item when it is found
        // otherwise it will return -1
        // As this is an internal (private) method, jsp page cannot invoke this
        // method directly.

        int noItems;
        noItems = getNoItems();
        // loop thru all the current stored items and
        // see if a match can be found
        for (int i = 0; i < noItems; i++) {
            // get the next ProductBean object from the list
            ProductBean thisItem = shoppingCart.get(i);
            // compare the product IDs
            if (thisItem.getProdID().equals(prodID)) {
                return i; // item is found , return the index to the caller
            }
        }
        // None of the item is matched with the given Product ID
        // return -1 to the caller
        return -1; // item not found
    }

    public void setClearAll(String dummy) {
        // remove everything from the shoppingCart list
        // the String argument, 'dummy' , is really a dummy
        // all the JavaBean setters (the methods with 'set' as their prefix)
        // require to have input argument.
        // Usage in jsp page :
        // <jsp:setProperty name="myCart" property="clearAll" value="" />

        shoppingCart.clear();



    }

    public void setRemoveProduct(String prodID) {
        // This method will remove an item/product from  the shopping cart storage.
        // The targeted Product is based on the matching of the product ID (prodID)
      
        // There will be 2 possible cases
        // Case 1: The item is not found from the shopping cart storage, no action will be taken
        // Case 2: The item is found in the shopping cart, we can remove it.

        // To find the matched item is easy !
        // use the internal help method - findItemIndex()
        int index = findItemIndex(prodID);
        if (index != -1) {
                // using the list build-in method to remove the particular
                // item using the index value as an argument.
                shoppingCart.remove(index);
             
        }  // else the product is not found, do nothing
    }
public void setReduceProduct(String prodID) {
        // this method will reduce the quantity to be purchased from
        // a Product of the shopping cart storage.
        // The targeted Product is based on the matching of the product ID (prodID)
        // There will be 2 possible cases
        // Case 1: The item is not found from the shopping cart storage,
        //         no action will be taken
        // Case 2: The item is found in the shopping cart, we only need to
        //         update the qty of it accordingly, that's , to reduce it by 1.
        //         Moreover, if the qty is reduced to zero, we have to remove this item from
        //         the shopping cart completely.
          int index = findItemIndex(prodID);
        if (index != -1) {
            // The product is found, we need to take it out and
            // then subtract its qty by 1.
            ProductBean matchedProd = shoppingCart.get(index);
            // compute the new qty first.
            int newQty = matchedProd.getProdQty() - 1;
            // if the new qty value still more than 0,
            // we can proceed accordingly
            if (newQty > 0) {
                matchedProd.setProdQty(""+newQty); // update the qty accordingly
            } else {
                // Have to remove it completely ..
                shoppingCart.remove(index);
            }
        }  // else do nothing
    }

    public void setIncreaseProduct(String prodID) {
        // thisProd contains an item supposed to be added to the
        // shopping cart storage.
        // There will be 2 possible cases
        // Case 1: The item is new to the shopping cart storage,
        //         simply add it onto the shoppingCart list.
        //
        // Case 2: The item is already in the shopping cart, we only need to
        //         update the qty value of it accordingly,
        //         that's , to add in the additional qty from thisProd to
        //         the existing item.

        // using findItemIndex to check if thisProd is an new item.
        int index = findItemIndex(prodID);
        if (index != -1) {
            // it is not a new item
            ProductBean matchedProd = shoppingCart.get(index);
            // compute the new qty value by adding the new value to the
            // existing value
            int newQty = matchedProd.getProdQty() + 1;
            // now update the qty of the matchedProd.
            matchedProd.setProdQty(""+newQty); // update the qty accordingly
        }
    }
    
    public void setAddProduct(ProductBean thisProd) {
        // thisProd contains an item supposed to be added to the
        // shopping cart storage.
        // There will be 2 possible cases
        // Case 1: The item is new to the shopping cart storage, 
        //         simply add it onto the shoppingCart list.
        // 
        // Case 2: The item is already in the shopping cart, we only need to 
        //         update the qty value of it accordingly,
        //         that's , to add in the additional qty from thisProd to
        //         the existing item.

        // using findItemIndex to check if thisProd is an new item.
        int index = findItemIndex(thisProd.getProdID());
        if (index != -1) {
            // it is not a new item
            ProductBean matchedProd = shoppingCart.get(index);
            // compute the new qty value by adding the new value to the
            // existing value
            int newQty = matchedProd.getProdQty() + thisProd.getProdQty();
            // now update the qty of the matchedProd.
            matchedProd.setProdQty(""+newQty); // update the qty accordingly
        } else {
            // this is a new item.
            // can be added to the shoppingCart list directly
            shoppingCart.add(thisProd);
        }
    }
    public void setProduct(ProductBean thisProd) {
        // This method enable a direct product update feature.
        // As we are using Product ID as the item key.
        // We only update the qty (prodQty), price (prodPrice) and name (prodName)
        // attributes of the product.

        // There will be 2 possible cases
        // Case 1: The item is new to the shopping cart storage, simply add it onto
        //         the list
        // Case 2: The item is already in the shopping cart, we will
        //         overwrite its name, price, qty and the rest of attributes based on the
        //          values given by thisProd.
        
        // Remarks: compare the difference btw setProduct and setAddProduct.

        int index = findItemIndex(thisProd.getProdID());
        if (index != -1) {
            ProductBean matchedProd = (ProductBean) shoppingCart.get(index);
                matchedProd.clone(thisProd);
                // using the clone method to overWrite all the attributes
                // from thisProd to matchedProd
                // refers to ProductBean source of the clone method.
        } else {
            // this is a new item.
            // add to the shoppingCart list
            shoppingCart.add(thisProd);
        }
    }
    public ArrayList<ProductBean> getProducts() {
        // This a public method that allow caller to retrieve
        // all the stored products from the list in one go.
        // return the shopping Cart in terms of array of ProductBean

        return (ArrayList<ProductBean>)this.shoppingCart;

    }

    public String getTotal() {
        // The method return the total sum of purchase
        // to the caller
        // Take note that, we can use
        // thisProd.getProdTotal() to get the subtotal
        // of individual product.
        // Refers to the source code of ProductBean
        // to find out more of getProdTotal().

        int noItems;
        double billingTotal = 0.0; // initialize the billingTotal to 0.0
        noItems = getNoItems();

        for (int i = 0; i < noItems; i++) {
            ProductBean thisProd =
                     shoppingCart.get(i);
            
            billingTotal = billingTotal + Double.parseDouble(thisProd.getProdTotal());
        }
         return String.format("%.2f", billingTotal);
        
    }
}
