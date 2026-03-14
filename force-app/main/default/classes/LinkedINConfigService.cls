public  class LinkedINConfigService {
    private static LinkedIn_Config__mdt config;
    public static LinkedIn_Config__mdt get(){
        if(config==null){
            config=LinkedIn_Config__mdt.getInstance('Default');
        }
        return config;
    }
}