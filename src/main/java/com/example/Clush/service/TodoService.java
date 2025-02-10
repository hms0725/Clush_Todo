package com.example.Clush.service;

import java.util.List;
import java.util.Optional;

import com.example.Clush.model.Todo;

public interface TodoService {

	List<Todo> getAllTodos();
	int addTodo(Todo task);
	int deleteTodo(Long id);
	String updateTodo(Todo todo);
	Todo getTodoMap(String taskId);
	int todoDone(Long todoId, Integer done);

}
