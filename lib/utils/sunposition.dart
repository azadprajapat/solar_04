import 'dart:math';

import 'package:solar04/modals/locationModel.dart';

class SunAngle{
  final azimuth;
  final elevation;
  SunAngle({this.azimuth,this.elevation});
}
SunAngle getsunpos (DateTime time,la,long){
  var jd,jde, helioclongitude,geosolarlongitude,rightascesion;
  var declination,hourangle,topocrightacension,topocdelination;
  var topochourangle,elevationnorefration,refractioncorrection;
  var lat,lon,pressure,temperature;
  var deltat=0.0;
  double zenith,azimuth;
 var ut=time.hour-5.5;
   int  year=time.year;
  int month=time.month;
  int day=time.day;
  double dyear,dmonth;
  lat=double.parse(la)*pi/180;
  lon=double.parse(long)*pi/180;
  pressure=1;
  temperature=25;
  if(month<=2){
    dyear=year.toDouble()-1;
    dmonth=month.toDouble()+12;
  }
  else{
    dyear=year.toDouble();
    dmonth=month.toDouble();
  }
  double k,j;
  if(365.25*(dyear-2000.0)>0.0)
    k=(365.25*(dyear-2000.0)).floorToDouble();
  else
    k=(365.25*(dyear-2000.0)).ceilToDouble();

  if(30.6001*(dmonth+1.0)>0)
    j=(30.6001*(dmonth+1.0)).floorToDouble();
  else
    j=(30.6001*(dmonth+1.0)).ceilToDouble();
  double jdt = (k)+(j)+day.toDouble()+ut/24.0-1158.5;
  double t = jdt + deltat/86400;
  jde = t + 2452640.0;
  jd = jdt+2452640.0;
  double ang = 1.72019e-2*t-.0563;
  helioclongitude = 1.740940 + 1.7202768683e-2*t + 3.34118e-2*sin(ang) + 3.488e-4*sin(2*ang);
  helioclongitude += 3.13e-5*sin(2.127730e-1*t-.585);
  helioclongitude += 1.26e-5*sin(4.243e-3*t+1.46) + 2.35e-5*sin(1.0727e-2*t+.72)+
      2.76e-5*sin(1.5799e-2*t+2.35)+2.75e-5*sin(2.1551e-2*t-1.98)+1.26e-5*sin(3.1490e-2*t-.80);
  double t2 = t/1000;
  helioclongitude += (((-2.30796e-07*t2 + 3.7976e-06)*t2 - 2.0458e-05)*t2 + 3.976e-05)*t2*t2;
  double deltapsi = 8.33e-5*sin(9.252e-4*t - 1.173);
  double epsilon = -6.21e-9*t + 0.409086+4.46e-5*sin(9.252e-4*t+.397);
  geosolarlongitude = helioclongitude+pi+deltapsi-9.932e-5;
  double slambda = sin(geosolarlongitude);
  rightascesion = atan2(slambda*cos(epsilon),cos(geosolarlongitude));
  declination = asin(sin(epsilon)*slambda);
  hourangle = 6.30038809903*jdt+4.8824623+deltapsi*.9174+lon-rightascesion;
  double clat = cos(lat);
  double slat = sin(lat);
  double ch = cos(hourangle);
  double sh = sin(hourangle);
  double dalpha = -4.26e-5*clat*sh;
  topocrightacension = rightascesion + dalpha;
  topochourangle = hourangle-dalpha;
  topocdelination = declination - 4.26e-5*(slat-declination*clat);
  double sdeltacorr = sin(topocdelination);
  double cdeltacorr = cos(topocdelination);
  double chcorr = ch+dalpha*sh;
  double shcorr = sh-dalpha*ch;
  elevationnorefration = asin(slat*sdeltacorr+clat*cdeltacorr*chcorr);
  final double elevmin = -.01;
  if(elevationnorefration>elevmin)
    refractioncorrection = .084217*pressure/(273+temperature)/tan(elevationnorefration+.0031376/(elevationnorefration+.089186));
  else
    refractioncorrection=0;
  zenith = pi/2 - elevationnorefration - refractioncorrection;
  azimuth = atan2(shcorr,chcorr*slat-sdeltacorr/cdeltacorr*clat);
  azimuth=azimuth*180/pi;
  zenith=zenith*180/pi;

  azimuth=180+azimuth;
  zenith=90-zenith;
SunAngle _sun=new SunAngle(azimuth: azimuth,elevation: zenith);
return _sun;
}
