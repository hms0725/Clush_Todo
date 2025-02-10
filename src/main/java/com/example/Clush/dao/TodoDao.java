package com.example.Clush.dao;

import java.util.List;
import java.util.Optional;

import com.example.Clush.model.Todo;

public interface TodoDao {

	List<Todo> getAllTodos();
	int addTodo(Todo task);
	int deleteTodo(Long id);
	String updateTodo(Todo todo);
	Todo getTodoMap(String taskId);
	int todoDone(Long todoId, Integer done);

}
