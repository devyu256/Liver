//
//  LiverData.swift
//  liver
//
//  Created by 島田雄介 on 2023/05/01.
//

import SwiftUI
//クラスをObservableObjectとして定義
class LiverData :ObservableObject{
//UserDefaults.standard.set(変数名,  forkey: "Stringのキー")
    @Published var regDate: String {
        didSet {UserDefaults.standard.set(regDate, forKey: "regDate")}}
    @Published var regYear: Int {
        didSet {UserDefaults.standard.set(regYear, forKey: "regYear")}}
    @Published var regWeek: Int {
        didSet {UserDefaults.standard.set(regWeek, forKey: "regWeek")}}
    @Published var days: Int {
        didSet {UserDefaults.standard.set(days, forKey: "days")}}
    @Published var weeks: Int {
        didSet {UserDefaults.standard.set(weeks, forKey: "weeks")}}
    @Published var count: Int {
        didSet {UserDefaults.standard.set(count, forKey: "count")}}

    //初期化する
    init(){
        regDate = UserDefaults.standard.string(forKey: "regDate") ?? ""
        regYear = UserDefaults.standard.integer(forKey: "regYear")
        regWeek = UserDefaults.standard.integer(forKey: "regWeek")
        days = UserDefaults.standard.integer(forKey: "days")
        weeks = UserDefaults.standard.integer(forKey: "weeks")
        count = UserDefaults.standard.integer(forKey: "count")
    }
}
