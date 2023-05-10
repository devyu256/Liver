//
//  ContentView.swift
//  liver
//
//  Created by 島田雄介 on 2023/05/01.
//

import SwiftUI
import UIKit
import GoogleMobileAds

struct AdmobBannerViewController : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-3228702018641843/8126126122"
        view.rootViewController = viewController
        view.load(GADRequest())
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentView: View {
    @StateObject private var livers = LiverData()
    var test: Bool = false
    var df = DateFormatter()
    var today = Date()
    
    func startFunc() -> Void {
        
//                print("start")
//                print(livers.regDate)
//                print(livers.regYear)
//                print(livers.regWeek)
//                print(livers.days)
//                print(livers.weeks)
//
//                livers.regDate = "2023/05/03"
//                livers.regYear = 2023
//                livers.regWeek = 18
//                livers.days = 3
//                livers.weeks = 1
        
        var calendar = Calendar(identifier: .gregorian)
        var lastYearWeekNumber = 0
        var gapWeek = 0
        var todayWeekNumber = 0
        calendar.locale = Locale(identifier: "ja_JP")
        df.dateStyle = .short
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        let day = df.string(from: today)
        //        day = "2024/01/10"
        
        //本日の年、月、日
        let arr:[String] = day.components(separatedBy: "/")
        let component = DateComponents(year: Int(arr[0]), month: Int(arr[1]), day: Int(arr[2]))
        let date = Calendar.current.date(from: component)
        //本日の週数
        todayWeekNumber = calendar.component(.weekOfYear, from: date!)
        //        print(todayWeekNumber)
        //前年の12月31日の週数を計算
        //前年度
        let lastYear = (Int(arr[0]) ?? 9999) - 1
        let lastComponent = DateComponents(year: lastYear, month: 12, day: 31)
        let lastDate = Calendar.current.date(from: lastComponent)
        
        lastYearWeekNumber = calendar.component(.weekOfYear, from: lastDate!)
        //        print(lastYearWeekNumber)
        //週数が1(年始の場合)
        if todayWeekNumber == 1 {
            //前年度である場合
            if livers.regYear == lastYear {
                if livers.regWeek == lastYearWeekNumber {
                    if livers.days >= livers.count {
                        livers.weeks += 1
                        livers.days = 0
                    } else {
                        livers.weeks = 0
                        livers.days = 0
                    }
                } else {
                    livers.weeks = 0
                    livers.days = 0
                }
            } else if livers.regYear == Int(arr[0]){
                return
            } else {
                livers.weeks = 0
                livers.days = 0
            }
        } else {
            if livers.regYear == Int(arr[0]) {
                //同年、同週の場合、何もしない
                if livers.regWeek == todayWeekNumber {
                    return
                    //同年、別週
                } else {
                    //週数の差分
                    gapWeek = todayWeekNumber - livers.regWeek
                    //翌週の場合
                    if gapWeek == 1 {
                        if livers.days >= livers.count {
                            livers.weeks += 1
                            livers.days = 0
                        } else {
                            livers.weeks = 0
                            livers.days = 0
                        }
                    } else {
                        livers.weeks = 0
                        livers.days = 0
                    }
                }
                //別年
            } else {
                livers.weeks = 0
                livers.days = 0
            }
        }
    }
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .center){
                Picker(selection: $livers.count, label: Text("目標日数")) {
                    Text("1").tag(1).foregroundColor(Color.white)
                    Text("2").tag(2).foregroundColor(Color.white)
                    Text("3").tag(3).foregroundColor(Color.white)
                    Text("4").tag(4).foregroundColor(Color.white)
                    Text("5").tag(5).foregroundColor(Color.white)
                    Text("6").tag(6).foregroundColor(Color.white)
                    Text("7").tag(7).foregroundColor(Color.white)
                }
                .pickerStyle(WheelPickerStyle())
                Text("\(livers.days) - \(livers.weeks)").foregroundColor(Color.white).font(.system(size: 100, weight: .black, design: .default))
                Spacer()
                Button(action:{
                    let day = df.string(from: today)
                    let arr:[String] = day.components(separatedBy: "/")
                    var todayWeekNumber = 0
                    let calendar = Calendar(identifier: .gregorian)
                    let component = DateComponents(year: Int(arr[0]), month: Int(arr[1]), day: Int(arr[2]))
                    let date = Calendar.current.date(from: component)
                    //本日の週数
                    todayWeekNumber = calendar.component(.weekOfYear, from: date!)
                    
                    if day == livers.regDate {
                        //何もしない
                    } else {
                        livers.days += 1
                        livers.regDate = day
                        livers.regYear = Int(arr[0]) ?? 9999
                        livers.regWeek = todayWeekNumber
                    }
                }, label:{ Text("").font(.system(size: 50, weight: .black, design: .default))
                        .padding()
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                    .clipShape(Circle())})
                
                
                Spacer()
                AdmobBannerView()
            }.onAppear{
                startFunc()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
