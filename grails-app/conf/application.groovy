// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.grailsdemos.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.grailsdemos.UserRole'
grails.plugin.springsecurity.authority.className = 'com.grailsdemos.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']],
    [pattern: '/login/**',       access: ['permitAll']],
    [pattern: '/logout/**',      access: ['permitAll']],
    [pattern: '/register/**',    access: ['permitAll']],
    [pattern: '/userManagement/**', access: ['ROLE_ADMIN']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

// 自定义登录和登出配置
grails.plugin.springsecurity.auth.loginFormUrl = '/login/index'
grails.plugin.springsecurity.apf.filterProcessesUrl = '/login/authenticate'
grails.plugin.springsecurity.failureHandler.defaultFailureUrl = '/login/authFail'
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/'
grails.plugin.springsecurity.successHandler.alwaysUseDefault = false
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.logout.afterLogoutUrl = '/'

// 启用用户密码加密
grails.plugin.springsecurity.password.algorithm = 'bcrypt'
grails.plugin.springsecurity.password.hash.iterations = 10

// 添加登录失败URL重定向
grails.plugin.springsecurity.failureHandler.exceptionMappings = [
    [exception: 'org.springframework.security.authentication.BadCredentialsException', url: '/login/authFail'],
    [exception: 'org.springframework.security.authentication.LockedException', url: '/login/authFail'],
    [exception: 'org.springframework.security.authentication.DisabledException', url: '/login/authFail'], 
    [exception: 'org.springframework.security.authentication.AccountExpiredException', url: '/login/authFail'],
    [exception: 'org.springframework.security.authentication.CredentialsExpiredException', url: '/login/authFail']
]

// 配置自定义登出处理器
grails.plugin.springsecurity.logout.handlerNames = [
    'rememberMeServices', 
    'securityContextLogoutHandler', 

]

