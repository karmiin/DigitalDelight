// Cart.java
package it.unisa.model;

import org.apache.commons.math3.util.Precision;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Product, Integer> items;

    public Cart() {
        items = new HashMap<>();
    }

    public void addItem(Product product, int quantity) {
        if (items.containsKey(product)) {
            items.compute(product, (k, currentQuantity) -> currentQuantity + quantity);
        } else {
            items.put(product, quantity);
        }
    }

    public void updateItem(Product product, int quantity) {
        items.put(product, quantity);
    }

        public Map<Product, Integer> getItems() {
        return items;
    }

    public int getProductId(Product product) {
        return product.getId();
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

    public double getGrandTotal() {
        return Precision.round(items.entrySet().stream()
                .mapToDouble(entry -> entry.getKey().getPrice() * entry.getValue())
                .sum()
    ,2);
    }
}