//
//  MainTabView.swift
//  SAIT
//
//  Created by 이머영 on 11/12/26.
//

import SwiftUI

struct MainTabView: View {
    
    // 현재 선택된 탭
    @State private var selectedTab: MainTab = .home
    
    @StateObject private var scheduleStore = ScheduleStore(
        schedules: CalendarMockData.schedules
    )
    
    @StateObject private var memoryStore = MemoryStore(
        memories: MemoryMockData.memories
    )
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            CalendarView()
                .tabItem {
                    Label("캘린더", systemImage: "calendar")
                }
                .tag(MainTab.calendar)
            
            MemoryView()
                .tabItem {
                    Label("추억", systemImage: "photo")
                }
                .tag(MainTab.memory)
            
            HomeView(
                onShowMemories: {
                    selectedTab = .memory
                }
            )
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
                .tag(MainTab.home)
            
            PlaceView()
                .tabItem {
                    Label("장소", systemImage: "mappin")
                }
                .tag(MainTab.place)
            
            MyPageView()
                .tabItem {
                    Label("MY", systemImage: "person")
                }
                .tag(MainTab.myPage)
        }
        .tint(SAITColors.primary)
        .environmentObject(scheduleStore)
        .environmentObject(memoryStore)
    }
}

// MARK: - Main tab

enum MainTab: Hashable {
    case calendar
    case memory
    case home
    case place
    case myPage
}

#Preview {
    MainTabView()
}
