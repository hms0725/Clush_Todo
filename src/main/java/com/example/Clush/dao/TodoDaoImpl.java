package com.example.Clush.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.cursor.Cursor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.Clush.model.Todo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class TodoDaoImpl implements TodoDao{
	
	private final SqlSession session;

	//할일조회
	@Override
	public List<Todo> getAllTodos() {
		System.out.println("TodoDao getAllTodos start..");
		List<Todo> todoList = null;
		try {
			System.out.println("Session ->"+session); //session 객체 확인
			todoList = session.selectList("com.example.Clush.mapper.TodoMapper.getAllTodos");
			System.out.println("TodoDao getAllTodos todoList->"+todoList);
		} catch (Exception e) {
			System.out.println("TodoDao getAllTodos error->"+e.getMessage());
		}
		return todoList;
	}

	//할일추가
	@Override
	public int addTodo(Todo todo) {
		System.out.println("TodoDao addTodo start..");
		System.out.println("TodoDao addTodo todo->"+todo);//null
		int addtask = 0;
		try {
			addtask = session.insert("com.example.Clush.mapper.TodoMapper.addTodo",todo);
			System.out.println("TodoDao addTodo addtask->"+addtask);
		} catch (Exception e) {
			System.out.println("TodoDao addTodo error->"+e.getMessage());
		}
		return addtask;
	}

	//할일삭제
	@Override
	public int deleteTodo(Long id) {
		System.out.println("TodoDao deleteTodo start..");
		System.out.println("TodoDao deleteTodo id->"+id);
		int result = 0;
		try {
			result = session.delete("com.example.Clush.mapper.TodoMapper.deleteTodo",id);
			System.out.println("TodoDao deleteTodo result ->"+result);
		} catch (Exception e) {
			System.out.println("TooDao deleteTodo error->"+e.getMessage());
		}
		return result;
	}

	//할일수정
	@Override
	public String updateTodo(Todo todo) {
		System.out.println("TodoDao updateTodo start..");
		System.out.println("TodoDao updateTodo todo->"+todo);
		int task = 0;
		try {
			task = session.update("com.example.Clush.mapper.TodoMapper.updateTodo",todo);
		} catch (Exception e) {
			System.out.println("TodoDao updateTodo error->"+e.getMessage());
		}
		
		return null;
	}

	//위치조회
	@Override
	public Todo getTodoMap(String taskId) {
		System.out.println("todoDao getTodoMap start..");
		System.out.println("todoDao getTodoMap taskId->"+taskId);
		Todo location = null;
		try {
			location = session.selectOne("com.example.Clush.mapper.TodoMapper.getTodoMap",taskId);
			System.out.println("todoDao getTodoMap location->"+location);
		} catch (Exception e) {
			System.out.println("todoDao getTodoMap error->"+e.getMessage());
		}
		return location;
	}

	//완료여부
	@Override
	public int todoDone(Long todoId, Integer done) {
		System.out.println("Dao todoDone start..");
		System.out.println("Dao todoDone todoId->"+todoId);
		System.out.println("Dao todoDone done->"+done);
		int result = 0;
		try {
			result = session.update("com.example.Clush.mapper.TodoMapper.todoDone", Map.of("done",done,"todoId",todoId));
			System.out.println("Dao todoDone result->"+result);
		} catch (Exception e) {
			System.out.println("Dao todoDone error->"+e.getMessage());
		}
		return result;
	}



	

	
	
	

}
