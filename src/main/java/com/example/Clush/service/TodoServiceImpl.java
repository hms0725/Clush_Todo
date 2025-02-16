package com.example.Clush.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Clush.dao.TodoDao;
import com.example.Clush.model.Todo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TodoServiceImpl implements TodoService{
	
	private final TodoDao todoDao;

	//할일조회
	@Override
	public List<Todo> getAllTodos() {
		System.out.println("Service getAllTodos start..");
		return todoDao.getAllTodos();
	}

	//할일추가
	@Override
	public int addTodo(Todo todo) {
		System.out.println("Service addTodo start..");
		System.out.println("Service addTodo todo->"+todo);
		int addtask = todoDao.addTodo(todo);
		System.out.println("Service addTodo todo->"+todo);
		return addtask;
	}

	//할일삭제
	@Override
	public int deleteTodo(Long id) {
		System.out.println("Service deleteTodo start..");
		System.out.println("Service deleteTodo id->"+id);
		return todoDao.deleteTodo(id);	
	}

	//할일수정
	@Override
	public String updateTodo(Todo todo) {
		System.out.println("Service updateTodo start..");
		System.out.println("Service updateTodo todo->"+todo);	
		return todoDao.updateTodo(todo);
	}

	//위치조회
	@Override
	public Todo getTodoMap(String taskId) {
		System.out.println("Service getTodoMap start..");
		System.out.println("Service getTodoMap taskId->"+taskId);
		Todo location = todoDao.getTodoMap(taskId);
		System.out.println("Service getTodoMap location->"+location);
		return location;
	}

	//완료여부
	@Override
	public int todoDone(Long todoId, Integer done) {
		System.out.println("Service todoDone start..");
		System.out.println("Service todoDone todoId.."+todoId);
		System.out.println("Service todoDone done.."+done);
		return todoDao.todoDone(todoId, done);
	}




	

	

}
