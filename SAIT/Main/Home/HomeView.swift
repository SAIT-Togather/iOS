//
//  HomeView.swift
//  SAIT
//
//  Created by 이머영 on 11/12/26.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
    @State private var relationshipStartDate: Date? = HomeMockData.relationshipStartDate
    
    @State private var currentDate = Date()
    
    @EnvironmentObject private var scheduleStore: ScheduleStore
    
    @EnvironmentObject private var memoryStore: MemoryStore
    
    var body: some View {
        ZStack {
            // 전체 화면 배경
            SAITColors.background
                .ignoresSafeArea()
            
            // 홈 화면 콘텐츠
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - Header
                    
                    HomeHeaderView {
                        // TODO: 추후 알림 화면으로 변경
                    }
                    
                    // MARK: - Couple Card
                    
                    CoupleCardView(
                        daysTogether: daysTogether,
                        relationshipStartDate: relationshipStartDate
                    )
                    
                    VStack(spacing: 12) {
                        
                        // MARK: - Anniversary Card
                       
                        AnniversaryCardView(
                            days: nextAnniversary?.days,
                            date: nextAnniversary?.date,
                            remainingDays: nextAnniversary?.remainingDays
                        )
                        
                        // MARK: - Next Date Card
                        
                        NextDateCardView(
                            schedule: nextDateSchedule,
                            remainingDays: nextDateSchedule.map {
                                DateCalculator.remainingDays(
                                    until: $0.date,
                                    from: currentDate
                                )
                            }
                        )
                    }
                    
                    // MARK: - Recent Memories
                    
                    RecentMemoriesView(memories: recentMemories) {
                        // TODO: 추억 탭으로 이동
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .onAppear {
            currentDate = Date()
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.significantTimeChangeNotification
            )
        ) { _ in
            currentDate = Date()
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.didBecomeActiveNotification
            )
        ) { _ in
            currentDate = Date()
        }
        .task (id: nextDateSchedule?.date) {
            guard let targetDate = nextDateSchedule?.date else {
                return
            }
            
            let delay = targetDate.timeIntervalSinceNow
            
            if delay > 0 {
                do {
                    try await Task.sleep(for: .seconds(delay))
                } catch {
                    return
                }
            }
            
            guard !Task.isCancelled else {
                return
            }
            
            currentDate = Date()
        }
    }
    
    // MARK: - 연애 일수
    
    private var daysTogether: Int? {
        guard let startDate = relationshipStartDate else {
            return nil
        }
        
        return DateCalculator.daysTogether(
            from: startDate,
            to: currentDate
        )
    }
    
    // MARK: - 다음 기념일
    
    private var nextAnniversary: Anniversary? {
        guard let startDate = relationshipStartDate else {
            return nil
        }
        
        return DateCalculator.nextAnniversary(
            from: startDate,
            today: currentDate
        )
    }
    
    // MARK: - 다음 데이트
    
    private var nextDateSchedule: CoupleSchedule? {
        scheduleStore.nextSchedule(from: currentDate)
    }
    
    // MARK: - 최근 추억 정렬
    
    private var recentMemories: [CoupleMemory] {
        Array(
            memoryStore.memories
                .sorted { $0.date > $1.date }
                .prefix(3)
        )
    }
    
}

#Preview {
    HomeView()
        .environmentObject(
            ScheduleStore(
                schedules: CalendarMockData.schedules
            )
        )
        .environmentObject(
            MemoryStore(
                memories: MemoryMockData.memories
            )
        )
}
