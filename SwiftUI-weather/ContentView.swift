//
//  ContentView.swift
//  SwiftUI-weather
//
//  Created by Abdul Momin on 18/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var is_night = false
    
    var weathers : [weatherDay] = [
        weatherDay(dayName: "TUE", dayTemperature: 76, weatherImage: "cloud.sun.fill"),
        weatherDay(dayName: "WED", dayTemperature: 88, weatherImage: "sun.max.fill"),
        weatherDay(dayName: "THU", dayTemperature: 55, weatherImage: "wind.snow"),
        weatherDay(dayName: "FRI", dayTemperature: 60, weatherImage: "sunset.fill"),
        weatherDay(dayName: "SAT", dayTemperature: 25, weatherImage: "snowflake")
    ]
    
    var body: some View {
        ZStack {
            
            BackgroundView(isNight: is_night)
            VStack{
                
                CityTextView(cityName: "Gulapbag, Shibganj")
                
                MainWeatherStatusView(imageName: is_night ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                
                HStack(spacing: 30){
                    WeatherDayView(weathers: weathers)
                }

                Spacer()
                
                Button{
                    // holds codes for actions
                    is_night.toggle()   // update is_night boolean value when clicked
                }label: {
                    // designing the button
                    WeatherButton(title: "Change Day Time",
                                  textColor: .blue,
                                  backgroundColor: .white)
                }
                
                Spacer()   // you can add at most 10 Views in your root views (ZStack)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
     }
}

struct WeatherDayView: View {
    
    var weathers : [weatherDay]
    var body: some View {
        
        ForEach(weathers) { weather in
            VStack{
                Text(weather.dayName)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                Image(systemName: weather.weatherImage)
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    //.foregroundStyle(.white, .yellow, .black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text("\(weather.dayTemperature)°")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
            }
        }
      
    }
}

struct BackgroundView: View {
    
    var isNight : Bool
    
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
//                       startPoint: .topLeading, endPoint: .bottomTrailing)
//        .ignoresSafeArea(.all)
        
        // in app build in gradient
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
        
    }
}


struct CityTextView : View {
    
    var cityName : String
    
    var body: some View{
        Text(cityName)
            .font(.system(size: 32, weight: .semibold, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}


struct MainWeatherStatusView : View {
    
    var imageName : String
    var temperature : Int
    
    var body: some View{
        VStack(spacing: 8){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 50)
    }
}


struct weatherDay: Identifiable {
    var id = UUID()
    var dayName: String
    var dayTemperature: Int
    var weatherImage: String
}


