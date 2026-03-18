public class Integration_WeatherBitResponseWrapper{
	public data[] data;
	public class data {
		public Double app_temp;	//33.6
		public Integer aqi;	//67
		public String city_name;	//Raleigh
		public Integer clouds;	//25
		public String country_code;	//US
		public String date_time;	//2025-09-05:17
		public Double dewpt;	//22.4
		public Integer dhi;	//120
		public Integer dni;	//916
		public Double elev_angle;	//60.41
		public Integer ghi;	//908
		public Double gust;	//3.6
		public Integer h_angle;	//15
		public Double lat;	//35.7796
		public Double lon;	//-78.6382
		public String ob_time;	//2025-09-05 17:20
		public String pod;	//d
		public Integer precip;	//0
		public Double pres;	//1003.9
		public Integer rh;	//63
		public Integer slp;	//1017
		public Integer snow;	//0
		public Double solar_rad;	//901.5
		
		public String state_code;	//NC
		public String station;	//1327W
		public String sunrise;	//10:48
		public String sunset;	//23:34
		public Double temp;	//30.1
		public String timezone;	//America/New_York
		public Integer ts;	//1757092800
		public Integer uv;	//7
		public Integer vis;	//16
		public weather weather;
		public String wind_cdir;	//WSW
		public String wind_cdir_full;	//west-southwest
		public Integer wind_dir;	//243
		public Double wind_spd;	//1.3
	}

	public class weather {
		public String description;	//Few clouds
		public Integer code;	//801
		public String icon;	//c02d
	}
}