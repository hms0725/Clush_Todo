<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDB-l20C9L1cR8XYmyN9Olb-8TZ07ZPbd0&libraries=places" async defer></script>	
<meta charset="UTF-8">
<title>Todo(할일) List</title>
<script type="text/javascript" src="../js/jquery.js"></script>
</head>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
/* 전체 배경과 텍스트 */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f0f2f5;
    color: #333;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}
/* Todo 컨테이너 */
.todo-container {
    background-color: #fff;
    width: 100%;
    max-width: 700px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    text-align: center;
}
h1 {
    font-size: 24px;
    margin-bottom: 20px;
}
/* Todo 입력창 */
.todo-input {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}
.todo-input input,
.todo-input button {
    padding: 10px;
    font-size: 16px;
    border-radius: 4px;
}
.todo-input input {
    width: 80%;
    border: 1px solid #ddd;
}
.todo-input button {
    width: 15%;
    border: none;
    background-color: #4caf50;
    color: white;
    cursor: pointer;
}
.todo-input button:hover {
    background-color: #45a049;
}
/* Todo 리스트 스타일 */
ul {
    list-style-type: none;
    padding: 0;
}
li {
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 4px;
    margin-bottom: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}
li.completed {
    text-decoration: line-through;
    color: #888;
}
/* 버튼 공통 */
button {
    border: none;
    border-radius: 4px;
    cursor: pointer;
    padding: 5px 10px;
}
button.delete-btn {
    background-color: #e74c3c;
    color: white;
}
button.delete-btn:hover {
    background-color: #c0392b;
}
button.update-btn,
button.edit-btn {
    background-color: #3498db;
    color: white;
}
button.update-btn:hover,
button.edit-btn:hover {
    background-color: #2980b9;
}
/* 검색 창 */
.search-box {
    margin-top: 20px;
    margin-bottom: 10px;
    text-align: center;
}
.search-box input {
    padding: 10px;
    font-size: 16px;
    border-radius: 4px;
    border: 1px solid #ddd;
    width: 80%;
    max-width: 400px;
}
.todo-text {
    flex: 1; /* 내용이 버튼 그룹을 밀지 않고 적절히 늘어나도록 */
    word-break: break-word; /* 긴 단어도 줄바꿈 되도록 */
    margin-right: 20px; /* 버튼 그룹과 간격 */
}
.button-group {
    display: flex;
    gap: 10px; /* 버튼 사이 간격 */
}
.button-group button {
    white-space: nowrap; /* 버튼 내용이 두 줄로 나뉘지 않도록 */
}
.todo-text.completed {
    text-decoration: line-through;
    color: gray;
}
</style>

<script type="text/javascript">

	document.addEventListener("DOMContentLoaded",function(){	
		
		//지도버튼 클릭시
		document.querySelectorAll('.map-btn').forEach(button => {
		    button.addEventListener('click', function () {
		        // todos 배열이 정의되어 있어야만 정상 작동
		        if (!todos || todos.length === 0) {
		            console.error("No todos available");
		            return;
		        }		
		        const todoId = this.closest('li').id.split('-')[1];
		        const todo = todos.find(todo => todo.id == todoId);
		        if (todo && todo.latitude && todo.longitude) {
		            const lat = todo.latitude;
		            const lng = todo.longitude;
		            showLocationOnMap(lat, lng);  // 지도에서 해당 위치를 표시하는 함수
		        }
		    });
		});
				
		//할일 추가버튼 클릭시
		document.getElementById("add-btn").addEventListener("click",function(){							
			const task = document.getElementById("todo-input").value;//할일 컬럼은 input에 적힌 값과 같다
			const latitude = document.getElementById("latitude").value;
	        const longitude = document.getElementById("longitude").value;
	        const address = document.getElementById("address").value;
	        
			if(task.trim()===""){ 
				alert("할 일을 입력하세요.");
				return;
			}	
			//데이터전송
			fetch('/api/addtodo',{ 
				method:'POST',
				headers:{
					'Content-type':'application/json'
				},
				body: JSON.stringify({
					task: task,
					latitude: latitude,
					longitude: longitude,
					address: address
				}),
			})
			.then(response => response.json())	
			
			//새로 추가한 일정 화면에 표시하기
			.then(data => {
				console.log("Response received:", data);//값 잘나옴		
				if(data.success){ //할일이 성공적으로 추가되었을 때 화면에 반영
					const todo = data.todo;
					console.log("Todo object:", todo);	//값 잘나옴	
					
					const todoList = document.getElementById("todo-list");
					console.log("todoList object:", todoList);
					
					//새로 추가한 항목을 리스트에 추가
					const li = document.createElement("li");
					console.log("todo.id->"+todo.id);
					console.log(li);					
					li.id = 'todo-'+todo.id; //아이디 추가
					
					// 체크박스 추가
			        const checkbox = document.createElement("input");
			        checkbox.type = "checkbox";
			        checkbox.classList.add("todo-checkbox");
			        checkbox.checked = todo.done === 1;
					
					// 할 일 텍스트를 표시할 span 생성
					const todoText = document.createElement("span");
					todoText.classList.add("todo-text");
					todoText.textContent = todo.id +". "+ todo.task;
					console.log(todoText);
					
					// 페이지 렌더링 시 done 값이 1이면 가로줄 추가
			        if (todo.done === 1) {
			            todoText.style.textDecoration = "line-through";
			        }

			     	// 체크박스 상태 변경 시 가로줄 토글
			        checkbox.addEventListener('change', function() {
			            if (checkbox.checked) {
			                todoText.style.textDecoration = "line-through";
			                updateTodoStatus(todo.id, 1); // done 값을 1로 업데이트
			            } else {
			                todoText.style.textDecoration = "none";
			                updateTodoStatus(todo.id, 0); // done 값을 0으로 업데이트
			            }
			        });
					
					// 수정 폼 생성
					const form = document.createElement("form");
					form.action = "/api/updatetodo/" + todo.id; // 기존 폼처럼 서버로 데이터를 전송
					form.method = "POST";
					form.style.display = "none"; // 처음에는 숨김
					form.classList.add("edit-form"); // "edit-form" 클래스를 추가하여 검색할 수 있게

					const input = document.createElement("input");
					input.type = "text";
					input.name = "task"; // 서버에서 받을 name
					input.value = todo.task;
					form.appendChild(input);

					//주소 표시용 span생성
	                const addressText = document.createElement("span");
	                addressText.classList.add("address-text");
	                addressText.textContent = "주소: " + todo.address; // 주소 텍스트를 표시
	                console.log(addressText);					
					
					// 수정 버튼
					const editButton = document.createElement("button");
					editButton.textContent = "수정";
					editButton.classList.add("edit-btn");
					editButton.onclick = () => {
					    console.log("수정 버튼 클릭됨");
					    // 수정 버튼 클릭 시 todoText와 form을 찾기 위해 li 요소 내에서 검색
					    const li = editButton.closest("li"); // 수정 버튼이 클릭된 li 찾기
					    const text = li.querySelector(".todo-text"); // todo-text 찾기
					    const form = li.querySelector(".edit-form"); // edit-form 찾기

					    // 디버깅을 위해 text와 form을 출력
					    console.log(text, form);
					    if (text && form) {
					        // 기존 텍스트 숨기고 폼 보이기
					        text.style.display = "none";
					        form.style.display = "block";
					    } else {
					        console.log("요소를 찾지 못함");
					    }
					};

					// 삭제 버튼
					const deleteButton = document.createElement("button");
					deleteButton.textContent = "삭제";
					deleteButton.classList.add("delete-btn");
					deleteButton.onclick = () => {
					    todoList.removeChild(li); 
					};
					
					// 확인 버튼 (수정된 내용 저장)
					const confirmButton = document.createElement("button");
					confirmButton.textContent = "저장";
					confirmButton.classList.add("confirm-btn");
					confirmButton.onclick = (event) => {
					    event.preventDefault(); // 폼 제출을 방지 (수동으로 처리)					    
					    const li = confirmButton.closest("li");
					    const form = li.querySelector(".edit-form");
					    const input = form.querySelector("input");

					    if (input.value.trim() !== "") {// 입력된 값이 있다면 폼을 서버로 전송
					        form.submit(); // 서버로 제출
					    } else {
					        alert("할 일 내용을 입력해주세요.");
					    }
					};
					
					// 취소 버튼 추가
					const cancelButton = document.createElement("button");
					cancelButton.textContent = "취소";
					cancelButton.classList.add("cancel-btn");
					cancelButton.onclick = () => {
					    const li = cancelButton.closest("li");
					    const text = li.querySelector(".todo-text");
					    const form = li.querySelector(".edit-form");
					    form.style.display = "none";
					    text.style.display = "block";
					};
					
					// 지도 버튼 추가
	                const mapButton = document.createElement("button");
	                mapButton.textContent = "주소보기";
	                mapButton.classList.add("map-btn");

	             	// address 값 확인 후 조건 처리
	                if (!address || address.trim() === "") {  // address가 null, undefined, 빈 문자열일 때
	                    mapButton.onclick = () => {
	                        const popup = window.open('', 'addressPopup', 'width=600,height=400');
	                        popup.document.write(
	                            '<html>' +
	                            '<head><title>주소 정보</title></head>' +
	                            '<body>' +
	                            '<h2>주소 정보</h2>' +
	                            '<p>저장된 주소가 없습니다.</p>' +
	                            '<button onclick="window.close()">닫기</button>' +
	                            '</body>' +
	                            '</html>'
	                        );
	                    };
	                } else {
	                    mapButton.onclick = () => {
	                        const popup = window.open('', 'addressPopup', 'width=600,height=400');
	                        popup.document.write(
	                            '<html>' +
	                            '<head><title>주소 정보</title></head>' +
	                            '<body>' +
	                            '<h2>저장된 주소</h2>' +
	                            '<p>' + address + '</p>' +
	                            '<button onclick="window.close()">닫기</button>' +
	                            '</body>' +
	                            '</html>'
	                        );
	                    };
	                }				
					// 버튼들을 묶을 div 생성
			        const buttonGroup = document.createElement("div");
			        buttonGroup.classList.add("button-group"); // 버튼 그룹 클래스 추가

			        // 수정 및 삭제 버튼을 div에 추가
			        buttonGroup.appendChild(editButton);
			        buttonGroup.appendChild(deleteButton);
			        buttonGroup.appendChild(mapButton);

					// 버튼들을 li에 추가
					li.appendChild(todoText);
					li.appendChild(form); // form을 li에 추가
					li.appendChild(buttonGroup); // 버튼 그룹 div 추가
					li.appendChild(checkbox);
					
					// 리스트에 추가
					todoList.appendChild(li);
	
					// 확인버튼과 취소버튼을 폼에 추가
					form.appendChild(confirmButton);
					form.appendChild(cancelButton);	
					
					console.log("현재리스트:",todoList);//다른 일정은 다 나오는데 추가한 일정만 없음
					console.log("LI Element:", li);//여기 값이 안나옴
					
					//입력 필드 초기화(이거랑 자바스크립트로 function chk()if로 focus)
					const todoInput = document.getElementById("todo-input");
			        todoInput.value = "";
			        todoInput.focus();										
				}else {
					alert("할 일 추가에 실패했습니다.");
				}
			})
			.catch(error => {
				console.error("Fetch error:",error);
				alert("서버와 통신 중 오류가 발생했습니다.");
			});		
		});
	});	
	
	//일정 수정 
	document.addEventListener("DOMContentLoaded", function() {
        const editButtons = document.querySelectorAll(".edit-btn");
        
        editButtons.forEach(function(button) {
            button.addEventListener("click", function() {
                const li = button.closest("li");
                const text = li.querySelector(".todo-text");
                const form = li.querySelector(".edit-form");

                // 기존 텍스트 숨기고 폼 보이기
                text.style.display = "none";
                form.style.display = "block";
            });
        });
        const cancelButtons = document.querySelectorAll(".cancel-btn");
        cancelButtons.forEach(function(button) {
            button.addEventListener("click", function() {
                const li = button.closest("li");
                const text = li.querySelector(".todo-text");
                const form = li.querySelector(".edit-form");
                form.style.display = "none";
                text.style.display = "block";
            });
        });
    });
		
	//검색 창
	function filterTodos(){
		const searchInput = document.getElementById('search-input').value.toLowerCase();
		const todos = document.querySelectorAll('#todo-list li');		
		todos.forEach(todo => {
			const todoText = todo.querySelector('.todo-text').textContent.toLowerCase();			
			//한글, 숫자, 영어 모두 검색 가능하도록 처리
			if(todoText.includes(searchInput)){
				todo.style.display = ''; //검색어와 일치하는 항목은 보이게
			}else {
				todo.style.display = 'none'; //일치하지 않는 항목은 숨기기
			}
		});
	}

	// 지도 관련 API
	document.addEventListener("DOMContentLoaded", function() {
	    const mapElement = document.getElementById("map");
	    const mapModal = document.getElementById("map-modal");
	    const closeModalBtn = document.getElementById("close-map-btn");
	    let googleMap, marker;
	    if (mapElement) {
	        mapElement.addEventListener("click", function() {
	            mapModal.style.display = "block"; // 모달 창 열기
	            if (!googleMap) initGoogleMap(); // 구글 지도 초기화
	        });
	    } else {
	        console.error("Map element not found");
	    }
	    closeModalBtn.addEventListener("click", function() {
	        mapModal.style.display = "none"; // 모달 창 닫기
	    });
	    //구글지도 초기화
	    function initGoogleMap() {
	        const defaultLocation = { lat: 37.5665, lng: 126.9780 }; // 서울 중심 좌표
	        googleMap = new google.maps.Map(document.getElementById("popup-map"), {
	            center: defaultLocation,
	            zoom: 15
	        });
	        googleMap.addListener("click", function(event) {
	            const lat = event.latLng.lat();
	            const lng = event.latLng.lng();

	            if (marker) marker.setMap(null); // 기존 마커 제거
	            marker = new google.maps.Marker({
	                position: { lat, lng },
	                map: googleMap,
	                title: "선택한 위치"
	            });
	            // 위도와 경도 입력 필드에 값 설정
	            document.getElementById("latitude").value = lat;
	            document.getElementById("longitude").value = lng;
	            // 주소 가져오기
	            const geocoder = new google.maps.Geocoder();
	            geocoder.geocode({ location: event.latLng }, (results, status) => {
	                if (status === "OK" && results[0]) {
	                    document.getElementById("address").value = results[0].formatted_address; // 주소 입력
	                } else {
	                    alert("주소를 가져올 수 없습니다.");
	                }
	            });
	        });
	    }
	});
	
	// 지도 더블클릭 이벤트 처리
	document.addEventListener("DOMContentLoaded", function() {
	    const map = new google.maps.Map(document.getElementById("map"), {
	        center: { lat: 37.5665, lng: 126.9780 },  // 초기 위치: 서울
	        zoom: 14,
	    });
	    const geocoder = new google.maps.Geocoder();  // 주소를 좌표로 변환하는 Geocoder 객체
	    // 더블클릭 시 위치정보 받기
	    map.addListener('dblclick', function(event) {
	        const latLng = event.latLng;  // 더블클릭한 위치의 LatLng 객체
	        
	        // 더블클릭한 위치에서 위도, 경도 추출
	        const lat = latLng.lat();
	        const lng = latLng.lng();
	        console.log("위도: " + lat, "경도: " + lng);
	        
	        // Geocoder로 주소 정보 요청
	        geocoder.geocode({ 'location': latLng }, function(results, status) {
	            if (status === 'OK' && results[0]) {
	                const address = results[0].formatted_address;
	                console.log("주소: " + address);

	                // 주소와 좌표를 화면에 표시 (예: 입력 필드에 주소 설정)
	                document.getElementById("address").value = address;
	                document.getElementById("latitude").value = lat;
	                document.getElementById("longitude").value = lng;
	            } else {
	                console.error("주소를 찾을 수 없습니다. 상태: " + status);
	                alert("주소를 찾을 수 없습니다. 상태: " + status);
	            }
	        });
	    });
	});
	
	//지도버튼 클릭 시
	document.addEventListener('DOMContentLoaded', function() {
	    const mapBtns = document.querySelectorAll('.map-btn');
	    mapBtns.forEach(function(button) {
	        button.addEventListener('click', function() {
	            const todoItem = button.closest('li');
	            console.log('todoItem:',todoItem);
	            const address = todoItem.getAttribute('data-address')||"저장 된 주소가 없습니다.";
	            console.log('주소:',address);	            
	            // 새로운 팝업 창을 열어서 주소를 표시
	            const popup = window.open('', 'addressPopup', 'width=600,height=400');         
	            // 새 탭에서 주소 정보를 표시
	            popup.document.write(
	            		'<html>' +
	            	    '<head><title>주소 정보</title></head>' +
	            	    '<body>' +
	            	    '<h2>저장된 주소</h2>' +
	            	    '<p>' + address + '</p>' +  
	            	    '<button onclick="window.close()">닫기</button>' +
	            	    '</body>' +
	            	    '</html>'
	            );
	        });
	    });
	});

	//할 일 완료 여부
	document.addEventListener('DOMContentLoaded', function() {
	    const checkboxes = document.querySelectorAll('.complete-checkbox');	
	    checkboxes.forEach(function(checkbox) {
	        checkbox.addEventListener('change', function() {
	            console.log("체크박스 클릭 됨");
	            const todoItem = checkbox.closest('li');
	            const todoText = todoItem.querySelector('.todo-text'); // todo-text span 선택
	            const todoId = checkbox.dataset.id; // 해당 할일의 ID 가져오기
	            const isChecked = checkbox.checked; // 체크 여부 확인
	            const done = isChecked ? 1 : 0; // 상태 결정
	
	            if (isChecked) { 
	                todoText.classList.add('completed'); // 완료된 경우 가로줄 추가
	            } else {
	                todoText.classList.remove('completed'); // 아니면 가로줄 제거
	            }
	
	            // 서버에 상태 업데이트 요청 보내기 (AJAX)
	            fetch("/api/todoDone/" + todoId, {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify({ 
	                    done: done	                	
	                })
	            })
	            .then(response => {
	                if (response.ok) {
	                    alert("해당 할 일이 " + (done == 1 ? "완료" : "미완료") + "로 변경되었습니다.");
	                } else {
	                    alert('상태 업데이트에 실패했습니다.');
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	                alert('오류가 발생했습니다.');
	            });
	        });
	    });
	});
	
</script>
<body>
	<div class="todo-container">
		<h1>To do List</h1>
		
		<!-- 할일 입력 창 -->
		<div class="todo-input">
			<input type ="text" id="todo-input" placeholder="새 할 일을 추가하세요">
			<input type="hidden" id="latitude" placeholder="위도" readonly>
   			<input type="hidden" id="longitude" placeholder="경도" readonly>
   			<input type="text" id="address" placeholder="지도에서 위치를 선택하세요" readonly>
    		<div id="map" style="width:40%; height:100px;cursor: pointer;">
    		</div>
			<button id="add-btn">추가 하기</button>
		</div>	
		
		<!-- 지도 팝업 모달 -->
		<div id="map-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 1000;">
		    <div style="position: relative; width: 80%; height: 80%; margin: auto; top: 10%; background: white;">
		        <div id="popup-map" style="width: 100%; height: 100%;"></div>
		        <button id="close-map-btn" style="position: absolute; top: 10px; right: 10px;">닫기</button>
		    </div>
		</div>	
	
		<!-- 검색 창 추가 -->
		<div class="search-box">
			<input type="text" id="search-input" placeholder="찾는 할 일을 입력해보세요." onkeyup="filterTodos()">
		</div>	
		
		
		<!-- 저장된 할일목록 -->		
		<ul id="todo-list">
		    <c:forEach var="todos" items="${todos}">
		        <li id="todo-${todos.id}" data-address="${todos.address}">
		        
		            <!-- 체크박스 -->
		            <input type="checkbox" class="complete-checkbox" data-id="${todos.id}" 
		                   <c:if test="${todos.done == 1}">checked</c:if>>
		            <span class="todo-text <c:if test='${todos.done == 1}'>completed</c:if>">
		                ${todos.id}. ${todos.task}</span>		        
		                
		            <!-- 수정 폼 -->
		            <form action="/api/updatetodo/${todos.id}" method="POST" style="display:none;" class="edit-form">
		                <input type="text" name="task" value="${todos.task}" required>
		                <button type="submit" class="sub-btn">저장</button>
		                <button type="button" class="cancel-btn">취소</button>
		            </form>
		
		            <!-- 버튼 그룹 -->
		            <div class="button-group">
		                <button type="button" class="edit-btn">수정</button>
		                <form action="/api/deletetodo/${todos.id}" method="POST" style="display:inline;">
		                    <button type="submit" class="delete-btn" data-id="${todos.id}">삭제</button>
		                </form>
		                <button type="button" class="map-btn">
		                    <img src="../images/map-icon.png" style="width:15px; height:15px;">
		                </button>
		            </div>
		        </li>
		    </c:forEach>
		</ul>
	</div>
	
</body>
</html>