// Cart.java
package it.unisa.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Product, Integer> items;

    public Cart() {
        items = new HashMap<>();
    }

    public void addItem(Product product, int quantity) {
        if (items.containsKey(product)) {
            items.merge(product, quantity, Integer::sum);
        } else {
            items.put(product, quantity);
        }
    }

    public Map<Product, Integer> getItems() {
        return items;
    }

    public void removeItem(Product product) {
        items.remove(product);
    }

    public void clear() {
        items.clear();
    }

    public int getTotalQuantity(Product product) {
        return items.getOrDefault(product, 0);
    }
}