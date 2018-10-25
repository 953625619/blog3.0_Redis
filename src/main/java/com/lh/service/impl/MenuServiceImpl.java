package com.lh.service.impl;

import com.lh.bean.Menu;
import com.lh.bean.MenuExample;
import com.lh.mapper.MenuMapper;
import com.lh.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@CacheConfig(cacheNames = "menu")
public class MenuServiceImpl implements MenuService {
    @Autowired
    MenuMapper menuMapper;
    @Override
    public void add(Menu menu) {
        menuMapper.insertSelective(menu);
    }

    @Override
    public void delete(int id) {
        menuMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Menu menu) {
        menuMapper.updateByPrimaryKeySelective(menu);
    }

    @Override
    public Menu get(int id) {
        return menuMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Menu> list() {
        MenuExample example = new MenuExample();
        example.setOrderByClause("id desc");
        return menuMapper.selectByExample(example);
    }

    @Override
    @Cacheable(key = "'menus'")
    public List<Menu> listByRole(int role) {
        MenuExample example = new MenuExample();
        example.setOrderByClause("id desc");
        example.createCriteria().andMenuRoleEqualTo(role);
        return menuMapper.selectByExample(example);
    }
}
