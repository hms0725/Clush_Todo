package com.example.Clush.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.example.Clush.model.Todo;
import com.example.Clush.service.TodoService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class TodoController {
	
	private final TodoService todoService;
	
	
	//할일 조회
	@Operation(
			summary = "기존 할 일 목록 조회", 
			description = "전체 할 일 목록을 조회합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "요청 성공"),
        @ApiResponse(responseCode = "400", description = "잘못된 요청"),
        @ApiResponse(responseCode = "500", description = "서버 에러")
    })
	@GetMapping(value="/")
	public String getAllTodos(Model model){
		System.out.println("Controller getAllTodos start..");
		List<Todo> todos = todoService.getAllTodos();	
		model.addAttribute("todos",todos);
		return "TodoView";
	}

	
	//할일 추가
	@Operation(
			summary = "할 일 추가", 
			description = "새로운 할 일을 추가합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "할 일 추가 성공"),
        @ApiResponse(responseCode = "400", description = "잘못된 요청")
    })
	@PostMapping("/api/addtodo")
	@ResponseBody
	public Map<String, Object> addTodo(@RequestBody Todo todo) {
		System.out.println("controller addtodo start..");	
		System.out.println("controller addTodo task->"+todo);
		todoService.addTodo(todo);
		
		Map<String, Object> response = new HashMap<>();	
		response.put("success",true);
		response.put("todo", todo); //추가된 할 일 반환			
		return response;
	}	

	
	//해당 할일 삭제
	@Operation(
			summary = "할 일 삭제", 
			description = "선택한 특정 할 일을 삭제합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "할 일 삭제 성공"),
        @ApiResponse(responseCode = "500", description = "서버 에러")
    })
	@PostMapping("/api/deletetodo/{id}")
	public String deleteTodo(@PathVariable("id") Long id, Model model) {
		System.out.println("controller deleteTodo start..");
		System.out.println("controller deleteTodo id->"+id);
		todoService.deleteTodo(id);
		
		List<Todo> todos = todoService.getAllTodos();
		model.addAttribute("todos",todos);
		return "TodoView";
	}
	
	
	//해당 할일 수정
	@Operation(
			summary = "할 일 수정", 
			description = "특정 할 일의 내용을 수정합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "할 일 수정 성공"),
        @ApiResponse(responseCode = "500", description = "서버 에러")
    })
	@PostMapping("/api/updatetodo/{id}")
	public String updateTodo(@PathVariable("id") Long id,@RequestParam("task")String task, Model model) {
		System.out.println("controller updateTodo start..");
		System.out.println("controller updateTodo id->"+id);
		System.out.println("controller updateTodo task->"+task);
		
		Todo todo = new Todo();
		todo.setId(id);
		todo.setTask(task);		
		todoService.updateTodo(todo);
		
		List<Todo> todos = todoService.getAllTodos();
		model.addAttribute("todos",todos);
		return "TodoView";
	}
	
	
	//할일에 대한 지도위치조회
	@Operation(
			summary = "할 일의 지도 위치 조회", 
			description = "특정 할 일에 대한 지도 위치 정보를 조회합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "위치 정보 조회 성공")
    })
	@GetMapping("/api/locations/{taskId}")
	public ResponseEntity<Todo> getTodoMap(@PathVariable String taskId) {
		Todo location = todoService.getTodoMap(taskId);
							//task를 기반으로 위치정보를 조회하는 서비스메서드
		if(location !=null) {
			return ResponseEntity.ok(location);
		}else {
			return ResponseEntity.notFound().build();
		}
	}
	
	
	//할 일 완료여부
	@Operation(
			summary = "할 일 완료 상태 업데이트", 
			description = "특정 할 일의 완료 상태를 업데이트합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "상태 업데이트 성공"),
        @ApiResponse(responseCode = "500", description = "서버 에러")
    })
	@PostMapping("/api/todoDone/{todoId}")
	@ResponseBody
	public ResponseEntity<String> todoDone(
			@PathVariable("todoId") Long todoId, 
			@RequestBody Map<String, Integer> requestBody){
		Integer done = requestBody.get("done");
		int isUpdated = todoService.todoDone(todoId, done);
		if(isUpdated!=0) {
			return ResponseEntity.ok("상태 업데이트 성공");
		}else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("상태 업데이트 실패");
		}	
	}
	
	
	// 404 오류 처리
    @ResponseStatus(HttpStatus.NOT_FOUND)
    @RequestMapping("/404")
    public String handle404() {
        return "error"; 
    }

    // 500 오류 처리
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @RequestMapping("/500")
    public String handle500() {
        return "error"; 
    }
}
