








package com.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import com.alibaba.fastjson.JSONObject;
import java.util.*;
import org.springframework.beans.BeanUtils;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;
import com.service.TokenService;
import com.utils.StringUtil;
import java.lang.reflect.InvocationTargetException;

import com.service.DictionaryService;
import org.apache.commons.lang3.StringUtils;
import com.annotation.IgnoreAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.*;
import com.entity.view.*;
import com.service.*;
import com.utils.PageUtils;
import com.utils.R;
import com.alibaba.fastjson.*;

/**
 * 项目管理员
 * 后端接口
 * @author
 * @email
*/
@RestController
@Controller
@RequestMapping("/xiangmuguanliyuan")
public class XiangmuguanliyuanController {
    private static final Logger logger = LoggerFactory.getLogger(XiangmuguanliyuanController.class);

    @Autowired
    private XiangmuguanliyuanService xiangmuguanliyuanService;


    @Autowired
    private TokenService tokenService;
    @Autowired
    private DictionaryService dictionaryService;

    //级联表service

    @Autowired
    private YonghuService yonghuService;
    @Autowired
    private ZhuanjiaService zhuanjiaService;


    /**
    * 后端列表
    */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, HttpServletRequest request){
        logger.debug("page方法:,,Controller:{},,params:{}",this.getClass().getName(),JSONObject.toJSONString(params));
        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isEmpty(role))
            return R.error(511,"权限为空");
        else if("用户".equals(role))
            params.put("yonghuId",request.getSession().getAttribute("userId"));
        else if("项目管理员".equals(role))
            params.put("xiangmuguanliyuanId",request.getSession().getAttribute("userId"));
        else if("专家账户".equals(role))
            params.put("zhuanjiaId",request.getSession().getAttribute("userId"));
        params.put("xiangmuguanliyuanDeleteStart",1);params.put("xiangmuguanliyuanDeleteEnd",1);
        if(params.get("orderBy")==null || params.get("orderBy")==""){
            params.put("orderBy","id");
        }
        PageUtils page = xiangmuguanliyuanService.queryPage(params);

        //字典表数据转换
        List<XiangmuguanliyuanView> list =(List<XiangmuguanliyuanView>)page.getList();
        for(XiangmuguanliyuanView c:list){
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(c, request);
        }
        return R.ok().put("data", page);
    }

    /**
    * 后端详情
    */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id, HttpServletRequest request){
        logger.debug("info方法:,,Controller:{},,id:{}",this.getClass().getName(),id);
        XiangmuguanliyuanEntity xiangmuguanliyuan = xiangmuguanliyuanService.selectById(id);
        if(xiangmuguanliyuan !=null){
            //entity转view
            XiangmuguanliyuanView view = new XiangmuguanliyuanView();
            BeanUtils.copyProperties( xiangmuguanliyuan , view );//把实体数据重构到view中

            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view, request);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }

    }

    /**
    * 后端保存
    */
    @RequestMapping("/save")
    public R save(@RequestBody XiangmuguanliyuanEntity xiangmuguanliyuan, HttpServletRequest request){
        logger.debug("save方法:,,Controller:{},,xiangmuguanliyuan:{}",this.getClass().getName(),xiangmuguanliyuan.toString());

        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isEmpty(role))
            return R.error(511,"权限为空");
        Wrapper<XiangmuguanliyuanEntity> queryWrapper = new EntityWrapper<XiangmuguanliyuanEntity>()
            .eq("username", xiangmuguanliyuan.getUsername())
            .or()
            .eq("xiangmuguanliyuan_phone", xiangmuguanliyuan.getXiangmuguanliyuanPhone())
            .or()
            .eq("xiangmuguanliyuan_id_number", xiangmuguanliyuan.getXiangmuguanliyuanIdNumber())
            .andNew()
            .eq("xiangmuguanliyuan_delete", 1)
            ;


        XiangmuguanliyuanEntity xiangmuguanliyuanEntity = xiangmuguanliyuanService.selectOne(queryWrapper);
        if(xiangmuguanliyuanEntity==null){
            xiangmuguanliyuan.setXiangmuguanliyuanDelete(1);
            xiangmuguanliyuan.setCreateTime(new Date());
            xiangmuguanliyuan.setPassword("123456");
            xiangmuguanliyuanService.insert(xiangmuguanliyuan);
            return R.ok();
        }else {
            return R.error(511,"账户或者联系电话或者项目管理员身份证号已经被使用");
        }
    }

    /**
    * 后端修改
    */
    @RequestMapping("/update")
    public R update(@RequestBody XiangmuguanliyuanEntity xiangmuguanliyuan, HttpServletRequest request){
        logger.debug("update方法:,,Controller:{},,xiangmuguanliyuan:{}",this.getClass().getName(),xiangmuguanliyuan.toString());

        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isEmpty(role))
            return R.error(511,"权限为空");
        //根据字段查询是否有相同数据
        Wrapper<XiangmuguanliyuanEntity> queryWrapper = new EntityWrapper<XiangmuguanliyuanEntity>()
            .notIn("id",xiangmuguanliyuan.getId())
            .andNew()
            .eq("username", xiangmuguanliyuan.getUsername())
            .or()
            .eq("xiangmuguanliyuan_phone", xiangmuguanliyuan.getXiangmuguanliyuanPhone())
            .or()
            .eq("xiangmuguanliyuan_id_number", xiangmuguanliyuan.getXiangmuguanliyuanIdNumber())
            .andNew()
            .eq("xiangmuguanliyuan_delete", 1)
            ;


        XiangmuguanliyuanEntity xiangmuguanliyuanEntity = xiangmuguanliyuanService.selectOne(queryWrapper);
        if("".equals(xiangmuguanliyuan.getXiangmuguanliyuanPhoto()) || "null".equals(xiangmuguanliyuan.getXiangmuguanliyuanPhoto())){
                xiangmuguanliyuan.setXiangmuguanliyuanPhoto(null);
        }
        if(xiangmuguanliyuanEntity==null){
            //  String role = String.valueOf(request.getSession().getAttribute("role"));
            //  if("".equals(role)){
            //      xiangmuguanliyuan.set
            //  }
            xiangmuguanliyuanService.updateById(xiangmuguanliyuan);//根据id更新
            return R.ok();
        }else {
            return R.error(511,"账户或者联系电话或者项目管理员身份证号已经被使用");
        }
    }

    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
        logger.debug("delete:,,Controller:{},,ids:{}",this.getClass().getName(),ids.toString());
        ArrayList<XiangmuguanliyuanEntity> list = new ArrayList<>();
        for(Integer id:ids){
            XiangmuguanliyuanEntity xiangmuguanliyuanEntity = new XiangmuguanliyuanEntity();
            xiangmuguanliyuanEntity.setId(id);
            xiangmuguanliyuanEntity.setXiangmuguanliyuanDelete(2);
            list.add(xiangmuguanliyuanEntity);
        }
        if(list != null && list.size() >0){
            xiangmuguanliyuanService.updateBatchById(list);
        }
        return R.ok();
    }

    /**
    * 登录
    */
    @IgnoreAuth
    @RequestMapping(value = "/login")
    public R login(String username, String password, String captcha, HttpServletRequest request) {
        XiangmuguanliyuanEntity xiangmuguanliyuan = xiangmuguanliyuanService.selectOne(new EntityWrapper<XiangmuguanliyuanEntity>().eq("username", username));
        if(xiangmuguanliyuan==null || !xiangmuguanliyuan.getPassword().equals(password))
            return R.error("账号或密码不正确");
        else if(xiangmuguanliyuan.getXiangmuguanliyuanDelete() != 1)
            return R.error("账户已被删除");
        //  // 获取监听器中的字典表
        // ServletContext servletContext = ContextLoader.getCurrentWebApplicationContext().getServletContext();
        // Map<String, Map<Integer, String>> dictionaryMap= (Map<String, Map<Integer, String>>) servletContext.getAttribute("dictionaryMap");
        // Map<Integer, String> role_types = dictionaryMap.get("role_types");
        // role_types.get(.getRoleTypes());
        String token = tokenService.generateToken(xiangmuguanliyuan.getId(),username, "xiangmuguanliyuan", "项目管理员");
        R r = R.ok();
        r.put("token", token);
        r.put("role","项目管理员");
        r.put("username",xiangmuguanliyuan.getXiangmuguanliyuanName());
        r.put("tableName","xiangmuguanliyuan");
        r.put("userId",xiangmuguanliyuan.getId());
        return r;
    }

    /**
    * 注册
    */
        @IgnoreAuth
        @PostMapping(value = "/register")
        public R register(@RequestBody XiangmuguanliyuanEntity xiangmuguanliyuan){
    //    	ValidatorUtils.validateEntity(user);
        Wrapper<XiangmuguanliyuanEntity> queryWrapper = new EntityWrapper<XiangmuguanliyuanEntity>()
		    .eq("username", xiangmuguanliyuan.getUsername())
		    .or()
            .eq("xiangmuguanliyuan_phone", xiangmuguanliyuan.getXiangmuguanliyuanPhone())
		    .or()
            .eq("xiangmuguanliyuan_id_number", xiangmuguanliyuan.getXiangmuguanliyuanIdNumber())
            .andNew()
            .eq("xiangmuguanliyuan_delete", 1)
            ;
        XiangmuguanliyuanEntity xiangmuguanliyuanEntity = xiangmuguanliyuanService.selectOne(queryWrapper);
        if(xiangmuguanliyuanEntity != null)
            return R.error("账户或者联系电话或者项目管理员身份证号已经被使用");
                xiangmuguanliyuan.setXiangmuguanliyuanDelete(1);
        xiangmuguanliyuan.setCreateTime(new Date());
        xiangmuguanliyuanService.insert(xiangmuguanliyuan);
        return R.ok();
    }

    /**
     * 重置密码
     */
    @GetMapping(value = "/resetPassword")
    public R resetPassword(Integer  id){
        XiangmuguanliyuanEntity xiangmuguanliyuan = new XiangmuguanliyuanEntity();
        xiangmuguanliyuan.setPassword("123456");
        xiangmuguanliyuan.setId(id);
        xiangmuguanliyuanService.updateById(xiangmuguanliyuan);
        return R.ok();
    }

    /**
    * 获取用户的session用户信息
    */
    @RequestMapping("/session")
    public R getCurrXiangmuguanliyuan(HttpServletRequest request){
        Integer id = (Integer)request.getSession().getAttribute("userId");
        XiangmuguanliyuanEntity xiangmuguanliyuan = xiangmuguanliyuanService.selectById(id);
        if(xiangmuguanliyuan !=null){
            //entity转view
            XiangmuguanliyuanView view = new XiangmuguanliyuanView();
            BeanUtils.copyProperties( xiangmuguanliyuan , view );//把实体数据重构到view中

            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view, request);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }
    }


    /**
    * 退出
    */
    @GetMapping(value = "logout")
    public R logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return R.ok("退出成功");
    }





}
