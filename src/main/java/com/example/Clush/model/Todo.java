package com.example.Clush.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Todo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String task;
	private int done;
	
	//지도관련
	private Double latitude; //위도
	private Double longitude; //경도
	private String address;

}
