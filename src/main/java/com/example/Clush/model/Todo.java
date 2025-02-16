package com.example.Clush.model;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
@Schema(description = "할 일 정보")
public class Todo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Schema(description = "할 일의 고유 id", example = "1")
	private Long id;
	
	@Schema(description = "할 일", example = "Clush 덕분에 좋은 경험")
	private String task;
	
	private int done;
	
	//지도관련
	private Double latitude; //위도
	private Double longitude; //경도
	private String address;

}
