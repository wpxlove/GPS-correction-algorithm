const double a = 6378245.0;  
const double ee = 0.00669342162296594323;  
const double pi = 3.14159265358979324;  
  
+(double *)transformFromWGSToGCJ:(double)longitude and:(double)latitude  
{  
  
    if([self isLocationOutOfChina:longitude and:latitude]){  
        double are[] = {longitude ,latitude} ;  
        return are ;  
    }else{  
        double adjustLat = [self transformLatWithX:longitude - 105.0 withY:latitude - 35.0];  
        double adjustLon = [self transformLonWithX:longitude - 105.0 withY:latitude - 35.0];  
        double radLat = latitude / 180.0 * pi;  
        double magic = sin(radLat);  
        magic = 1 - ee * magic * magic;  
        double sqrtMagic = sqrt(magic);  
        adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);  
        adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);  
  
  
        double jiupian_longitude = longitude + adjustLon ;  
  
        double jiupian_latitude= latitude + adjustLat ;  
        double are[] = {jiupian_longitude ,jiupian_latitude} ;  
        return are ;  
    }  
  
}  
  
//判斷是不是在中國 
+(BOOL)isLocationOutOfChina:(double)longitude and:(double)latitude  
{  
    if (longitude < 72.004 || longitude > 137.8347 || latitude < 0.8293 ||latitude > 55.8271)  
        return YES;  
    return NO;  
}  
  
+(double)transformLatWithX:(double)x withY:(double)y  
{  
    double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x));  
    lat += (20.0 * sin(6.0 * x * pi) + 20.0 *sin(2.0 * x * pi)) * 2.0 / 3.0;  
    lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;  
    lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y *pi / 30.0)) * 2.0 / 3.0;  
    return lat;  
}  
  
+(double)transformLonWithX:(double)x withY:(double)y  
{  
    double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));  
    lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;  
    lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;  
    lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;  
    return lon;  
} 