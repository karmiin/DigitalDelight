package it.unisa.model;

public class Order {
	private int id;
	private int userId;
	private double total;
	private String status;
	private String date;

	public Order() {
		super();
	}

	public Order(int id, int userId, double total, String status, String date) {
		super();
		this.id = id;
		this.userId = userId;
		this.total = total;
		this.status = status;
		this.date = date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
