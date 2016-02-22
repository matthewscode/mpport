package com.mp.mpport.domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Client")
public class Client {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private int id;
	
	@Column(name = "client_name")
	private String clientName;
	
	@Column(name = "api_location")
	private String  apiLocation;
	
	@JsonIgnore
	@OneToMany(mappedBy = "client")
	private List<ClientKey> keyList;

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

	public List<ClientKey> getKeyList() {
		return keyList;
	}

	public void setKeyList(List<ClientKey> keyList) {
		this.keyList = keyList;
	}
	
	
}
