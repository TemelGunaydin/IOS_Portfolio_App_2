import SwiftUI

struct ContentView: View {
    // because structs are value type, when ui is updated, the whole struct is recreated, so we need to use @State to keep track of the state
    // ui will update if below changed because it is marked with state
    @State private var isNight = false

    var body: some View {
        ZStack {
            // color view is push out view
            // customBlue is created in Assets as a custom color
            // Binding is used to pass the state of the struct to the child view
            // Because BackgroundView is a view inside the ContentView it is considered to be the child of it
            // So to pass the state from the parent to the child we use @Binding
            // UPDATE : WE ARE NOT CHANGING THE STATE OF THE PARENT VIEW, SO WE DONT NEED TO USE @Binding
            // $ means two way Binding
            // BackgroundView(isNight: $isNight)
            BackgroundView(isNight: isNight)

            VStack(alignment: .center) {
                CityView(cityName: "Cuppertino,CA")

                WeatherView(weatherStatus: isNight ? "moon.stars.fill" : "cloud.sun.fill")

                HStack(spacing: 10) {
                    DayWeather(dayOfTheWeek: .mon, weather: "cloud.sun.fill", degree: "76°")
                    DayWeather(dayOfTheWeek: .tue, weather: "cloud.drizzle", degree: "45°")
                    DayWeather(dayOfTheWeek: .wed,
                               weather: "cloud.drizzle.circle", degree: "27°")
                    DayWeather(dayOfTheWeek: .thu,
                               weather: "cloud.heavyrain", degree: "98°")
                    DayWeather(dayOfTheWeek: .fri,
                               weather: "sun.min.fill", degree: "12°")
                    DayWeather(dayOfTheWeek: .sat,
                               weather: "sun.max.fill", degree: "67°")
                    DayWeather(dayOfTheWeek: .sun,
                               weather: "cloud.fill", degree: "34°")
                }
                .padding(.top)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .semibold, design: .default))

                Spacer()

                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton()
                }

                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

private struct DayWeather: View {
    var dayOfTheWeek: DaysOfTheWeek
    var weather: String
    var degree: String

    var body: some View {
        VStack(spacing: 10) {
            Text(dayOfTheWeek.rawValue)
            Image(systemName: weather)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(degree)
        }
    }
}

private struct BackgroundView: View {
    // Binding is used to pass the state of the struct to the child view
    // UPDATE : WE ARE NOT CHANGING THE STATE OF THE PARENT VIEW, SO WE DONT NEED TO USE @Binding
    // @Binding var isNight: Bool

    var isNight: Bool
    var body: some View {
        // Below is more customizable than ContainerRelativeShape
        // LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : .customBlue]), startPoint: .top, endPoint: .bottom)
        //     .ignoresSafeArea()

        // ios 16 comes with gradient modifer. So we can use it instead of LinearGradient.
        // but it wont be customizable as LinearGradient
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.customBlue.gradient)
            .ignoresSafeArea()
    }
}

private struct CityView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .bold, design: .default))
            .foregroundStyle(.white)
            .padding(.top, 50)
    }
}

private struct WeatherView: View {
    var weatherStatus: String
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: weatherStatus)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit) // more customizable than scaletofit()
                .frame(width: 180, height: 180)

            Text("76°") // option shift 8 makes degree symbol
                .font(.system(size: 65, weight: .light, design: .rounded))
                .foregroundStyle(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

// variable for image name and temperature not created on purpose. Other views have variables.
private struct WeatherButton: View {
    var body: some View {
        Text("Change Day Time")
            .font(.system(size: 20, weight: .bold))
            .frame(width: 300, height: 50)
            .foregroundStyle(.blue)
            .background(.white)
            .cornerRadius(10)
    }
}
