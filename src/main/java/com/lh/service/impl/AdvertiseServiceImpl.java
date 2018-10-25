package com.lh.service.impl;

import com.lh.bean.Advertisement;
import com.lh.bean.AdvertisementExample;
import com.lh.mapper.AdvertisementMapper;
import com.lh.service.AdvertiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@CacheConfig(cacheNames = "advertisement")
public class AdvertiseServiceImpl implements AdvertiseService {
    @Autowired
    AdvertisementMapper mapper;
    @Override
    public void add(Advertisement advertisement) {
        mapper.insert(advertisement);
    }

    @Override
    public void delete(int aid) {
        mapper.deleteByPrimaryKey(aid);
    }

    @Override
    @CacheEvict(allEntries = true)
    public void update(Advertisement advertisement) {
        mapper.updateByPrimaryKey(advertisement);
    }

    @Override
    @Cacheable(key = "'advertisements:'+#p0")
    public Advertisement get(int id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    @Cacheable(key = "'advertisements'")
    public List<Advertisement> list() {
        AdvertisementExample example = new AdvertisementExample();
        example.setOrderByClause("id");
        return mapper.selectByExample(example);
    }
}
