<?php
/**
 * Class WxQrcode
 * 小程序生成太阳码
 */
class WxQrcode
{

    /**
     * @param $appid
     * @param $appsecret
     * @return mixed
     * 获取accessToken
     */
    public function getAccessToken($appid,$appsecret)
    {
        $tokenUrl="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$appid."&secret=".$appsecret;
        $getArr=array();
        $tokenArr=json_decode($this->send_post($tokenUrl,$getArr,"GET"));
        $access_token=$tokenArr->access_token;
        return $access_token;
    }

    /**
     * 验证access_token是否有效
     * 这里调用微信接口如果失效则获取新的验证access_token是否有效 或者 将验证access_token是否有效存入数据库做判断也可以
     */
    protected function checkWXToken($access_token){
        //请求微信不限制调用次数的接口
        $ipurl = "https://api.weixin.qq.com/cgi-bin/getcallbackip?access_token=".$access_token;
        $ipresult = $this->getSSLPage($ipurl);
        $ipdata = json_decode($ipresult,true);

        if($ipdata['errcode'] == '40001'){
            file_put_contents('access_token.txt',date('Y-m-d H:i:s').' access_token提前失效，进入二次获取token'.PHP_EOL,FILE_APPEND);
            $access_token = $this->getAccessToken();
        }
        return $access_token;
    }

    /**
     * @return string
     * 生成小程序太阳码
     */
    public function getQrcode()
    {
        $appid = '';
        $appsecret = '';

        $url = "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=".$this->getAccessToken($appid, $appsecret);
        //生成二维码图片
        $da['page'] = 'pagesActivity/activityRcmdBooks/activityRcmdBooks'; //小程序路径地址,不写默认跳首页
        $da['width'] = 430;  //二维码大小
        $da['scene'] = "id=2"; //页面传参
        //{"errcode":47001,"errmsg":"data format error hint: [WqXQEA06804522]"}   josn格式不正确索性直接转成json
        /* $post_data='{"path":"'. $data['path'].'",
                      "width":'.$data['width'].',
                      "scene":'.$data['scene'].'
                      }';*/
        $post_data = json_encode($da);
        //这里会直接生成base64图片.直接写成文件就可以 打印会显示乱码
        $result=$this->api_notice_increment($url,$post_data);
        // dump($result);die;
        $dir = 'qrcode/';
        //判断目录是否存在
        if(is_dir($dir))
        {
            $filename =  $dir.uniqid().'.png';
        } else {
            mkdir($dir);
            $filename =  $dir.uniqid().'.png';
        }
        //生成唯一文件名
        $file =uniqid().'.png';
        //写入文件
        file_put_contents('qrcode/'.$file,$result);
        return $filename;
    }

    /**
     * @param $file
     * 删除文件
     */
    public function delQrcode($file)
    {
        //这里传入的$file 是我这边存入数据库的图片.调用unlink函数删除服务器上的图片文件
        $path = ROOT_PATH .'public'.$file;
        if (file_exists($path)) {
            unlink ($path);
        };
    }

    /**
     * @param $url
     * @param $data
     * @return bool|string
     */
    protected function api_notice_increment($url, $data){

        $ch = curl_init();

        $header = "Accept-Charset: utf-8";

        curl_setopt($ch, CURLOPT_URL, $url);

        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        //curl_setopt($ch,  CURLOPT_HTTPHEADER, $header);

        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');

        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);

        curl_setopt($ch, CURLOPT_AUTOREFERER, 1);

        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $tmpInfo = curl_exec($ch);

        if (curl_errno($ch)) {
            return false;
        }else{
            return $tmpInfo;die;
        }

    }

    /**
     * @param $url
     * @param $post_data
     * @param string $method
     * @return false|string
     * 发送post请求
     */
    protected function send_post($url, $post_data,$method='POST') {

        $postdata = http_build_query($post_data);

        $options = array(

            'http' => array(

                'method' => $method, //or GET

                'header' => 'Content-type:application/x-www-form-urlencoded',

                'content' => $postdata,

                'timeout' => 15 * 60 // 超时时间（单位:s）

            )

        );

        $context = stream_context_create($options);

        $result = file_get_contents($url, false, $context);

        return $result;

    }

    /**
     * @param $url
     * @return bool|string
     *
     */
    protected function getSSLPage($url)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSLVERSION, 30);
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }
}

$o = new WxQrcode();
$o->getQrcode();
