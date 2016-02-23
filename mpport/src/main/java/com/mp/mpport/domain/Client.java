package com.mp.mpport.domain;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;


@Entity
@Table(name = "client")
public class Client {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private int id;
	
	@Column(name = "client_name")
	private String clientName;
	
	@Column(name = "api_location")
	private String apiLocation;
	
	@Column(name = "slug")
	private String slug;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getApiLocation() {
		return apiLocation;
	}

	public void setApiLocation(String apiLocation) {
		this.apiLocation = apiLocation;
	}

	public String getSlug() {
		return slug;
	}

	public void setSlug(String slug) {
		this.slug = slug;
	}

	
	
}
