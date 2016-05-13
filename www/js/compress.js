var compress = {
compress: function(success, failure,resultType){
    
    var data = resultType;
   cordova.exec(success, failure, "compress", "compress", [data]);
}
};

module.exports=compress;


